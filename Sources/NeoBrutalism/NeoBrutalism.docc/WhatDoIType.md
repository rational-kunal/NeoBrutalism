# What do I type?

Every component, and the exact line that gives it to you.

## Start here

Add this once, at the root of your app:

```swift
ContentView()
    .neoBrutalism(applyBackground: true)
```

That styles most controls on its own. In the table below, **any row showing plain SwiftUI is
already done** — the root modifier reached it, and you write nothing extra. Rows that name an
`nb…` modifier or an `NB…` view are the ones that need something from you.

> Important: Apply `.neoBrutalism()` as the **outermost** modifier. Anything it wraps can still
> be overridden per-view; a per-view override placed after it gets overwritten instead.

## The table

| I want… | I write |
|---|---|
| Accordion / expandable row | `DisclosureGroup("Title") { … }` |
| Alert banner (inline) | `NBAlert("Title", message: "…", systemImage: "bell")` |
| Badge / tag | `NBBadge { Text("New") }` |
| Button | `Button("Go") {}` |
| Card | `GroupBox("Title") { … }` |
| Checkbox | `Toggle("Label", isOn: $on).toggleStyle(.neoBrutalismCheckbox)` |
| Collapsible with a custom trigger | `NBCollapsable(isExpanded: $open) { … }` |
| Confirmation dialog | `.nbDialog("Delete?", isPresented: $show) { … } message: { … }` |
| Bottom drawer / sheet | `.nbDrawer(isPresented: $show) { … }` |
| Form | `Form { … .nbListRow() }.nbList()` |
| Gauge | `Gauge(value: level) { Text("Charge") }` |
| Grouped buttons | `ControlGroup { … }` |
| Icon + title row | `Label("Settings", systemImage: "gear")` |
| Key/value row | `LabeledContent("Plan", value: "Pro")` |
| List | `List { … .nbListRow() }.nbList()` |
| Loading placeholder | `.nbSkeleton(active: isLoading)` |
| Menu (trigger themed) | `Menu("Options") { … }` |
| Menu (popup themed too) | `NBMenu { NBMenuItem("Edit") {} } label: { … }` |
| Navigation bar | `.navigationTitle("Spells").nbNavigationBar()` |
| Password field | `SecureField("Password", text: $pw)` |
| Progress bar | `ProgressView(value: progress)` |
| Radio group | `NBRadioGroup(value: $pick) { NBRadioItem(value: 0) { … } }` |
| Segmented picker | `NBSegmentedPicker(selection: $size) { Text("S").nbSegment("S") }` |
| Slider | `NBSlider(value: $volume)` |
| Stepper | `NBStepper("Quantity", value: $qty, in: 0...10)` |
| Swipe actions on a row | `.nbSwipeActions(actions: [NBSwipeAction("Delete") {}])` |
| Switch | `Toggle("Label", isOn: $on)` |
| Tabs | `NBTabView(selection: $tab) { NBTab("One", value: 1) { … } }` |
| Text field | `TextField("Add a task…", text: $text)` |
| Multi-line text | `TextEditor(text: $notes).nbTextEditor()` |

## Three rules worth knowing

**Lists need two modifiers, not one.** `nbList()` goes on the `List` or `Form`;
`nbListRow()` goes on each row's content. One without the other looks half-styled.

```swift
List {
    ForEach(items) { item in
        Text(item.title).nbListRow()   // ← on the row
    }
}
.nbList()                               // ← on the list
```

**A `Toggle` is a switch by default.** That matches how `Toggle` behaves natively. Ask for the
checkbox or the radio dot explicitly:

```swift
Toggle("Remember me", isOn: $on)                                  // switch
Toggle("Remember me", isOn: $on).toggleStyle(.neoBrutalismCheckbox) // checkbox
Toggle("Remember me", isOn: $on).toggleStyle(.neoBrutalismRadio)    // radio dot
```

**A few things have no native equivalent**, so they ship as `NB…` views: ``NBSlider``,
``NBStepper``, ``NBSegmentedPicker``, ``NBRadioGroup``, ``NBTabView``. They copy the native
initializer shape, so switching to them is a rename.

## Styling one control on its own

Everything above assumes `.neoBrutalism()` at the root. If you need a single styled control
somewhere that modifier doesn't cover, every style is also available directly:

```swift
Button("Go") {}
    .buttonStyle(.neoBrutalism())        // instead of relying on the root

ProgressView(value: 0.5)
    .progressViewStyle(.neoBrutalism)
```

You need this rarely. Each component page shows the explicit form under **Styling it directly**.

## See Also

- <doc:BuildAForm>
- <doc:BuildAListScreen>
- <doc:Components>
- <doc:GettingStarted>
- <doc:Theming>
