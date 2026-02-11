use hypervisor.nu *

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
