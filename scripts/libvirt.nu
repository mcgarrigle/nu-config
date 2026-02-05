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
