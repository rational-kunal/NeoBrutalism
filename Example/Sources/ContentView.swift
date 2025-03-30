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
        HStack {
            NBCheckbox(isOn: $checkboxState)
            Spacer()
            Text(checkboxState ? "(Alohomora!)" : "(Colloportus!)")
                .italic()
        }
        HStack {
            NBCheckbox(isOn: .constant(true))
                .disabled(true)
            NBCheckbox(isOn: .constant(false))
                .disabled(true)
            Spacer()
            Text("Petrificus Totalus!")
                .italic()
        }
    }
}

struct SwitchExampleView: View {
    @State var switchState = true

    var body: some View {
        HStack {
            NBSwitch(isOn: .constant(true))
                .disabled(true)
            NBSwitch(isOn: .constant(false))
                .disabled(true)

            Divider().fixedSize()

            NBSwitch(isOn: $switchState)
            Spacer()
            Text(switchState ? "(Lumos!)" : "(Nox!)")
                .italic()
        }
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
            NBButton {
                Text("Accio")
            } action: {
                counter += 1
            }

            NBButton(variant: .reverse) {
                Text("Expelliarmus")
            } action: {
                counter += 1
            }

            NBButton(type: .neutral, variant: .noShadow) {
                Image(systemName: "wand.and.sparkles.inverse")
                    .bold()
            } action: {
                counter += 1
            }
        }
        Text("(Spells Cast: \(counter))")
            .italic()
    }
}

struct CardExampleView: View {
    var body: some View {
        VStack(spacing: 28.0) {
            NBCard {
                Text("Hogwarts Letter")
            } main: {
                Text("You have been accepted to Hogwarts School of Witchcraft and Wizardry!")
            } footer: {
                NBButton {
                    Text("Open Letter")
                        .frame(maxWidth: .infinity)
                } action: {}
            }

            NBCard(type: .neutral) {
                Text("Quidditch Gear")
            } main: {
                Text("Get your broomstick, Quidditch robes, and golden snitch!")
            } footer: {
                HStack(spacing: 12.0) {
                    NBButton(type: .neutral) {
                        Text("Firebolt")
                    } action: {}
                    Spacer()
                    NBButton {
                        Text("Snitch")
                    } action: {}
                }
            }
        }
    }
}

struct InputExampleView: View {
    @State var text: String = ""

    var body: some View {
        VStack {
            NBInput(text: .constant("Wingardium Leviosa"))
                .disabled(true)

            NBInput(text: $text, placeholder: "Enter your spell")
            Text("(You just cast: \(text))")
                .italic()
        }
    }
}

struct ProgressExampleView: View {
    var body: some View {
        NBProgress(value: .constant(0.7))
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
            NBFlatCard {
                NBRoundSkeleton()
            }
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

            NBTabs(selectedTabItem: $selectedTab) {
                NBTabsList {
                    NBTabsTrigger(tabItem: 0) { Image(systemName: "flame.fill") }
                    NBTabsTrigger(tabItem: 1) { Image(systemName: "lanyardcard.fill") }
                    NBTabsTrigger(tabItem: 2) { Image(systemName: "book.fill") }
                    NBTabsTrigger(tabItem: 3) { Image(systemName: "leaf.fill") }
                }
                NBFlatCard {
                    ZStack {
                        NBTabsContent(tabItem: 0) { Text("Bravery and Daring!") }
                        NBTabsContent(tabItem: 1) { Text("Cunning and Ambition!") }
                        NBTabsContent(tabItem: 2) { Text("Wisdom and Learning!") }
                        NBTabsContent(tabItem: 3) { Text("Loyalty and Hard Work!") }
                    }
                }
            }
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
                NBFlatCard {
                    HStack {
                        Text("Need something?")
                        Spacer()
                        NBCollapsibleTrigger {
                            Image(systemName: isExpanded ? "door.left.hand.open" : "door.left.hand.closed")
                        }
                    }
                }
                NBCollapsableContent {
                    NBFlatCard(type: .neutral) {
                        Text("Here’s what you need!")
                    }
                }
            }
        }
    }
}

struct DrawerExampleView: View {
    @State private var isDrawerOpen: Bool = false

    var body: some View {
        VStack(spacing: 16.0) {
            NBButton {
                Text("Open the Chamber")
            } action: {
                isDrawerOpen.toggle()
            }
        }
        .nbDrawer(isPresented: $isDrawerOpen) {
            VStack(spacing: 16) {
                Text("Parseltongue Required")
                    .font(.title2)

                Text("Only those who can speak to snakes may proceed.")
                    .padding(.horizontal, 4.0)

                NBButton {
                    Text("I Understand")
                } action: {
                    isDrawerOpen.toggle()
                }
            }
        }
    }
}

struct FlatCardExampleView: View {
    var body: some View {
        VStack(spacing: 16.0) {
            NBFlatCard {
                Text("Quidditch Tryouts - This Saturday!")
            }

            NBFlatCard(type: .neutral) {
                Text("O.W.L. Exams Approaching - Study Hard!")
            }
        }
    }
}

struct ContentView: View {
    @State var colorSceme: ColorScheme = .light
    @State var theme = NBTheme.default.updateBy(
        main: Color(light: .rgb(1.0, 0.42, 0.42), dark: .rgb(1.0, 0.42, 0.42)),
        bw: Color(light: .rgb(1.0, 1.0, 1.0), dark: .rgb(0.129, 0.129, 0.129)),
        background: Color(light: .rgb(0.988, 0.843, 0.843), dark: .rgb(0.153, 0.161, 0.2))
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
            AnyView(CardExampleView()),
            AnyView(InputExampleView()),
            AnyView(ProgressExampleView()),
            AnyView(SliderExampleView()),
            AnyView(RadioGroupExampleView()),
            AnyView(RoundSkeletonExampleView()),
            AnyView(TextSkeletonExampleView()),
            AnyView(TabsExampleView()),
            AnyView(CollapsableExampleView()),
            AnyView(DrawerExampleView()),
            AnyView(FlatCardExampleView()),
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
                        NBButton(type: .neutral) {
                            Image(systemName: colorSceme == .light ? "moon" : "sun.max")
                        } action: {
                            withAnimation(.interactiveSpring) {
                                colorSceme = colorSceme == .light ? .dark : .light
                            }
                        }
                    }

                    ForEach(0 ..< exampleViews.count, id: \.self) { index in
                        NBCard(type: .neutral) {
                            exampleViews[index]
                        }
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
