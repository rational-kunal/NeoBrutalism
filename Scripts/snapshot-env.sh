#!/usr/bin/env zsh
# Reference environment for all snapshot rendering. Change ONLY via a PR that
# also re-records every image (Scripts/record.sh).
export NB_SNAPSHOT_DEVICE="iPhone 16"
export NB_SNAPSHOT_OS="26.2"
export NB_CI_XCODE="Xcode_26.2"   # GH macos-15 image; ships iOS 26.2 sims (build 17C52)
