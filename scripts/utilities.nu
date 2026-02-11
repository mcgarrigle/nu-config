
# import environment variable from ENV_CONVERSIONS JSON blob
export def --env import [ name ] {
  $env | get $name | from json | let blob
  { $name: $blob } | load-env
}

export def relative-to-home [ dir ] {
  let rel = (do --ignore-errors { $dir | path expand | path relative-to $nu.home-dir })
  let out = match $rel {
      null   => $dir
      ''     => '~'
      $other => ([~ $other] | path join)
  }
  $out
}
