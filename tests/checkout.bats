#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

tmp_dir=$(mktemp -d -t skip-checkout.XXXXXXXXXX)

function cleanup {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

checkout_hook="$PWD/hooks/checkout"
post_checkout_hook="$PWD/hooks/post-checkout"

@test "Skips checkout" {
  export BUILDKITE_BUILD_CHECKOUT_PATH=$tmp_dir
  cd "$BUILDKITE_BUILD_CHECKOUT_PATH"

  run "$checkout_hook"

  assert_success
  assert [ $BUILDKITE_BUILD_CHECKOUT_PATH = $tmp_dir ]
  assert_output --partial "Skipping checkout"
}

@test "Updates checkout directory when 'cd' is given" {
  export BUILDKITE_BUILD_CHECKOUT_PATH=$tmp_dir
  export BUILDKITE_PLUGIN_SKIP_CHECKOUT_CD="/var"
  cd "$BUILDKITE_BUILD_CHECKOUT_PATH"

  run "$post_checkout_hook"

  assert_success
  assert_output --partial "Setting checkout directory"
  assert_output --partial "$BUILDKITE_PLUGIN_SKIP_CHECKOUT_CD"
}
