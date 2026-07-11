#!/usr/bin/env zsh
# Reference environment for all snapshot rendering. Change ONLY via a PR that
# also re-records every image (Scripts/record.sh).
export NB_SNAPSHOT_DEVICE="iPhone 16"
export NB_SNAPSHOT_OS="18.5"
export NB_CI_XCODE="Xcode_16.4"   # GH macos-15 image default; ships iOS 18.5 sims
