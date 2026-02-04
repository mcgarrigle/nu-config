
module libvirt {

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

}

use libvirt *

def libvirt-uri [ host ] {
  $"qemu+ssh://($env.USER)@($host)/system?keyfile=($env.HOME)/.ssh/id_rsa&sshauth=privkey&no_verify=1"
}


$env.hypervisors = [
  [ name uri ];
  [ local "qemu:///system" ],
  [ dwt   (libvirt-uri dwt.mac.wales) ],
  [ smol  (libvirt-uri smol.mac.wales) ],
  [ wee   (libvirt-uri wee.mac.wales) ]
]

hypervisor use local
