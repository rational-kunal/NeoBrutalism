# T19 — NBMenu: dividers, disabled items, long menus

**Size:** S · **Depends on:** T16 Step 1 if it landed (overlay window moved) — otherwise edit in place

## Goal

`Sources/NeoBrutalism/Components/Menu/NBMenu.swift` covers the happy path. Real menus need
section dividers, disabled items, and to survive more items than fit on screen.

## Changes

1. **Divider rows**:
   ```swift
   public extension NBMenuItem {
       /// A section divider row.
       static var divider: NBMenuItem
   }
   ```
   Implementation: add an internal `enum Kind { case item, divider }` to `NBMenuItem` (default
   `.item`; private init for the divider case). In `NBMenuOverlayContent.dropdown`, render
   `.divider` as a thicker rule (`theme.border`, height `theme.borderWidth * 2`) with vertical
   `theme.smpadding`, and skip the between-items hairline adjacent to it. Dividers are not
   tappable.
2. **Disabled items**: add `disabled: Bool = false` to both public `NBMenuItem` inits (last
   parameter before the builders to keep call sites stable... actually keep trailing-closure
   ergonomics: place it after `role:`). Disabled rows render at 50% opacity and don't respond
   (`.disabled(true)` on the row `Button` — the row's `NBMenuItemButtonStyle` already won't
   highlight when the button never presses; verify).
3. **Long menus**: cap the dropdown at 60% of screen height:
   in `dropdown(elevated:)`, wrap the items `VStack` in a `ScrollView` +
   `.frame(maxHeight: …)` only when the measured content height exceeds the cap (measure with
   the existing `dropdownSize` machinery — if `dropdownSize.height` > cap, constrain).
   Placement math (`placement(in:)`) must use the **capped** height — it already reads
   `dropdownSize`, so set the frame before measurement or clamp `dropdownSize` consistently;
   verify the flip-upward preview still flips correctly.
4. Preview: add a menu with a divider, a disabled item, and a 20-item menu (scroll case).

## Definition of done

- [ ] `MenuTests` existing snapshots pass without re-recording (trigger visuals untouched).
- [ ] New snapshot for the dropdown card itself if the suite already snapshots it; otherwise
      rely on previews + a short screen recording in the PR (the dropdown lives in another
      window, which snapshot tests can't capture — state this in the PR).
- [ ] Simulator: 20-item menu scrolls, opens upward near the bottom edge, divider and
      disabled item render correctly.
- [ ] README NBMenu section shows divider + disabled usage.

## Out of scope

Submenus; checkmark/selection state; keyboard navigation.
