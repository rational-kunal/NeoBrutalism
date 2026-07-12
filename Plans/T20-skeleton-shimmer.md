# T20 — Skeleton pulse + `nbSkeleton()` modifier

**Size:** S · **Depends on:** nothing

## Goal

`NBRoundSkeleton`/`NBTextSkeleton` are static outlines — they don't read as "loading". Add
the standard pulse, and a `redacted`-style modifier that turns any view into its skeleton.

## Changes

1. **Pulse animation** (shared): new internal modifier in
   `Sources/NeoBrutalism/Components/Skeleton/` —
   ```swift
   /// Pulses opacity 1.0 → 0.45 → 1.0 forever to signal loading.
   /// Renders statically when Reduce Motion is on.
   struct NBSkeletonPulse: ViewModifier {
       @Environment(\.accessibilityReduceMotion) private var reduceMotion
       @State private var dimmed = false

       func body(content: Content) -> some View {
           content
               .opacity(dimmed ? 0.45 : 1.0)
               .onAppear {
                   guard !reduceMotion else { return }
                   withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                       dimmed = true
                   }
               }
       }
   }
   ```
   Apply inside `NBRoundSkeleton` and `NBTextSkeleton` bodies. Also fill the shapes with
   `theme.bw` (currently `theme.clear`) so the pulse has a surface to dim — check both
   skeletons against the Example app background in light + dark.
2. **`nbSkeleton(active:)`** public modifier (same folder, `SkeletonModifier.swift`):
   ```swift
   public extension View {
       /// Replaces this view with a pulsing skeleton box of the same size while `active`.
       ///
       /// ```swift
       /// ProfileRow(user: user).nbSkeleton(active: isLoading)
       /// ```
       func nbSkeleton(active: Bool) -> some View { … }
   }
   ```
   Implementation: when active — `content.hidden()` + `.overlay(RoundedRectangle(cornerRadius:
   theme.borderRadius).fill(theme.bw))` + `.nbBox(elevated: false)` + pulse +
   `.accessibilityLabel("Loading")` `.accessibilityAddTraits(.updatesFrequently)`; when
   inactive — content unchanged. Preserve layout (skeleton takes the content's size —
   `hidden()` + overlay does exactly that).
3. Both skeleton views get `.accessibilityHidden(true)` (decorative), the modifier gets the
   loading label above.

## Definition of done

- [ ] `SkeletonTests`: existing tests re-recorded (via the CI workflow) **only if** the `bw`
      fill changes pixels
      (it will — eyeball the diff: shapes gain a surface). Snapshot the initial frame — the
      pulse starts at full opacity, so frames stay deterministic; if flaky on CI, snapshot
      with reduce-motion asserted via the test's traits and note it.
- [ ] New snapshot: some composite view under `.nbSkeleton(active: true)`.
- [ ] Example app: skeleton section shows the pulse; a toggle flips `nbSkeleton(active:)` on
      a real row.
- [ ] README skeleton section gains the modifier.

## Out of scope

Shimmer *gradient sweep* (the moving highlight) — pulse first; gradient sweep clashes with
flat brutalist surfaces anyway. Automatic redaction via `redactionReasons`.
