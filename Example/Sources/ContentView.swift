//
//  ContentView.swift
//  iOS Example
//
//  Created by Kunal on 17 Feb 2025.
//

import NeoBrutalism
import SwiftUI

struct AccordianExampleView: View {
    var body: some View {
        Card(type: .neutral) {
            Text("Accordion")
        } main: {
            Accordion {
                Text("Platform 9 3/4")
            } content: {
                Text("Welcome to the Hogwarts Express. All aboard for a magical journey!")
            }
        }
    }
}

struct CheckboxExampleView: View {
    @State var checkboxState = true

    var body: some View {
        Card(type: .neutral) {
            Text("Checkbox")
        } main: {
            HStack {
                Checkbox(isOn: $checkboxState)
                Checkbox(isOn: .constant(true))
                    .disabled(true)
                Checkbox(isOn: .constant(false))
                    .disabled(true)
                Spacer()
                Text(checkboxState ? "(Alohomora!)" : "(Colloportus!)")
                    .italic()
            }
        }
    }
}

struct SwitchExampleView: View {
    @State var switchState = true

    var body: some View {
        Card(type: .neutral) {
            Text("Switch")
        } main: {
            HStack {
                Switch(isOn: $switchState)
                Switch(isOn: .constant(true))
                    .disabled(true)
                Switch(isOn: .constant(false))
                    .disabled(true)
                Spacer()
                Text(switchState ? "(Lumos!)" : "(Nox!)")
                    .italic()
            }
        }
    }
}

struct AlertExampleView: View {
    var body: some View {
        Card(type: .neutral) {
            Text("Alert")
        } main: {
            VStack(spacing: 18.0) {
                Alert {
                    Text("The Chamber of Secrets has been opened. Enemies of the heir, beware!")
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                } head: {
                    Text("Warning")
                }

                Alert(type: .neutral) {
                    Text("Dementors are nearby. Expecto Patronum!")
                } head: {
                    Text("Caution")
                }
            }
        }
    }
}

struct BadgeExampleView: View {
    var body: some View {
        Card(type: .neutral) {
            Text("Badges")
        } main: {
            HStack {
                Badge {
                    Text("Gryffindor")
                }
                Badge(type: .neutral) {
                    Text("Slytherin")
                }
            }
        }
    }
}

struct ButtonExampleView: View {
    @State var counter: Int = 0

    var body: some View {
        Card(type: .neutral) {
            Text("Button")
        } main: {
            HStack(spacing: 12.0) {
                Button {
                    Text("Accio")
                } action: {
                    counter += 1
                }

                Button(variant: .reverse) {
                    Text("Expelliarmus")
                } action: {
                    counter += 1
                }

                Button(type: .neutral, variant: .noShadow) {
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
}

struct CardExampleView: View {
    var body: some View {
        Card(type: .neutral) {
            Text("Card")
        } main: {
            VStack(spacing: 28.0) {
                Card {
                    Text("Hogwarts Letter")
                } main: {
                    Text("You have been accepted to Hogwarts School of Witchcraft and Wizardry!")
                } footer: {
                    Button {
                        Text("Open Letter")
                            .frame(maxWidth: .infinity)
                    } action: {}
                }

                Card(type: .neutral) {
                    Text("Quidditch Gear")
                } main: {
                    Text("Get your broomstick, Quidditch robes, and golden snitch!")
                } footer: {
                    HStack(spacing: 12.0) {
                        Button(type: .neutral) {
                            Text("Firebolt")
                        } action: {}
                        Spacer()
                        Button {
                            Text("Snitch")
                        } action: {}
                    }
                }
            }
        }
    }
}

struct InputExampleView: View {
    @State var text: String = ""

    var body: some View {
        Card(type: .neutral) {
            Text("Input")
        } main: {
            VStack {
                Input(text: .constant("Wingardium Leviosa"))
                    .disabled(true)
                Input(text: $text, placeholder: "Enter your spell")

                Text("(You just cast: \(text))")
                    .italic()
            }
        }
    }
}

struct ProgressExampleView: View {
    var body: some View {
        Card(type: .neutral) {
            Text("Progress")
        } main: {
            Progress(value: .constant(0.3))
        }
    }
}

struct SliderExampleView: View {
    @State var sliderValue: CGFloat = 0.0

    var body: some View {
        Card(type: .neutral) {
            Text("Slider")
        } main: {
            HStack {
                Text("\(sliderValue, specifier: "%.2f")")
                    .frame(width: 50.0, alignment: .leading)
                Slider(value: $sliderValue)
            }
        }
    }
}

struct ContentView: View {
    @State var colorSceme: ColorScheme = .light

    var body: some View {
        ZStack {
            Theme.default.background
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 28.0) {
                    HStack {
                        Text("Neo Brutalism")
                            .font(.largeTitle)
                        Spacer()
                        Button(type: .neutral) {
                            Image(systemName: colorSceme == .light ? "moon" : "sun.max")
                        } action: {
                            withAnimation(.interactiveSpring) {
                                colorSceme = colorSceme == .light ? .dark : .light
                            }
                        }
                    }

                    AccordianExampleView()

                    CheckboxExampleView()

                    SwitchExampleView()

                    SliderExampleView()

                    ButtonExampleView()

                    ProgressExampleView()

                    AlertExampleView()

                    BadgeExampleView()

                    CardExampleView()

                    InputExampleView()
                }
                .padding()
            }
        }
        .colorScheme(colorSceme)
    }
}

#Preview {
    ContentView()
}
