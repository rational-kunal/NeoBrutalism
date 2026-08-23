#!/usr/bin/env bash
#
# Derives the DocC component imagery from the snapshot references.
#
# The snapshot suite already renders every component in light and dark on a
# pinned simulator, so those PNGs are the only source of truth for what a
# component looks like. Rather than keep a second, hand-captured set of
# screenshots in sync by hand, the documentation reuses them: this script maps
# a curated subset of `Tests/NeoBrutalismTests/__Snapshots__` into the DocC
# catalog under DocC's light/dark naming convention.
#
#   <snapshot>.light.png  ->  <doc-name>@2x.png
#   <snapshot>.dark.png   ->  <doc-name>~dark@2x.png
#
# References are rendered 900px wide from a 300pt-wide view (@3x on the pinned
# iPhone 16). They are downsampled to 600px so the catalog can label them @2x,
# which DocC renders at 300pt — the same size the component was laid out at.
#
# The output directory is generated, not committed (see .gitignore). Run this
# before building documentation locally:
#
#   Scripts/sync-doc-images.sh
#   xcodebuild docbuild -scheme NeoBrutalism -destination "generic/platform=iOS Simulator"
#
# Adding a page image: add a `Suite/snapshot_name  doc-image-name` row to the
# manifest below. The snapshot must already exist — this script never renders
# anything, it only copies. To add a *new* rendering, add a @Test that calls
# assertNBSnapshot and re-record via the "Re-record snapshots" workflow.

set -euo pipefail

cd "$(dirname "$0")/.."

SNAPSHOTS="Tests/NeoBrutalismTests/__Snapshots__"
OUTPUT="Sources/NeoBrutalism/NeoBrutalism.docc/Resources/Generated"
WIDTH=600

# Suite/snapshot_name                              doc-image-name
MANIFEST=$(
    cat <<'EOF'
ButtonTests/button_default                         nb-button-default
ButtonTests/button_default_pressed_reverse         nb-button-reverse
ButtonTests/button_default_noShadow                nb-button-noshadow
ButtonTests/button_neutral                         nb-button-neutral
ButtonTests/button_neutral_reverse                 nb-button-neutral-reverse
ButtonTests/button_neutral_noShadow                nb-button-neutral-noshadow
ButtonTests/button_with_icon                       nb-button-icon
ButtonTests/button_disabled                        nb-button-disabled

CheckboxTests/checkbox_on                          nb-checkbox-on
CheckboxTests/checkbox_off                         nb-checkbox-off
CheckboxTests/checkboxWithLabel_on                 nb-checkbox-label-on
CheckboxTests/checkboxWithLabel_off                nb-checkbox-label-off
CheckboxTests/checkbox_on_disabled                 nb-checkbox-disabled

SwitchTests/switch_on                              nb-switch-on
SwitchTests/switch_off                             nb-switch-off
SwitchTests/switchWithLabel_on                     nb-switch-label-on
SwitchTests/switch_on_disabled                     nb-switch-disabled

RadioTests/radio_singleSelection_firstSelected     nb-radio-group
RadioTests/radio_withLabel                         nb-radio-label
RadioTests/radioItem_selected                      nb-radio-item-selected
RadioTests/radioItem_unselected                    nb-radio-item-unselected

InputTests/input_empty                             nb-input-empty
InputTests/input_filled                            nb-input-filled
InputTests/input_disabled                          nb-input-disabled
InputTests/securefield_enabled                     nb-securefield
InputTests/texteditor_enabled                      nb-texteditor
InputTests/texteditor_disabled                     nb-texteditor-disabled

SliderTests/slider_0                               nb-slider-0
SliderTests/slider_48                              nb-slider-48
SliderTests/slider_100                             nb-slider-100
SliderTests/slider_range_with_step                 nb-slider-step
SliderTests/slider_disabled                        nb-slider-disabled

StepperTests/stepper_default                       nb-stepper-default
StepperTests/stepper_atMinimum                     nb-stepper-min
StepperTests/stepper_atMaximum                     nb-stepper-max
StepperTests/stepper_customLabel                   nb-stepper-custom-label
StepperTests/stepper_disabled                      nb-stepper-disabled

SegmentedPickerTests/segmentedPicker_firstSelected  nb-segmented-first
SegmentedPickerTests/segmentedPicker_middleSelected nb-segmented-middle
SegmentedPickerTests/segmentedPicker_intValues      nb-segmented-int
SegmentedPickerTests/segmentedPicker_disabled       nb-segmented-disabled

MenuTests/menu_default                             nb-menu-default
MenuTests/menu_with_icon                           nb-menu-icon
MenuTests/nbMenu_trigger                           nb-menu-nbmenu

ProgressTests/progress_0                           nb-progress-0
ProgressTests/progress_52                          nb-progress-52
ProgressTests/progress_100                         nb-progress-100
ProgressTests/progress_indeterminate               nb-progress-indeterminate

GaugeTests/gauge_0                                 nb-gauge-0
GaugeTests/gauge_52                                nb-gauge-52
GaugeTests/gauge_100                               nb-gauge-100

BadgeTests/badge_default                           nb-badge-default
BadgeTests/badge_neutral                           nb-badge-neutral

SkeletonTests/roundSkeleton_default                nb-skeleton-round
SkeletonTests/textSkeleton_default                 nb-skeleton-text
SkeletonTests/skeletonModifier_active              nb-skeleton-modifier

GroupBoxTests/groupBox_default                     nb-groupbox-default
GroupBoxTests/groupBox_neutral                     nb-groupbox-neutral
GroupBoxTests/groupBox_flat                        nb-groupbox-flat
GroupBoxTests/groupBox_no_label                    nb-groupbox-nolabel
GroupBoxTests/groupBox_with_icon_in_label          nb-groupbox-icon

ControlGroupTests/controlGroup_default             nb-controlgroup-default
ControlGroupTests/controlGroup_with_icons          nb-controlgroup-icons

LabelTests/label_default                           nb-label-default
LabelTests/label_with_gear_icon                    nb-label-icon
LabeledContentTests/labeledContent_basic           nb-labeledcontent-basic
LabeledContentTests/labeledContent_inside_groupBox nb-labeledcontent-groupbox

AccordionTests/accordion_collapsed                 nb-accordion-collapsed
AccordionTests/accordion_expanded                  nb-accordion-expanded
CollapsableTests/collapsable_collapsed             nb-collapsable-collapsed
CollapsableTests/collapsable_expanded              nb-collapsable-expanded

TabViewTests/tabView_firstSelected                 nb-tabs-first
TabViewTests/tabView_systemImage                   nb-tabs-icon
TabViewTests/tabView_customLabel_cardContent       nb-tabs-custom

ListTests/list_basic                               nb-list-basic
ListTests/form_basic                               nb-form-basic
NavigationTests/navigation_bar                     nb-navigation-bar

SwipeActionsTests/swipeActions_singleAction_closed   nb-swipe-closed
SwipeActionsTests/swipeActions_singleAction_revealed nb-swipe-single
SwipeActionsTests/swipeActions_twoActions_revealed   nb-swipe-two

AlertTests/alert_default                           nb-alert-default
AlertTests/alert_neutral                           nb-alert-neutral
DialogTests/dialog_card                            nb-dialog-card

RootModifierTests/kitchenSink                      nb-kitchen-sink
RootModifierTests/kitchenSinkRoundedFont           nb-kitchen-sink-rounded

ThemePresetTests/preset_sunnyPeach                 nb-preset-sunnypeach
ThemePresetTests/preset_bubblegum                  nb-preset-bubblegum
ThemePresetTests/preset_seafoam                    nb-preset-seafoam
ThemePresetTests/preset_tangerine                  nb-preset-tangerine
ThemePresetTests/preset_lavender                   nb-preset-lavender
EOF
)

rm -rf "$OUTPUT"
mkdir -p "$OUTPUT"

missing=0
count=0

while read -r source name; do
    [ -z "${source:-}" ] && continue

    for variant in light dark; do
        src="$SNAPSHOTS/$source.$variant.png"

        if [ ! -f "$src" ]; then
            echo "error: no snapshot at $src (manifest row: $source)" >&2
            missing=$((missing + 1))
            continue
        fi

        if [ "$variant" = "light" ]; then
            out="$OUTPUT/$name@2x.png"
        else
            out="$OUTPUT/$name~dark@2x.png"
        fi

        sips --resampleWidth "$WIDTH" "$src" --out "$out" >/dev/null
        count=$((count + 1))
    done
done <<<"$MANIFEST"

if [ "$missing" -gt 0 ]; then
    echo "error: $missing manifest entries had no matching snapshot" >&2
    exit 1
fi

echo "Wrote $count images to $OUTPUT"
