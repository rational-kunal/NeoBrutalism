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
        HStack {
            Toggle(isOn: .constant(true)) {}
            Toggle(isOn: .constant(false)) {}

            Divider().fixedSize()

            Toggle(isOn: $switchState) {
                Spacer()
                Text(switchState ? "(Lumos!)" : "(Nox!)")
                    .italic()
            }
        }.toggleStyle(.neoBrutalismSwitch)
    }
}

struct AlertExampleView: View {
    var body: some View {
        VStack(spacing: 18.0) {
            NBAlert {
                Text("The Chamber of Secrets has been opened. Enemies of the heir, beware!")
            } icon: {
                Image(systemName: "exclamationmark.triangle")
            } head: {
                Text("Warning")
            }

            NBAlert(type: .neutral) {
                Text("Dementors are nearby. Expecto Patronum!")
            } head: {
                Text("Caution")
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
    @State var sliderValue: CGFloat = 0.0

    var body: some View {
        HStack {
            Text("\(sliderValue, specifier: "%.2f")")
                .frame(width: 50.0, alignment: .leading)
            NBSlider(value: $sliderValue)
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

struct RoundSkeletonExampleView: View {
    var body: some View {
        VStack(spacing: 12.0) {
            GroupBox {
                NBRoundSkeleton()
            }
            .groupBoxStyle(.neoBrutalism(elevated: false))
            .frame(width: 120, height: 120)
        }
    }
}

struct TextSkeletonExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            NBTextSkeleton()

            NBTextSkeleton()
                .frame(width: 120)
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

    var body: some View {
        VStack(spacing: 12) {
            NBStepper("Cauldrons", value: $cauldronCount, in: 0...10)
            Text("Brewing \(cauldronCount) potions tonight")
                .italic()
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
            Menu("Choose Wand") {
                Button("Holly") {}
                Button("Elder") {}
            }
            ControlGroup {
                Button("Lumos") {}
                Button("Nox") {}
            }
        }
        .neoBrutalism()
    }
}

struct ListExampleView: View {
    @State private var items = ["Expelliarmus", "Wingardium Leviosa", "Lumos"]
    @State private var formText = "Spell Name"
    @State private var formToggle = true
    @Environment(\.nbTheme) private var theme

    var body: some View {
        VStack(spacing: 12.0) {
            Text("List Example")
                .font(.headline)

            List {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    Text(item)
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
            .frame(height: 150)

            Text("Form Example")
                .font(.headline)

            Form {
                Section("Settings") {
                    Toggle("Enable Spell Notifications", isOn: $formToggle)
                        .nbListRow()

                    TextField("Spell", text: $formText)
                        .nbListRow()

                    LabeledContent("House") {
                        Text("Gryffindor")
                    }
                    .nbListRow()
                }
            }
            .nbList()
            .frame(height: 180)
        }
        .neoBrutalism()
    }
}

struct ContentView: View {
    @State var colorSceme: ColorScheme = .light
    @State var theme = NBTheme.default.updateBy(
        main: Color(light: .rgb(1.0, 0.42, 0.42), dark: .rgb(1.0, 0.42, 0.42)),
        bw: Color(light: .rgb(1.0, 1.0, 1.0), dark: .rgb(0.129, 0.129, 0.129)),
        background: Color(light: .rgb(0.988, 0.843, 0.843), dark: .rgb(0.153, 0.161, 0.2)),
        fontDesign: .rounded
    )

//    var body: some View {
//        ZStack {
//            theme.background
//                            .ignoresSafeArea()
//            TodoAppView()
//        }
//        .nbTheme(NBTheme.sunnyPeach)
//        .colorScheme(colorSceme)
//    }

    var body: some View {
        let exampleViews: [AnyView] = [
            AnyView(AccordianExampleView()),
            AnyView(CheckboxExampleView()),
            AnyView(SwitchExampleView()),
            AnyView(AlertExampleView()),
            AnyView(BadgeExampleView()),
            AnyView(ButtonExampleView()),
            AnyView(GroupBoxExampleView()),
            AnyView(InputExampleView()),
            AnyView(ProgressExampleView()),
            AnyView(SliderExampleView()),
            AnyView(RadioGroupExampleView()),
            AnyView(RoundSkeletonExampleView()),
            AnyView(TextSkeletonExampleView()),
            AnyView(TabsExampleView()),
            AnyView(CollapsableExampleView()),
            AnyView(DrawerExampleView()),
            AnyView(NavigationExampleView()),
            AnyView(DialogExampleView()),
            AnyView(LabelStyleExampleView()),
            AnyView(GaugeStyleExampleView()),
            AnyView(MenuStyleExampleView()),
            AnyView(ControlGroupStyleExampleView()),
            AnyView(LabeledContentStyleExampleView()),
            AnyView(StepperExampleView()),
            AnyView(SegmentedPickerExampleView()),
            AnyView(RootModifierExampleView()),
            AnyView(ListExampleView()),
        ]

        ZStack {
            theme.background
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: theme.xlspacing) {
                    HStack {
                        Text("Neo Brutalism")
                            .font(.largeTitle)
                        Spacer()
                        Button {
                            withAnimation(.interactiveSpring) {
                                colorSceme = colorSceme == .light ? .dark : .light
                            }
                        } label: {
                            Image(systemName: colorSceme == .light ? "moon" : "sun.max")
                        }.buttonStyle(.neoBrutalism(type: .neutral))
                    }

                    ForEach(0 ..< exampleViews.count, id: \.self) { index in
                        GroupBox {
                            exampleViews[index]
                        }
                        .groupBoxStyle(.neoBrutalism(type: .neutral))
                    }
                }.padding(theme.padding)
            }
        }
        .nbTheme(theme)
        .colorScheme(colorSceme)
    }
}

#Preview {
    ContentView()
}
