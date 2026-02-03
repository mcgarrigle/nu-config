# add to config.nu

def tag [ name ] {
  if $name == $env.hypervisor {
    $"(ansi yellow)* ($name)(ansi reset)"
  } else {
    $"  ($name)"
  }
}

export def hypervisors [] {
  $env.hypervisors | select name | values | $in.0
}

export def hypervisor [] {
  "usage:
  
hypervisor list
hypervisor use <name>
"
}

export def "hypervisor list" [] {
  $env.hypervisors | update name { |row| tag $row.name } 
}

export def --env "hypervisor use" [ name: string@hypervisors ] {
  $env.LIBVIRT_DEFAULT_URI = $env.hypervisors 
  | where name == $name
  | $in.uri.0
  $env.hypervisor = $name
}

export def relative-to-home [ dir ] {
  let $dir = $dir | path expand
  let $relative = match (do --ignore-shell-errors { $dir | path relative-to $nu.home-path }) {
      null          => $dir
      ''            => '~'
      $relative_pwd => ([~ $relative_pwd] | path join)
  }
  $relative
}
