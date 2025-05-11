![nb](https://github.com/user-attachments/assets/a88dabb4-f970-4592-bb94-878d7c5e0d07)

# NeoBrutalism

A set of SwiftUI components inspired by the [NeoBrutalism design trend](https://author.envato.com/hub/trend-deep-dive-neo-brutalism).

This started as a learning project for SwiftUI but grew into a reusable UI library. It's useful for anyone looking to build apps with a bold, minimal style.

Feel free to contribute by reporting bugs or submitting fixes.

<p float="left">
  <img src="https://github.com/user-attachments/assets/5a81e0a3-8006-4ad0-903a-318ae8809e30" width="180px" />
  <img src="https://github.com/user-attachments/assets/f1e745ce-765d-410f-9198-d4a3212c89f8" width="180px" />
  <img src="https://github.com/user-attachments/assets/38664eaf-6d2c-4093-b317-0f425298882f" width="180px" />
  <img src="https://github.com/user-attachments/assets/d41027d7-d483-4b2d-9320-f34505ebc2c5" width="180px" />
</p>

## Checkout the library in action
- [Mismatch](https://github.com/rational-kunal/mismatch)
- _More coming soon..._

## How to install

You can add NeoBrutalism to your Swift project using Swift Package Manager.
1. In Xcode, go to File -> Swift Packages -> Add Package Dependency.
1. Enter the repository URL: https://github.com/rational-kunal/NeoBrutalism.git
1. Choose the version or branch you want to use.

## How to use

NeoBrutalism offers a variety of components that can be seamlessly integrated into your SwiftUI project.

```swift
import NeoBrutalism
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            NBTheme.default.background
                .ignoresSafeArea()
            Toggle(isOn: .constant(true)) { Text("Are you a wizard?") }
                .toggleStyle(.neoBrutalismChecklist)
        }
    }
}
```

## Styling

NeoBrutalism supports theming, with both light and dark mode options. You can customize or create your own themes. To apply a theme to a view, use the `nbTheme()` modifier.

```swift
struct ContentView: View {
    var theme = NBTheme.default.updateBy(background: .black, mainText: .white)

    var body: some View {
        ZStack {
            theme.background
                .ignoresSafeArea()
            Toggle(isOn: .constant(true)) { Text("Are you a wizard?") }
                .toggleStyle(.neoBrutalismChecklist)
        }.nbTheme(theme)
    }
}
```

## Components

NeoBrutalism includes commonly used UI components, with plans to expand as needed. Feel free to contribute!


### Checkbox
<p float="left">
    <img width="350" alt="Screenshot 2025-03-29 at 10 48 59 PM" src="https://github.com/user-attachments/assets/0239f56e-c375-4e3b-9c04-05788350e266" />
<img width="350" alt="image" src="https://github.com/user-attachments/assets/62019831-1f62-464e-abb0-5d505080c8c3" />
<p>

```swift
Toggle(isOn: $checkboxState) { Text(checkboxState ? "(Alohomora!)" : "(Colloportus!)") }
    .toggleStyle(.neoBrutalismChecklist)
```

### Switch
<p float="left">
<img width="350" alt="image" src="https://github.com/user-attachments/assets/8eae5d33-bb2d-4d63-aace-478e64b40d30" />
  <br />
<img width="350" alt="image" src="https://github.com/user-attachments/assets/2b16dd43-ab86-42a2-b943-917c59598819" />
</p>

```swift
Toggle(isOn: $switchState) { Text(switchState ? "(Lumos!)" : "(Nox!)") }
    .toggleStyle(.neoBrutalismSwitch)
```
### Accordion
<p float="left">
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/c714c277-734f-4195-90f1-9eff86aa767a" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/fc1fd621-2764-4a6a-a0fb-b9034e0197d3" />
<p>

```swift
NBAccordion {
    Text("Piertotum Locomotor")
} content: {
    Text("Pratimo Jeevit Bhavh - प्रतिमा जीवित भाव")
}
```

### Button
<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/9852326a-cb3c-439b-8a2d-dd05398c38e6" />
    <img width="350" alt="Screenshot 2025-03-29 at 11 11 08 PM" src="https://github.com/user-attachments/assets/85079e19-e62d-42e2-82de-b38ce2647327" />
<br />

</p>

```swift
Button {
    counter += 1
} label: {
    Text("Accio")
}.buttonStyle(.neoBrutalism())

Button {
    counter += 1
} label: {
    Image(systemName: "wand.and.sparkles.inverse")
        .bold()
}.buttonStyle(.neoBrutalism(type: .neutral, variant: .reverse))
```

### Card

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/d5c57136-fc6e-4494-bb61-2e25838ec8e3" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/63137542-48aa-4903-8c5c-6fb1112c10e7" />
<br />

```swift
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
```

### Input

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/db0039d9-f5bd-4963-9054-e9ac18e8698b" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/f2379fae-d46b-42b7-89b2-ceb670c63c35" />
</p>

```swift
TextField("Enter your spell", text: $text)
    .textFieldStyle(.neoBrutalism)
```

### Progress

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/6f6c3ba2-4afc-450b-8b18-a7cb4d278394" />
    <br />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/ddcdcc4c-2df3-411f-981c-45b81dbfd864" />
</p>

```
ProgressView(value: 0.7)
    .progressViewStyle(.neoBrutalism)
```

### Slider

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/cd674947-b9ce-482f-ac4f-1dcfa7ba2279" />
    <br />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/51924255-eaec-4de2-98b3-f78e52b0d2cb" />
</p>

```swift
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
```

### Radio

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/5c87337e-c49a-4d80-8718-f5a702d28f82" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/9d9ea612-3f25-465d-a14f-39bdc2359881" />
</p>

```swift
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
```

### Tabs
<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/fab71387-fa01-4db4-af93-c78d55fb3432" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/e2cb642a-dde3-4ca8-a268-1b2375a6200c" />
</p>

```swift
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
        .padding()
    }
}
```

### Collapsable

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/3227440a-06bc-4631-a6fc-bbdc223d9739" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/bc0b5c7f-ce19-499a-aaac-78505bf67166" />
</p>

```swift
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
```

### Drawer

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/ff97b5c8-e6d7-417b-b2ba-f2f547244906" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/81f65e76-9eab-4680-bc68-d045044fc2e9" />
</p>

```swift
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
```

### Flat Card

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/d9a8e2b5-2522-47b5-885f-00d57504e4fa" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/1103942e-519c-4813-8a01-60f1a653ce18" />
</p>

```swift
NBFlatCard {
    Text("Quidditch Tryouts - This Saturday!")
}

NBFlatCard(type: .neutral) {
    Text("O.W.L. Exams Approaching - Study Hard!")
}
```

### Alert
<p float="left">
<img width="350" alt="image" src="https://github.com/user-attachments/assets/99f5328a-205c-4a25-b2b1-be3a1dbc5830" />
<img width="350" alt="image" src="https://github.com/user-attachments/assets/6d630714-e48d-4f3d-af1a-366e8defc2a4" />
<p />

```swift
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
```

### Badge

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/6367d01d-c33f-40bb-961e-6beefd496efe" />
<br />
<img width="350" alt="image" src="https://github.com/user-attachments/assets/03d84111-83c1-4167-be1b-2bc7a5056a77" />
</p>

```swift
NBBadge {
    Text("Gryffindor")
        .font(.title3)
}
NBBadge(type: .neutral) {
    Text("Slytherin")
}
```

### Round Skeleton

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/3b031329-fcff-4da5-9755-2d3c59e7d6aa" />
    <br />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/c7a41ae0-9d0b-4737-8e79-513edea7df3d" />
</p>

```swift
NBFlatCard {
    NBRoundSkeleton()
}
.frame(width: 120, height: 120)
```

### Text Skeleton
<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/0235262d-5f2c-4611-bce4-a7b73709b104" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/43d32664-4d57-45a3-8de2-05f8885c7613" />
</p>

```swift
VStack(alignment: .leading, spacing: 12.0) {
    NBTextSkeleton()

    NBTextSkeleton()
        .frame(width: 120)
}
```

---

<small>The credit for the design belongs to https://www.neobrutalism.dev.<small>
