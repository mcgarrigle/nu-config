
export def relative-to-home [ dir ] {
  let rel = (do --ignore-errors { $dir | path expand | path relative-to $nu.home-dir })
  let out = match $rel {
      null   => $dir
      ''     => '~'
      $other => ([~ $other] | path join)
  }
  $out
}
