# add to config.nu
#
# source $"($nu.default-config-dir | path join local.nu)"

use std/util "path add"

path add "~/go/bin"

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"

alias vi = nvim
alias vim = nvim

alias ll = ls -l

# let example_completer = {|spans| 
#   example _carapace nushell ...$spans | from json
# }
