# T14 — TextEditor helper + SecureField verification

**Size:** S · **Depends on:** nothing

## Goal

Round out text input. `TextFieldStyle` doesn't cover `TextEditor`, and we've never verified
`SecureField` against `.neoBrutalism`.

## Changes

1. **SecureField** honors `textFieldStyle` on iOS — verify, then make it official:
   - Add a snapshot test to `Tests/NeoBrutalismTests/InputTests.swift`:
     `SecureField("Password", text: .constant("hunter2")).textFieldStyle(.neoBrutalism)`.
   - Add a `SecureField` to the Input `#Preview` and Example app `InputExampleView`.
   - If it does *not* pick up the style (check the snapshot!), stop and file the finding in
     the PR instead of hacking around it.

2. **TextEditor** — new modifier in `Sources/NeoBrutalism/Components/Input.swift` (same file,
   it's the text-input home):

   ```swift
   public extension View {
       /// Gives a `TextEditor` the neobrutalism input treatment: themed surface,
       /// thick border, flat (no shadow) — matching `.textFieldStyle(.neoBrutalism)`.
       ///
       /// ```swift
       /// TextEditor(text: $notes)
       ///     .nbTextEditor()
       ///     .frame(height: 120)
       /// ```
       func nbTextEditor() -> some View { … }
   }
   ```

   Implementation (private modifier): `.scrollContentBackground(.hidden)` →
   `.padding(theme.smpadding)` → `.background(theme.bw)` → `.nbBox(elevated: false)` →
   `.nbDisabledEffect()` (exists after T03; if T03 hasn't landed, inline
   `opacity(isEnabled ? 1 : 0.5)`).
   Named `nbTextEditor` (not a `TextFieldStyle`) because SwiftUI offers no editor style hook.

3. Snapshot suite additions: `TextEditor` default + disabled, fixed frame
   `.frame(width: 300, height: 100)`.

## Definition of done

- [ ] SecureField snapshot proves the existing style covers it; README "Input" section
      mentions TextField, SecureField, and TextEditor together with all three snippets.
- [ ] `nbTextEditor()` has DocC, preview, snapshots, Example app entry.
- [ ] Existing Input snapshots unchanged.

## Out of scope

Focus-ring styling for text inputs (worth a future task: `@FocusState`-driven border color —
note it in the PR description); `searchable` field styling (not stylable; skip).
