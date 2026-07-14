import NeoBrutalism
import SwiftUI

struct AccordianExampleView: View {
    var body: some View {
        NBAccordion {
            Text("Piertotum Locomotor")
        } content: {
            Text("Pratimo Jeevit Bhavh - प्रतिमा जीवित भाव")
        }

        NBAccordion {
            Text("Expecto Patronum")
        } content: {
            Text("Pitradev Sanrakshanam - पितृदेव संरक्षणम्")
        }
    }
}

struct CheckboxExampleView: View {
    @State var checkboxState = true

    var body: some View {
        Toggle(isOn: $checkboxState) {
            Spacer()
            Text(checkboxState ? "(Alohomora!)" : "(Colloportus!)")
        }
        .toggleStyle(.neoBrutalismCheckbox)
        HStack {
            Toggle(isOn: .constant(true)) {}
                .disabled(true)
            Toggle(isOn: .constant(false)) {}
                .disabled(true)
            Spacer()
            Text("Petrificus Totalus!")
                .italic()
        }.toggleStyle(.neoBrutalismCheckbox)
    }
}

struct SwitchExampleView: View {
    @State var switchState = true

    var body: some View {
        VStack(spacing: 12.0) {
            Toggle(isOn: $switchState) {
                Text(switchState ? "(Lumos!)" : "(Nox!)")
                    .italic()
            }
            Toggle("Invisibility Cloak", isOn: .constant(true))
            Toggle("Muggle Mode", isOn: .constant(false))
        }.toggleStyle(.neoBrutalismSwitch)
    }
}

struct AlertExampleView: View {
    var body: some View {
        VStack(spacing: 18.0) {
            NBAlert("Warning", message: "The Chamber of Secrets has been opened. Enemies of the heir, beware!",
                    systemImage: "exclamationmark.triangle")

            NBAlert("Caution", message: "Dementors are nearby. Expecto Patronum!", type: .neutral)

            // Builder form (showing it still exists for custom View types)
            NBAlert {
                Text("This form allows any View types for the title, message, or icon—useful when you need custom styling.")
            } icon: {
                Image(systemName: "star.fill")
            } head: {
                Text("Flexible")
            }
        }
    }
}

struct BadgeExampleView: View {
    var body: some View {
        HStack {
            NBBadge {
                Text("Gryffindor")
                    .font(.title3)
            }
            NBBadge(type: .neutral) {
                Text("Slytherin")
            }
        }
    }
}

struct ButtonExampleView: View {
    @State var counter: Int = 0

    var body: some View {
        HStack(spacing: 12.0) {
            Button {
                counter += 1
            } label: {
                Text("Accio")
            }.buttonStyle(.neoBrutalism())

            Button {
                counter += 1
            } label: {
                Text("Expelliarmus")
            }.buttonStyle(.neoBrutalism(variant: .reverse))

            Button {
                counter += 1
            } label: {
                Image(systemName: "wand.and.sparkles.inverse")
                    .bold()
            }.buttonStyle(.neoBrutalism(type: .neutral, variant: .reverse))
        }
        Text("(Spells Cast: \(counter))")
            .italic()
    }
}

struct GroupBoxExampleView: View {
    var body: some View {
        VStack(spacing: 28.0) {
            GroupBox("Hogwarts Letter") {
                Text("You have been accepted to Hogwarts School of Witchcraft and Wizardry!")

                Button {
                    // No-op
                } label: {
                    Text("Open Letter").frame(maxWidth: .infinity)
                }.buttonStyle(.neoBrutalism())
            }
            .groupBoxStyle(.neoBrutalism())

            GroupBox("Quidditch Gear") {
                Text("Get your broomstick, Quidditch robes, and golden snitch!")

                HStack(spacing: 12.0) {
                    Button {
                        // No-op
                    } label: {
                        Text("Open Firebolt")
                    }.buttonStyle(.neoBrutalism(type: .neutral))

                    Spacer()

                    Button {
                        // No-op
                    } label: {
                        Text("Snitch")
                    }.buttonStyle(.neoBrutalism())
                }
            }
            .groupBoxStyle(.neoBrutalism(type: .neutral))

            GroupBox {
                Text("Quidditch Tryouts - This Saturday! (flat)")
            }
            .groupBoxStyle(.neoBrutalism(elevated: false))

            GroupBox {
                Text("O.W.L. Exams Approaching - Study Hard!")
            }
            .groupBoxStyle(.neoBrutalism(type: .neutral, elevated: false))
        }
    }
}

struct InputExampleView: View {
    @State var text: String = ""
    @State var password: String = ""
    @State var notes: String = ""

    var body: some View {
        VStack {
            TextField("Input", text: .constant("Wingardium Leviosa"))
                .disabled(true)
                .textFieldStyle(.neoBrutalism)

            TextField("Enter your spell", text: $text)
                .textFieldStyle(.neoBrutalism)

            SecureField("Password", text: $password)
                .textFieldStyle(.neoBrutalism)

            TextEditor(text: $notes)
                .nbTextEditor()
                .frame(height: 100)

            Text("(You just cast: \(text))")
                .italic()
        }
    }
}

struct ProgressExampleView: View {
    var body: some View {
        VStack(spacing: 12) {
            ProgressView(value: 0.7)
                .progressViewStyle(.neoBrutalism)

            ProgressView { Text("Loading...") }
                .progressViewStyle(.neoBrutalism)
        }
    }
}

struct SliderExampleView: View {
    @State var volume: Double = 30

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Volume")
                Spacer()
                Text("\(Int(volume))%")
                    .font(.headline)
            }
            NBSlider(value: $volume, in: 0...100, step: 5)
        }
    }
}

struct RadioGroupExampleView: View {
    @State private var selectedSpell: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text("Selected Spell: \(selectedSpell)")
                .font(.title3)

            NBRadioGroup(value: $selectedSpell) {
                VStack(alignment: .leading) {
                    NBRadioItem(value: 0) {
                        Text("Expelliarmus")
                    }
                    NBRadioItem(value: 1) {
                        Text("Lumos")
                    }
                    NBRadioItem(value: 2) {
                        Text("Wingardium Leviosa")
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct SkeletonExampleView: View {
    @State private var isLoading = true

    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            GroupBox {
                NBRoundSkeleton()
            }
            .groupBoxStyle(.neoBrutalism(elevated: false))
            .frame(width: 120, height: 120)

            HStack {
                Text("Loading Content")
                Spacer()
                Toggle(isOn: $isLoading) {}
                    .toggleStyle(.neoBrutalismSwitch)
            }

            HStack(spacing: 12.0) {
                NBRoundSkeleton()
                    .frame(width: 48, height: 48)

                VStack(alignment: .leading, spacing: 4.0) {
                    Text("Profile Name")
                        .font(.headline)
                    Text("@username")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            .nbSkeleton(active: isLoading)
        }
    }
}

struct TabsExampleView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 8.0) {
            Text("House Selection: \(selectedTab)")
                .font(.title3)

            NBTabView(selection: $selectedTab) {
                NBTab(value: 0) {
                    GroupBox { Text("Bravery and Daring!") }
                } label: {
                    Image(systemName: "flame.fill")
                }
                NBTab(value: 1) {
                    GroupBox { Text("Cunning and Ambition!") }
                } label: {
                    Image(systemName: "lanyardcard.fill")
                }
                NBTab(value: 2) {
                    GroupBox { Text("Wisdom and Learning!") }
                } label: {
                    Image(systemName: "book.fill")
                }
                NBTab(value: 3) {
                    GroupBox { Text("Loyalty and Hard Work!") }
                } label: {
                    Image(systemName: "leaf.fill")
                }
            }
            .groupBoxStyle(.neoBrutalism(elevated: false))
        }
    }
}

struct CollapsableExampleView: View {
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 16.0) {
            Text("Room of Requirement")
                .font(.title)

            NBCollapsable(isExpanded: $isExpanded) {
                GroupBox {
                    HStack {
                        Text("Need something?")
                        Spacer()
                        NBCollapsibleTrigger {
                            Image(systemName: isExpanded ? "door.left.hand.open" : "door.left.hand.closed")
                        }
                    }
                }
                .groupBoxStyle(.neoBrutalism(elevated: false))
                NBCollapsableContent {
                    GroupBox {
                        Text("Here’s what you need!")
                    }
                    .groupBoxStyle(.neoBrutalism(type: .neutral, elevated: false))
                }
            }
        }
    }
}

struct DrawerExampleView: View {
    @State private var isDrawerOpen: Bool = false

    var body: some View {
        VStack(spacing: 16.0) {
            Button {
                isDrawerOpen.toggle()
            } label: {
                Text("Open the Chamber")
            }.buttonStyle(.neoBrutalism())
        }
        .nbDrawer(isPresented: $isDrawerOpen) {
            VStack(spacing: 16) {
                Text("Parseltongue Required")
                    .font(.title2)

                Text("Only those who can speak to snakes may proceed.")
                    .padding(.horizontal, 4.0)

                Button {
                    isDrawerOpen.toggle()
                } label: {
                    Text("I Understand")
                }.buttonStyle(.neoBrutalism())
            }
        }
    }
}

// MARK: - Navigation

struct NavigationExampleView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16.0) {
                Text("Welcome to the Great Hall")
                    .font(.title2)
                    .padding()

                Button("Browse Spells") {}
                    .buttonStyle(.neoBrutalism())

                Button("View Potions", action: {})
                    .buttonStyle(.neoBrutalism(type: .neutral))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationTitle("Navigation")
            .nbNavigationBar()
        }
    }
}

// MARK: - Dialog

struct DialogExampleView: View {
    @State private var isDialogOpen: Bool = false

    var body: some View {
        VStack(spacing: 16.0) {
            Button {
                isDialogOpen.toggle()
            } label: {
                Text("Open Dialog")
            }.buttonStyle(.neoBrutalism())
        }
        .nbDialog("Delete this memory?", isPresented: $isDialogOpen) {
            Button("Delete", role: .destructive) {
                isDialogOpen = false
            }
            Button("Keep") {
                isDialogOpen = false
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }
}

// MARK: - Label Style

struct LabelStyleExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Gryffindor Common Room", systemImage: "flame.fill")
                .labelStyle(.neoBrutalism)
            Label("Potions Class", systemImage: "flask.fill")
                .labelStyle(.neoBrutalism)
        }
    }
}

// MARK: - Gauge Style

struct GaugeStyleExampleView: View {
    var body: some View {
        VStack(spacing: 12) {
            Gauge(value: 0.75) {
                Text("Patronus Power")
            }
            .gaugeStyle(.neoBrutalism)
        }
    }
}

// MARK: - Menu Style

struct MenuStyleExampleView: View {
    var body: some View {
        NBMenu {
            NBMenuItem("Holly & Phoenix Feather", systemImage: "wand.and.stars") {}
            NBMenuItem("Elder & Thestral Hair", systemImage: "wand.and.stars") {}
            NBMenuItem("Vine & Dragon Heartstring", systemImage: "wand.and.stars") {}
            NBMenuItem("Snap It", systemImage: "trash", role: .destructive) {}
        } label: {
            Text("Choose Your Wand")
        }
    }
}

// MARK: - Control Group Style

struct ControlGroupStyleExampleView: View {
    var body: some View {
        ControlGroup {
            Button("Lumos") {}
            Button("Nox") {}
            Button("Accio") {}
        }
        .controlGroupStyle(.neoBrutalism)
    }
}

// MARK: - Labeled Content Style

struct LabeledContentStyleExampleView: View {
    var body: some View {
        VStack(spacing: 12) {
            LabeledContent("House", value: "Gryffindor")
                .labeledContentStyle(.neoBrutalism)
            LabeledContent("Patronus", value: "Stag")
                .labeledContentStyle(.neoBrutalism)
        }
    }
}

// MARK: - Stepper

struct StepperExampleView: View {
    @State private var cauldronCount: Int = 3
    @State private var potion: Int = 0

    var body: some View {
        VStack(spacing: 12) {
            NBStepper("Cauldrons", value: $cauldronCount, in: 0...10)
            Text("Brewing \(cauldronCount) potions tonight")
                .italic()

            Divider()
                .padding(.vertical, 8)

            NBStepper("Galleons", value: $potion, in: 0...100, step: 10)
            Text("Step by 10")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Segmented Picker

struct SegmentedPickerExampleView: View {
    @State private var selectedHouse: String = "Gryffindor"

    var body: some View {
        VStack(spacing: 12) {
            NBSegmentedPicker(selection: $selectedHouse) {
                Text("Gryffindor").nbSegment("Gryffindor")
                Text("Slytherin").nbSegment("Slytherin")
                Text("Ravenclaw").nbSegment("Ravenclaw")
            }
            Text("Chosen: \(selectedHouse)")
                .italic()
        }
    }
}

// MARK: - Root Modifier Demo

struct RootModifierExampleView: View {
    // Read the ambient theme so this demo re-uses the gallery's palette instead of
    // resetting to the default (blue) theme the way a bare `.neoBrutalism()` would.
    @Environment(\.nbTheme) private var theme
    @State private var spellActive = true
    @State private var incantation = "Expecto Patronum"

    var body: some View {
        VStack(spacing: 14) {
            Button("Cast Spell") {}
            Toggle("Shield Charm", isOn: $spellActive)
            TextField("Incantation", text: $incantation)
            ProgressView(value: 0.6)
            Gauge(value: 0.6) { Text("Mana") }
            Label("Spellbook", systemImage: "book.fill")
            LabeledContent("House", value: "Gryffindor")
            NBMenu {
                NBMenuItem("Holly & Phoenix Feather", systemImage: "wand.and.stars") {}
                NBMenuItem("Elder & Thestral Hair", systemImage: "wand.and.stars") {}
            } label: {
                Text("Choose Wand")
            }
            ControlGroup {
                Button("Lumos") {}
                Button("Nox") {}
            }
        }
        .neoBrutalism(theme: theme)
    }
}

struct ListExampleView: View {
    @State private var items = ["Expelliarmus", "Wingardium Leviosa", "Lumos"]
    @State private var spellName = ""
    @State private var notify = true
    @Environment(\.nbTheme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing) {
            sectionLabel("List · native swipe to delete")

            // Height is derived from the (static) row count so the List renders as a
            // self-sizing block inside the gallery's scroll view — no inner scrolling,
            // no clipped last row.
            List {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    Text(item)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .nbListRow()
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                items.remove(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(theme.destructive)
                        }
                }
            }
            .nbList()
            .contentMargins(.vertical, 0, for: .scrollContent)
            .scrollDisabled(true)
            .frame(height: rowsHeight(items.count))

            sectionLabel("Form")

            Form {
                Section {
                    Toggle("Notifications", isOn: $notify)
                        .toggleStyle(.neoBrutalismSwitch)
                        .nbListRow()

                    TextField("Spell name", text: $spellName)
                        .nbListRow()

                    LabeledContent("House") {
                        Text("Gryffindor").bold()
                    }
                    .nbListRow()
                }
            }
            .nbList()
            .contentMargins(.vertical, 0, for: .scrollContent)
            .scrollDisabled(true)
            .frame(height: rowsHeight(3))
        }
    }

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(theme.text.opacity(0.6))
    }

    /// Sizes the (scroll-disabled) List/Form to exactly fit its rows so it reads as a static
    /// block inside the gallery's scroll view — no inner scrolling, no clipped last row and no
    /// dead space below. `row` is the measured per-row stride (card + inter-row spacing).
    private func rowsHeight(_ count: Int) -> CGFloat {
        let row: CGFloat = 68
        return CGFloat(count) * row + theme.smpadding
    }
}

struct SwipeActionsExampleView: View {
    @State private var items: [String] = [
        "Defense Against Dark Arts",
        "Potions",
        "Transfiguration"
    ]
    @Environment(\.nbTheme) private var theme

    // Each swipe row is given a fixed height: `.nbSwipeActions` lays out over a `GeometryReader`,
    // which has no height of its own, so rows in a plain stack need one to keep from collapsing.
    private let rowHeight: CGFloat = 68

    var body: some View {
        // Rows live directly in the gallery's scroll view (no nested ScrollView), so each
        // one can bleed to full width and reveal its action tiles without being clipped.
        VStack(alignment: .leading, spacing: theme.smspacing) {
            Text("Swipe a row left to reveal its actions")
                .font(.caption)
                .foregroundStyle(theme.text.opacity(0.6))

            ForEach(items, id: \.self) { item in
                courseRow(title: item, subtitle: "Course Details", accessory: "chevron.right")
                    .nbSwipeActions(actions: [
                        NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {
                            withAnimation(.interactiveSpring()) {
                                items.removeAll { $0 == item }
                            }
                        }
                    ])
                    .frame(height: rowHeight)
                    // Keep the (initially hidden) action tiles from peeking past the row's
                    // trailing edge while it's at rest; they still slide in on swipe.
                    .clipped()
            }

            courseRow(title: "Favorite Course", subtitle: "Two actions", accessory: "star.fill")
                .nbSwipeActions(actions: [
                    NBSwipeAction("Pin", systemImage: "pin.fill", tint: theme.main) {},
                    NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {}
                ])
                .frame(height: rowHeight)
                .clipped()
        }
    }

    private func courseRow(title: String, subtitle: String, accessory: String) -> some View {
        HStack(spacing: theme.spacing) {
            VStack(alignment: .leading, spacing: 2.0) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(theme.text.opacity(0.6))
            }
            Spacer()
            Image(systemName: accessory)
                .foregroundStyle(theme.text.opacity(0.4))
        }
        // Fill the fixed row height so the row card and the action tiles behind it match
        // exactly — otherwise a taller tile peeks out past the shorter card.
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .nbListRow()
    }
}

struct ContentView: View {
    private enum RootSection: Hashable {
        case gallery, themes, todo
    }

    @State private var selectedSection: RootSection = .gallery
    @State private var colorScheme: ColorScheme = .light
    @State private var themeChoice: ThemeChoice = .defaultBlue
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var reskinAnimation: Animation? {
        reduceMotion ? nil : .interactiveSpring()
    }

    /// The palette that skins the whole screen — the top bar and every tab included. Deriving
    /// it here from the single `themeChoice` (rather than per-tab) is what makes a preset picked
    /// on the Themes tab carry over to Gallery and Todo too, instead of resetting when you
    /// switch tabs.
    private var activeTheme: NBTheme {
        themeChoice.theme
    }

    var body: some View {
        VStack(spacing: 0) {
            topBar

            switch selectedSection {
            case .gallery:
                GalleryView()
            case .themes:
                ThemeGalleryView(selection: $themeChoice)
            case .todo:
                TodoAppView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(activeTheme.background.ignoresSafeArea())
        .nbTheme(activeTheme)
        .colorScheme(colorScheme)
    }

    private var topBar: some View {
        HStack(spacing: activeTheme.smspacing) {
            NBSegmentedPicker(selection: $selectedSection) {
                segmentLabel("Gallery").nbSegment(RootSection.gallery)
                segmentLabel("Themes").nbSegment(RootSection.themes)
                segmentLabel("Todo").nbSegment(RootSection.todo)
            }

            Button {
                withAnimation(reskinAnimation) {
                    colorScheme = colorScheme == .light ? .dark : .light
                }
            } label: {
                // An SF Symbol sizes to its own glyph bounds, which are shorter than the
                // segmented picker's text line-height. Overlaying it on a hidden copy of
                // that same label text forces this button to the same content height.
                segmentLabel("•").hidden().overlay {
                    Image(systemName: colorScheme == .light ? "moon" : "sun.max")
                }
            }
            .buttonStyle(.neoBrutalism(type: .neutral))
        }
        .padding(activeTheme.padding)
    }

    private func segmentLabel(_ title: String) -> some View {
        Text(title)
            .font(.callout.weight(.medium))
            .lineLimit(1)
            .minimumScaleFactor(0.85)
    }
}

/// The original component showcase — every styled control in one scrollable page, each in its
/// own titled card.
private struct GalleryView: View {
    @Environment(\.nbTheme) private var theme

    /// One showcase entry: a title naming the component/API, the demo view, and whether the
    /// gallery should wrap it in a card. Self-contained demos that paint their own surfaces
    /// (List/Form, swipe rows) opt out of the card so they can bleed to full width.
    private struct Demo: Identifiable {
        let id = UUID()
        let title: String
        let boxed: Bool
        let view: AnyView

        init<V: View>(_ title: String, boxed: Bool = true, @ViewBuilder _ view: () -> V) {
            self.title = title
            self.boxed = boxed
            self.view = AnyView(view())
        }
    }

    private var demos: [Demo] {
        [
            Demo("NBAccordion") { AccordianExampleView() },
            Demo("Checkbox") { CheckboxExampleView() },
            Demo("Switch") { SwitchExampleView() },
            Demo("NBAlert") { AlertExampleView() },
            Demo("NBBadge") { BadgeExampleView() },
            Demo("Button") { ButtonExampleView() },
            Demo("GroupBox") { GroupBoxExampleView() },
            Demo("TextField & Editor") { InputExampleView() },
            Demo("ProgressView") { ProgressExampleView() },
            Demo("NBSlider") { SliderExampleView() },
            Demo("NBRadioGroup") { RadioGroupExampleView() },
            Demo("Skeleton") { SkeletonExampleView() },
            Demo("NBTabView") { TabsExampleView() },
            Demo("NBCollapsable") { CollapsableExampleView() },
            Demo("Drawer") { DrawerExampleView() },
            Demo("Navigation Bar") { NavigationExampleView() },
            Demo("Dialog") { DialogExampleView() },
            Demo("Label") { LabelStyleExampleView() },
            Demo("Gauge") { GaugeStyleExampleView() },
            Demo("NBMenu") { MenuStyleExampleView() },
            Demo("ControlGroup") { ControlGroupStyleExampleView() },
            Demo("LabeledContent") { LabeledContentStyleExampleView() },
            Demo("NBStepper") { StepperExampleView() },
            Demo("NBSegmentedPicker") { SegmentedPickerExampleView() },
            Demo("Root Modifier") { RootModifierExampleView() },
            Demo("List & Form", boxed: false) { ListExampleView() },
            Demo("Swipe Actions", boxed: false) { SwipeActionsExampleView() },
        ]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.xlspacing) {
                Text("Neo Brutalism")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(demos) { demo in
                    VStack(alignment: .leading, spacing: theme.smspacing) {
                        Text(demo.title)
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(theme.text.opacity(0.55))

                        if demo.boxed {
                            GroupBox {
                                demo.view
                            }
                            .groupBoxStyle(.neoBrutalism(type: .neutral))
                        } else {
                            demo.view
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(theme.padding)
        }
    }
}

#Preview {
    ContentView()
}
