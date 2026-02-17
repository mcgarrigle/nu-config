use utilities.nu *

def git-repo-state [ dir ] {
  let state  = gstat $dir
  let branch = $state | get branch

  if $branch == no_branch { return "" }

  let untracked = $state | get wt_untracked
  let modified  = $state | get wt_modified
  let deleted   = $state | get wt_deleted
  let renamed   = $state | get wt_renamed
  let changes   = $modified + $deleted + $renamed

  $" [(ansi magenta)($branch) ($changes)/($untracked)(ansi reset)]"
}

def create_left_prompt [] {
  let pwd = relative-to-home $env.PWD
  let git = git-repo-state $env.PWD
  # $"(ansi white)┌─ (ansi green)($env.USER)(ansi yellow)@(ansi blue)(hostname --short) (ansi white)($pwd)($git)\n(ansi white)│\n(ansi white)└─ "
  $"(ansi white)┌ (ansi green)($env.USER)(ansi yellow)@(ansi blue)(hostname --short) (ansi white)($pwd)($git)\n(ansi white)└ "
}

def create_right_prompt [] {
    if ($env.LAST_EXIT_CODE == 0) {
      "" 
    } else { 
      $"(ansi rb)($env.LAST_EXIT_CODE)"
    }
}

$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }
