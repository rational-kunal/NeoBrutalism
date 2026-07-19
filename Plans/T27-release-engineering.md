# T27 — CHANGELOG, CONTRIBUTING, CI artifacts, v3.0

**Size:** S · **Depends on:** ships whenever Phase 1+2 are merged; earlier is fine

## Goal

The boring trust signals: a changelog people can diff-read, a contributor path, CI that helps
diagnose snapshot failures, and a tagged release so SPM users get the new work.

## Changes

1. **`CHANGELOG.md`** (repo root), Keep-a-Changelog format:
   - `## [Unreleased]` section on top.
   - Backfill `## [3.0.0]` from the actual merged work (root modifier, new styles —
     Gauge/Label/LabeledContent/ControlGroup/Menu/SegmentedPicker/Stepper/TabView — Tabs/Card
     removal with GroupBox migration note, plus whatever Phase 1/2 tasks landed).
   - Add a one-line "how to upgrade" for anything deprecated (T10 renames).
2. **`CONTRIBUTING.md`**: move the "Appendix: how to build a new component" out of
   `ROADMAP.md` into it (delete from ROADMAP, leave a link), plus: dev setup (Xcode version,
   open `Package.swift`), how to run/record snapshot tests (copy the Verification section of
   `Plans/README.md`), PR checklist (the Definition-of-Done from Plans conventions), and a
   pointer to `Plans/` + `good first issue` label.
3. **CI improvements** in `.github/workflows/ci.yml`:
   - On test failure, upload snapshot diff artifacts:
     ```yaml
     - name: Upload snapshot failures
       if: failure()
       uses: actions/upload-artifact@v4
       with:
         name: snapshot-failures-${{ matrix.name }}
         path: test_output/**
     ```
     (the `.xcresult` bundle contains the failure attachments; that's enough).
   - Add `Example/**` to the CI `paths` triggers and a build-only job for the Example app so
     it can't silently rot (it's not in the test plan today).
4. **Release**: tag `3.0.0` on main once the above merges; GitHub Release notes = the
   changelog section. **Maintainer action** — prepare the notes in the PR, the human pushes
   the tag.

## Definition of done

- [ ] CHANGELOG accurately reflects `git log` since the `2.0.0` tag (verify against
      `git log 2.0.0..HEAD --oneline` — don't invent entries).
- [ ] ROADMAP no longer contains the appendix; links to CONTRIBUTING instead.
- [ ] A deliberately-broken snapshot on a scratch branch produces a downloadable artifact in
      CI (test the failure path once, then revert).
- [ ] Example-app build job green.

## Out of scope

Automated release pipelines (danger/semantic-release); code-coverage gates; SwiftLint/
SwiftFormat adoption (worth discussing separately — it would reformat every file and pollute
blame; decide deliberately, not as a side effect).
