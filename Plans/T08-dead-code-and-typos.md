# T08 — Dead code, folder typos, namespace cleanup

**Size:** XS · **Depends on:** nothing

## Goal

Internal hygiene before the public-facing pushes. Nothing here may change the public API
surface except deleting two clearly-dead symbols.

## Changes

1. `Sources/NeoBrutalism/NeoBrutalism.swift` currently contains:
   ```swift
   class NeoBrutalism {}

   @MainActor
   public struct NB {}
   ```
   Delete both. `class NeoBrutalism` is dead scaffolding; `NB` is an empty public namespace
   nothing references (verify: `grep -rn "NB\." Sources/ Tests/ Example/`). If the file is then
   empty, delete the file.
2. Rename folders (internal layout only, no type renames):
   - `Sources/NeoBrutalism/Components/Accordian/` → `Components/Accordion/`
     (also rename `Accordian.swift` → `Accordion.swift`)
   - `Sources/NeoBrutalism/Components/Checbox/` → `Components/Checkbox/`
     (also `ChecboxShape.swift` → `CheckboxShape.swift`)
   Use `git mv` so history follows.
3. Typo fixes (internal symbols and copy only):
   - `Tests/NeoBrutalismTests/SnapshotHelper.swift`: `PrettifyForTestViewModifer` →
     `PrettifyForTestViewModifier` (internal type, safe).
   - `Sources/.../Radio/Radio.swift` preview: `"Thhird"` → `"Third"` — **snapshot-safe**
     because previews aren't snapshotted.
4. Do **not** rename public types in this task (e.g. `NBCollapsable`'s spelling, style names) —
   that's T10 / the v3.0 audit.

## Definition of done

- [ ] Build passes; all snapshot tests pass without re-recording.
- [ ] `grep -rni "accordian\|checbox" Sources/ Tests/` → only hits inside
      `Accordion.swift`'s deprecated `NBAccordion` type name? No — that type is spelled
      correctly already; expect **zero** hits.
- [ ] Public API unchanged: `git diff` shows no `public` declaration modified other than the
      deleted `NB` struct.

## Out of scope

Public renames, README changes, moving files between targets.
