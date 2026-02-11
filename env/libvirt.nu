
$env.ENV_CONVERSIONS.hypervisors = { 
  from_string: { |s| $s | from json }
  to_string: { |v| $v | to json }
}
