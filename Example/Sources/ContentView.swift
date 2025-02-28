//
//  ContentView.swift
//  iOS Example
//
//  Created by Kunal on 17 Feb 2025.
//

import NeoBrutalism
import SwiftUI

struct AccordianView: View {
    var body: some View {
        Card {
            Text("Accordion")
        } main: {
            Accordion {
                Text("Platform 9 3/4")
            } content: {
                Text("Welcome to the Hogwarts Express.")
            }
        }
    }
}

struct CheckboxView: View {
    @State var checkboxState = true

    var body: some View {
        Card {
            Text("Checkbox")
        } main: {
            HStack {
                Checkbox(isOn: $checkboxState)
                Checkbox(isOn: .constant(true))
                    .disabled(true)
                Checkbox(isOn: .constant(false))
                    .disabled(true)
            }
        }
        .frame(idealWidth: .infinity)
    }
}

struct SwitchView: View {
    @State var switchState = true

    var body: some View {
        Card {
            Text("Checkbox")
        } main: {
            HStack {
                Switch(isOn: $switchState)
                Switch(isOn: .constant(true))
                    .disabled(true)
                Switch(isOn: .constant(false))
                    .disabled(true)
            }
        }
        .frame(idealWidth: .infinity)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24.0) {
            VStack(spacing: 0.0) {
                Text("Components")
                    .font(.title)
                Text("Neo Brutalism")
                    .font(.caption)
            }

            AccordianView()

            CheckboxView()
        }
        .padding()
        .background {
            Color.gray.opacity(0.5)
        }
    }
}

#Preview {
    ContentView()
}
