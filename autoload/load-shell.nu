use std/util "path add"
use utilities.nu *

path add ~/go/bin
path add ~/.local/share/nvim/bin

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"

$env.config.table.mode = 'compact'
$env.config.hooks.display_output = 'if (term size).columns >= 100 { table -e } else { table }'
$env.config.hooks.display_output = 'table'

alias cls = clear
alias vi = nvim
alias vim = nvim

alias cal = cal --week-start mo

alias g   = git
alias gs  = git status
alias gd  = git diff
# alias ga  = git add
# alias gaa = git add -A
alias gb  = git branch
alias gc  = git commit -m
alias gca = git commit --amend
alias gf  = git diff-tree --no-commit-id --name-status -r
alias gg  = git pull
alias gp  = git push
alias co  = git checkout
alias gr  = git remote -v
alias gl  = git --no-pager log --pretty=format:'%C(bold)%h %ci %C(magenta)%ae %C(cyan)%s%C(reset)' --abbrev-commit --max-count=20; echo
alias gll = git --no-pager log --pretty=format:'%C(bold)%h %ci %C(magenta)%ae %C(cyan)%s%C(reset)' --abbrev-commit; echo
alias glt = git --no-pager log --pretty=oneline --abbrev-commit --max-count=20
alias gk  = git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative

# ------------------------------------------------

def ga [...files: string] {
  git add ...$files
  git status
}

def gaa [] {
  git add -A
  git status
}

# ------------------------------------------------

def ll [] {
  ls -la | select name type size user group mode target
}

# ------------------------------------------------

def __dirl [] {
  ls ~/**/ | get name
}

def __dirs [] {
  {
    options: {
      case_sensitive: false,
      completion_algorithm: substring,
      sort: true,
    },
    completions: (__dirl)
  }
}

def --env zd [p?: string@__dirs = ""] {
  if $p == ""  { cd; return   }
  if $p == "-" { cd -; return }
  cd $p
}

# ------------------------------------------------

def tm2 [] {
  tmux -f ~/.tmux2.conf attach-session
}

def tm3 [] {
  tmux -f ~/.tmux3.conf attach-session
}

def tma [] {
  tmux attach-session
}

alias tm = tm2

# ------------------------------------------------

def ssh-copy-keys [host: string] {
  scp -p ~/.ssh/id_* $"($host):~/.ssh"
}
