# add to config.nu
#
# source $"($nu.default-config-dir | path join local.nu)"

use std/util "path add"

path add "~/go/bin"

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"

def libvirt-uri [ host ] {
  $"qemu+ssh://($env.USER)@($host)/system?keyfile=($env.HOME)/.ssh/id_rsa&sshauth=privkey&no_verify=1"
}

$env.hypervisors = [
  [ name uri ];
  [ local "qemu:///system" ]
  [ dwt   (libvirt-uri dwt.mac.wales) ]
  [ smol  (libvirt-uri smol.mac.wales) ]
  [ wee   (libvirt-uri wee.mac.wales) ]
]

module commands {

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

  export def xrelative-to-home [ dir ] {
    let relative = match (do --ignore-shell-errors { $dir | path relative-to $nu.home-path }) {
        null          => $dir
        ''            => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    $relative
  }

}

use commands *

hypervisor use local

alias vi = nvim
alias vim = nvim

alias ll = ls -l

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
