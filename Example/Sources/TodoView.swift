import NeoBrutalism
import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

private enum TodoSort: String, CaseIterable {
    case manual = "Manual"
    case az = "A–Z"
    case incompleteFirst = "Incomplete First"
}

/// The flagship screen: a plausible day-one todo app. Every control here is styled by the single
/// `.neoBrutalism(theme:)` call at the bottom of `body`. Two deliberate exceptions:
/// `.toggleStyle(.neoBrutalismCheckbox)` on the list (the root default is the switch, per T10),
/// and one `.neoBrutalism(type: .neutral)` button variant for the secondary "delete all" action.
struct TodoAppView: View {
    @State private var todos: [Todo] = [
        Todo(title: "Buy groceries for the week", isCompleted: false),
        Todo(title: "Finish Q3 budget review", isCompleted: true),
        Todo(title: "Walk the dog", isCompleted: true),
        Todo(title: "Reply to Sarah's email", isCompleted: false),
        Todo(title: "Book dentist appointment", isCompleted: false),
        Todo(title: "Renew passport", isCompleted: true),
        Todo(title: "Read one chapter before bed", isCompleted: false)
    ]
    @State private var newTodoText: String = ""
    @State private var sort: TodoSort = .manual
    @State private var isConfirmingDeleteAll = false
    @Environment(\.nbTheme) private var theme

    private var completedCount: Int {
        todos.filter(\.isCompleted).count
    }

    private var progress: Double {
        todos.isEmpty ? 0 : Double(completedCount) / Double(todos.count)
    }

    /// Bindings into `todos`, reordered for display without disturbing the underlying array —
    /// each element still points at its original storage, so toggling/deleting/adding stays
    /// correct no matter which sort is active.
    private var sortedTodos: [Binding<Todo>] {
        let bindings = todos.indices.map { $todos[$0] }
        switch sort {
        case .manual:
            return bindings
        case .az:
            return bindings.sorted {
                $0.wrappedValue.title.localizedCaseInsensitiveCompare($1.wrappedValue.title) == .orderedAscending
            }
        case .incompleteFirst:
            return bindings.sorted { !$0.wrappedValue.isCompleted && $1.wrappedValue.isCompleted }
        }
    }

    var body: some View {
        VStack(spacing: theme.spacing) {
            header
                .padding(.horizontal, theme.padding)
                .padding(.top, theme.padding)

            progressHeader
                .padding(.horizontal, theme.padding)

            if todos.isEmpty {
                emptyState
                    .padding(.horizontal, theme.padding)
                Spacer()
            } else {
                todoList
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .neoBrutalism(theme: theme)
        .nbDialog("Delete all tasks?", isPresented: $isConfirmingDeleteAll) {
            Button("Delete All", role: .destructive) {
                todos.removeAll()
                isConfirmingDeleteAll = false
            }
            Button("Keep") {
                isConfirmingDeleteAll = false
            }
        } message: {
            Text("This clears every task on your list. This action cannot be undone.")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: theme.spacing) {
            HStack {
                Text("Todo")
                    .font(.largeTitle.bold())
                Spacer()
                sortMenu
                Button {
                    isConfirmingDeleteAll = true
                } label: {
                    Image(systemName: "trash")
                }
                .buttonStyle(.neoBrutalism(type: .neutral))
                .disabled(todos.isEmpty)
                .accessibilityLabel("Delete all tasks")
            }

            HStack {
                TextField("Add a task…", text: $newTodoText)
                    .onSubmit(addTodo)

                Button(action: addTodo) {
                    Image(systemName: "plus")
                        .frame(maxHeight: .infinity)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var progressHeader: some View {
        VStack(alignment: .leading, spacing: theme.smspacing) {
            Text("\(completedCount) of \(todos.count) done")
                .font(.subheadline.weight(.semibold))
            ProgressView(value: progress)
        }
    }

    private var sortMenu: some View {
        NBMenu {
            NBMenuItem("Manual") { sort = .manual }
            NBMenuItem("A–Z") { sort = .az }
            NBMenuItem("Incomplete First") { sort = .incompleteFirst }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
        }
        .accessibilityLabel("Sort: \(sort.rawValue)")
    }

    private var emptyState: some View {
        NBAlert {
            Text("Add your first task above to get started.")
                .italic()
        } icon: {
            Image(systemName: "checklist")
        } head: {
            Text("No tasks yet")
        }
    }

    private var todoList: some View {
        List {
            ForEach(sortedTodos, id: \.wrappedValue.id) { $todo in
                TodoRow(todo: $todo)
                    .nbListRow()
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            todos.removeAll { $0.id == todo.id }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(theme.destructive)
                    }
            }
        }
        .listStyle(.plain)
        .nbList()
        // Without an explicit style, List reserves extra leading/trailing margin beyond
        // `nbListRow`'s own insets, so rows render narrower than the header above them;
        // `.plain` removes that. `contentMargins` similarly zeroes the default top/bottom
        // inset, which otherwise shows up as a gap between the progress bar and the first row.
        .contentMargins(.vertical, 0, for: .scrollContent)
        // Root default is the switch (native Toggle semantics, T10); rows here read as
        // checkboxes instead — the one deliberate variant, applied once, this screen needs.
        .toggleStyle(.neoBrutalismCheckbox)
    }

    private func addTodo() {
        let title = newTodoText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return }
        todos.append(Todo(title: title, isCompleted: false))
        newTodoText = ""
    }
}

private struct TodoRow: View {
    @Binding var todo: Todo
    @Environment(\.nbTheme) private var theme

    var body: some View {
        Toggle(isOn: $todo.isCompleted) {
            Text(todo.title)
                .strikethrough(todo.isCompleted)
                .foregroundStyle(theme.text.opacity(todo.isCompleted ? 0.5 : 1))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TodoAppView()
        .nbTheme(.default)
}
