![nb](https://github.com/user-attachments/assets/a88dabb4-f970-4592-bb94-878d7c5e0d07)

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/rational-kunal/NeoBrutalism/ci.yml?style=flat-square) ![GitHub Tag](https://img.shields.io/github/v/tag/rational-kunal/NeoBrutalism?sort=semver&style=flat-square&label=version) ![GitHub commits since latest release](https://img.shields.io/github/commits-since/rational-kunal/NeoBrutalism/latest?style=flat-square)


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

The headline feature is a single root modifier. Add `.neoBrutalism()` once and every
supported SwiftUI control — `Button`, `Toggle`, `TextField`, `ProgressView`, `Gauge`, `Label`,
`LabeledContent`, `Menu`, `DisclosureGroup`, `ControlGroup`, `GroupBox` — takes on the
neobrutalism look, with no per-view modifiers:

```swift
import NeoBrutalism
import SwiftUI

struct ContentView: View {
    var body: some View {
        Form {
            Toggle("Are you a wizard?", isOn: .constant(true))
            Button("Cast Spell") {}
        }
        .neoBrutalism()                      // themed controls
    }
}
```

Pass `applyBackground: true` to also fill the background with the theme color, so a
two-line app is fully styled:

```swift
ContentView()
    .neoBrutalism(applyBackground: true)
```

> The default `Toggle` style is the **switch** (matching native semantics). Opt into the
> checkbox per subtree with `.toggleStyle(.neoBrutalismCheckbox)`. `List`/`Form` chrome and
> navigation bars aren't reachable through the environment — use `nbList()` / `nbListRow()`
> and `nbNavigationBar()` on those views.

You can also style individual components directly:

```swift
import NeoBrutalism
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            NBTheme.default.background
                .ignoresSafeArea()
            Toggle(isOn: .constant(true)) { Text("Are you a wizard?") }
                .toggleStyle(.neoBrutalismCheckbox)
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
                .toggleStyle(.neoBrutalismCheckbox)
        }.nbTheme(theme)
    }
}
```

**Available tokens:**
- **Colors**: `main`, `bw`, `overlay`, `background`, `blank`, `border`, `text`, `mainText`
- **Spacing**: `smsize`, `size`, `xlsize`, `smpadding`, `padding`, `xlpadding`, `smspacing`, `spacing`, `xlspacing`
- **Shadow**: `boxShadowX`, `boxShadowY`
- **Borders**: `borderWidth`, `borderRadius`
- **Typography**: `fontDesign` — applies a `Font.Design` (e.g., `.rounded`) to the entire hierarchy via the root modifier

## Architecture

```
NeoBrutalism (Swift Package, iOS 17+)
│
├── Sources/NeoBrutalism/
│   ├── NeoBrutalism.swift          # Module entry point & NB namespace
│   │
│   ├── Common/
│   │   ├── Theme.swift             # NBTheme — colors, spacing, shadow tokens
│   │   ├── NeoBrutalismBoxModifier # Shared border + drop-shadow ViewModifier
│   │   └── Equatable+             # Equatable helpers
│   │
│   ├── Internal/
│   │   └── NeoBrutalismPreviewHelper  # Canvas preview utilities
│   │
│   └── Components/
│       ├── Button.swift            # ButtonStyle (.neoBrutalism)
│       ├── GroupBox/               # GroupBoxStyle (.neoBrutalism) — card look for native GroupBox
│       ├── Badge.swift             # NBBadge — inline label
│       ├── Alert.swift             # NBAlert — icon + head + body
│       ├── Input.swift             # TextFieldStyle (.neoBrutalism)
│       ├── Progress.swift          # ProgressViewStyle (.neoBrutalism)
│       ├── Slider.swift            # NBSlider — CGFloat drag slider
│       ├── Drawer.swift            # .nbDrawer() — bottom sheet
│       ├── Collapsable.swift       # NBCollapsable + Trigger + Content
│       ├── Accordian/              # DisclosureGroupStyle (.neoBrutalism)
│       ├── Radio/                  # NBRadioGroup + NBRadioItem + Indicator
│       ├── Tabs/                   # NBTabView + NBTab — inline tab view
│       └── Skeleton/               # NBRoundSkeleton + NBTextSkeleton
│
├── Tests/NeoBrutalismTests/        # 13 snapshot test suites (light + dark)
│   └── __Snapshots__/
│
└── Example/                        # Standalone iOS Xcode demo app
    └── Sources/
        ├── ContentView.swift       # Full component showcase
        ├── TodoView.swift          # Real-world usage example
        └── Theme+.swift            # Custom theme example
```

**Key design decisions:**
- `NBTheme` is injected via SwiftUI `@Environment` — components read it automatically, consumers override it with `.nbTheme()`
- All visual styling funnels through `NeoBrutalismBoxModifier` for consistent border + shadow
- Toggle-based components (Checkbox, Switch) use native `ToggleStyle`; tab/disclosure use native `DisclosureGroupStyle` — no custom gesture reimplementations
- Snapshot tests run in both light and dark mode against stored reference images

## Components

NeoBrutalism includes commonly used UI components, with plans to expand as needed. Feel free to contribute!


### Checkbox
<p float="left">
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/0239f56e-c375-4e3b-9c04-05788350e266" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/62019831-1f62-464e-abb0-5d505080c8c3" loading="lazy" />
<p>

```swift
Toggle(isOn: $checkboxState) { Text(checkboxState ? "(Alohomora!)" : "(Colloportus!)") }
    .toggleStyle(.neoBrutalismCheckbox)
```

### Switch
<p float="left">
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/8eae5d33-bb2d-4d63-aace-478e64b40d30" loading="lazy" />
    <br />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/2b16dd43-ab86-42a2-b943-917c59598819" loading="lazy" />
</p>

```swift
Toggle(isOn: $switchState) { Text(switchState ? "(Lumos!)" : "(Nox!)") }
    .toggleStyle(.neoBrutalismSwitch)
```
### Accordion
<p float="left">
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/c714c277-734f-4195-90f1-9eff86aa767a" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/fc1fd621-2764-4a6a-a0fb-b9034e0197d3" loading="lazy" />
<p>

```swift
DisclosureGroup("Expecto Patronum") {
    Text("Pitradev Sanrakshanam - पितृदेव संरक्षणम्")
}.disclosureGroupStyle(.neoBrutalism)
```

### Button
<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/9852326a-cb3c-439b-8a2d-dd05398c38e6" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/85079e19-e62d-42e2-82de-b38ce2647327" loading="lazy" />
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

### Card (Group Box)

The native `GroupBox` gets the card look with a single style — its label becomes the
card header. It is also applied automatically by the `.neoBrutalism()` root modifier.

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/d5c57136-fc6e-4494-bb61-2e25838ec8e3" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/63137542-48aa-4903-8c5c-6fb1112c10e7" loading="lazy" />
<br />

```swift
GroupBox("Hogwarts Letter") {
    Text("You have been accepted to Hogwarts School of Witchcraft and Wizardry!")

    Button {
        // No-op
    } label: {
        Text("Open Letter").frame(maxWidth: .infinity)
    }.buttonStyle(.neoBrutalism())
}
.groupBoxStyle(.neoBrutalism())

// Neutral surface, and/or flat (no drop shadow, tighter padding):
GroupBox("Marauder's Map") {
    Text("I solemnly swear that I am up to no good.")
}
.groupBoxStyle(.neoBrutalism(type: .neutral, elevated: false))
```

### Input

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/db0039d9-f5bd-4963-9054-e9ac18e8698b" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/f2379fae-d46b-42b7-89b2-ceb670c63c35" loading="lazy" />
</p>

```swift
TextField("Enter your spell", text: $text)
    .textFieldStyle(.neoBrutalism)

SecureField("Password", text: $password)
    .textFieldStyle(.neoBrutalism)

TextEditor(text: $notes)
    .nbTextEditor()
    .frame(height: 120)
```

### Progress

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/6f6c3ba2-4afc-450b-8b18-a7cb4d278394" loading="lazy" />
    <br />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/ddcdcc4c-2df3-411f-981c-45b81dbfd864" loading="lazy" />
</p>

```
ProgressView(value: 0.7)
    .progressViewStyle(.neoBrutalism)
```

### Slider

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/cd674947-b9ce-482f-ac4f-1dcfa7ba2279" loading="lazy" />
    <br />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/51924255-eaec-4de2-98b3-f78e52b0d2cb" loading="lazy" />
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
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/5c87337e-c49a-4d80-8718-f5a702d28f82" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/9d9ea612-3f25-465d-a14f-39bdc2359881" loading="lazy" />
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
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/fab71387-fa01-4db4-af93-c78d55fb3432" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/e2cb642a-dde3-4ca8-a268-1b2375a6200c" loading="lazy" />
</p>

```swift
struct TabsExampleView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
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
        }
        .groupBoxStyle(.neoBrutalism(elevated: false))
    }
}
```

### Collapsable

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/3227440a-06bc-4631-a6fc-bbdc223d9739" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/bc0b5c7f-ce19-499a-aaac-78505bf67166" loading="lazy" />
</p>

```swift
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
```

### Drawer

<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/ff97b5c8-e6d7-417b-b2ba-f2f547244906" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/81f65e76-9eab-4680-bc68-d045044fc2e9" loading="lazy" />
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

### Navigation

Apply `.nbNavigationBar()` to style the navigation bar with the neobrutalism theme. Use it inside a `NavigationStack` on the screen content.

```swift
NavigationStack {
    ContentView()
        .navigationTitle("Navigation Title")
        .nbNavigationBar()
}
.neoBrutalism()
```

**Note:** Toolbar buttons automatically pick up `NBButtonStyle` from the root modifier. If styles reset in your toolbar context, explicitly apply `.buttonStyle(.neoBrutalism(type: .neutral))` to the toolbar item.

### Alert
<p float="left">
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/99f5328a-205c-4a25-b2b1-be3a1dbc5830" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/6d630714-e48d-4f3d-af1a-366e8defc2a4" loading="lazy" />
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
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/6367d01d-c33f-40bb-961e-6beefd496efe" loading="lazy" />
    <br />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/03d84111-83c1-4167-be1b-2bc7a5056a77" loading="lazy" />
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
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/3b031329-fcff-4da5-9755-2d3c59e7d6aa" loading="lazy" />
    <br />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/c7a41ae0-9d0b-4737-8e79-513edea7df3d" loading="lazy" />
</p>

```swift
GroupBox {
    NBRoundSkeleton()
}
.groupBoxStyle(.neoBrutalism(elevated: false))
.frame(width: 120, height: 120)
```

### Text Skeleton
<p>
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/0235262d-5f2c-4611-bce4-a7b73709b104" loading="lazy" />
    <img width="350" alt="image" src="https://github.com/user-attachments/assets/43d32664-4d57-45a3-8de2-05f8885c7613" loading="lazy" />
</p>

```swift
VStack(alignment: .leading, spacing: 12.0) {
    NBTextSkeleton()

    NBTextSkeleton()
        .frame(width: 120)
}
```

### Menu

`NBMenu` provides a fully themed dropdown menu — both trigger and items. The dropdown renders in
a separate overlay window so it appears above the entire app, even inside scrolling containers.

```swift
NBMenu {
    NBMenuItem("Edit", systemImage: "pencil") { edit() }
    NBMenuItem.divider
    NBMenuItem("Share", systemImage: "square.and.arrow.up", disabled: true) { }
    NBMenuItem("Delete", systemImage: "trash", role: .destructive) { delete() }
} label: {
    Text("Options")
}
```

Features:
- **Divider rows** with `NBMenuItem.divider` to group related actions
- **Disabled items** with the `disabled:` parameter — renders at 50% opacity and non-interactive
- **Long menus** automatically scroll when they exceed 60% of screen height

### List & Form

SwiftUI exposes no style protocol for `List`/`Form`, so the `.neoBrutalism()` root modifier
can't reach them. Style the container with `nbList()` and each row with `nbListRow()`: the
helpers hide the system background and separators and render every row as a neobrutalist card.
`Form` is a `List` under the hood, so the same helpers apply.

```swift
@Environment(\.nbTheme) private var theme

List {
    ForEach(items) { item in
        Text(item.title)
            .nbListRow()
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    items.removeAll { $0 == item }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .tint(theme.destructive)
            }
    }
}
.nbList()
```

**Native swipe-to-delete ceiling:** SwiftUI's native swipe reveal can only be *tinted*
(`.tint(theme.destructive)`) and *labelled* — its border stroke, hard offset shadow, and square
corners are system-owned and can't be restyled (and `ForEach.onDelete` gives even less: a fixed,
un-tintable "Delete"). For a fully neobrutalist drag-to-reveal action — border, hard shadow,
square corners, press language — use the custom `nbSwipeActions` component (T31), tracked as a
follow-up.

---

<small>The credit for the design belongs to https://www.neobrutalism.dev.<small>
