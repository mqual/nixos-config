$env.config.buffer_editor = "ki"

let carapace_completer = {|spans|
  carapace $spans.0 nushell ...$spans | from json
}
$env.config = {
  show_banner: false,
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "fuzzy"
    external: {
      enable: true
      max_results: 100
      completer: $carapace_completer
    }
  }
  hooks: {
    pre_execution: [
      {||
        let cmd = (commandline | str trim)
        if ($cmd | str starts-with "cd ") {
          let target = ($cmd | str replace "cd " "" | str trim)
          let resolved = ($target | path expand)
          if ($resolved | path exists) {
            mkdir ($env.HOME | path join ".cache")
            $resolved | save --force ($env.HOME | path join ".cache" "nushell_wd")
          }
        }
      }
    ]
  }
}

def --env wd [] {
  let saved = ($env.HOME | path join ".cache" "nushell_wd")
  if ($saved | path exists) {
    cd (open $saved | str trim)
  } else {
    print "No directory saved yet. Use cd somewhere first."
  }
}
$env.PATH = ($env.PATH |
  split row (char esep) |
  prepend /home/haxfn/.apps |
  append /usr/bin/env
)
use std/util "path add"
path add ($env.HOME | path join ".cargo" "bin")

use "~/Documents/nixos-config/nushell/panache-git.nu"
$env.PROMPT_COMMAND = { panache-git }

source ~/.config/nushell/tomorrow_theme.nu

use std/config *

# Initialize the PWD hook as an empty list if it doesn't exist
$env.config.hooks.env_change.PWD = $env.config.hooks.env_change.PWD? | default []

$env.config.hooks.env_change.PWD ++= [{||
  if (which direnv | is-empty) {
    # If direnv isn't installed, do nothing
    return
  }

  direnv export json | from json | default {} | load-env
  # If direnv changes the PATH, it will become a string and we need to re-convert it to a list
  $env.PATH = do (env-conversions).path.from_string $env.PATH
}]
