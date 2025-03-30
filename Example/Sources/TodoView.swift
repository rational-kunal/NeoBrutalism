import NeoBrutalism
import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

struct TodoAppView: View {
    @State private var todos: [Todo] = []
    @State private var newTodoText: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Todo do do do")
                .font(.largeTitle)
                .padding(.horizontal)

            // Add Todo Input
            HStack {
                NBInput(text: $newTodoText, placeholder: "Enter a task...")
                NBButton {
                    Image(systemName: "plus")
                        .frame(maxHeight: .infinity)
                } action: {
                    guard !newTodoText.isEmpty else { return }
                    todos.append(Todo(title: newTodoText, isCompleted: false))
                    newTodoText = ""
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)

            ScrollView {
                // Todo List
                if todos.isEmpty {
                    NBAlert {
                        Text("No tasks yet!")
                            .italic()
                    } icon: {
                        Image(systemName: "exclamationmark.triangle")
                    } head: {
                        Text("Warning")
                    }.padding(.horizontal)
                } else {
                    ForEach(todos) { todo in
                        TodoRow(todo: todo)
                    }.padding(.horizontal)
                }
            }.padding(.top, 4.0)
        }
    }
}

struct TodoRow: View {
    var todo: Todo
    @State var isChecked = false

    var body: some View {
        NBFlatCard {
            HStack {
                NBCheckbox(isOn: $isChecked)
                Text(todo.title)
                    .strikethrough(isChecked)
            }
        }
    }
}
