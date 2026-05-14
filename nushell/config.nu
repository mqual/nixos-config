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