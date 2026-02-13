def tag [ name ] {
  if $name == $env.hypervisor {
    $"(ansi yellow)* ($name)(ansi reset)"
  } else {
    $"  ($name)"
  }
}

export def hypervisors [] {
  $env.hypervisors | each { $in.name }
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

export def --env "hypervisor import" [] {
  if ($env.hypervisors | describe) == 'string' {
    $env.hypervisors = $env.hypervisors | from json
  }
}

export def main [] {
  "usage:

hypervisor list
hypervisor use <name>
"
}
