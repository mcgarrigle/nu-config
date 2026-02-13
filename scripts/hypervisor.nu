def tag [ name ] {
  if $name == $env.HYPERVISOR {
    $"(ansi yellow)* ($name)(ansi reset)"
  } else {
    $"  ($name)"
  }
}

def hypervisors [] {
  $env.HYPERVISORS | each { $in.name }
}

# ---------------------------------------------

export def list [] {
  $env.HYPERVISORS | update name {|row| tag $row.name }
}

export def --env use [ name: string@hypervisors ] {
  $env.LIBVIRT_DEFAULT_URI = $env.HYPERVISORS
  | where name == $name
  | $in.uri.0
  $env.HYPERVISOR = $name
}

export def --env import [] {
  if ($env.HYPERVISORS | describe) == 'string' {
    $env.HYPERVISORS = $env.HYPERVISORS | from json
  }
}

export def main [] {
  "usage:

hypervisor list
hypervisor use <name>
"
}
