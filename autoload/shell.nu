use std/util "path add"
use utilities.nu *

path add "~/go/bin"

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.table.mode = 'compact'

alias cls = clear
alias vi = nvim
alias vim = nvim

alias ll = ls -l
alias tree = tree -A

alias cal = cal --week-start mo

alias g = git
alias gs = git status
alias gd = git diff
alias ga = git add
alias gaa = git add -A
alias gb = git branch
alias gc = git commit -m
alias gf = git diff-tree --no-commit-id --name-status -r
alias gg = git pull
alias gp = git push
alias co = git checkout
alias gr = git remote -v
alias gl = git --no-pager log --pretty=format:'%C(bold)%h %ci %C(magenta)%ae %C(cyan)%s%C(reset)' --abbrev-commit --max-count=20; echo
alias gll = git --no-pager log --pretty=format:'%C(bold)%h %ci %C(magenta)%ae %C(cyan)%s%C(reset)' --abbrev-commit; echo
alias glt = git --no-pager log --pretty=oneline --abbrev-commit --max-count=20
alias gk = git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative

# let example_completer = {|spans| 
#   example _carapace nushell ...$spans | from json
# }
