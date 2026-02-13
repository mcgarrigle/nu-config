# env/hypervisor.nu

$env.ENV_CONVERSIONS.HYPERVISORS = { 
  from_string: { |s| $s | from json }
  to_string: { |v| $v | to json }
}

