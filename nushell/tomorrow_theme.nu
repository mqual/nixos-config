# Tomorrow Light Theme for Nushell
# Palette derived from the Tomorrow (light) color scheme
#
# palette[0]  = #000000  (black)
# palette[1]  = #c82829  (red)
# palette[2]  = #718c00  (green)
# palette[3]  = #eab700  (yellow)
# palette[4]  = #4271ae  (blue)
# palette[5]  = #8959a8  (purple/magenta)
# palette[6]  = #3e999f  (cyan)
# palette[7]  = #bfbfbf  (light gray)
# palette[15] = #ffffff  (white)
# background  = #ffffff
# foreground  = #4d4d4c
# cursor      = #4d4d4c
# selection   = #d6d6d6

let tomorrow_black    = "#000000"
let tomorrow_red      = "#c82829"
let tomorrow_green    = "#718c00"
let tomorrow_yellow   = "#eab700"
let tomorrow_blue     = "#4271ae"
let tomorrow_purple   = "#8959a8"
let tomorrow_cyan     = "#3e999f"
let tomorrow_lgray    = "#bfbfbf"
let tomorrow_white    = "#ffffff"
let tomorrow_fg       = "#4d4d4c"
let tomorrow_bg       = "#ffffff"
let tomorrow_sel_bg   = "#d6d6d6"
let tomorrow_dgray    = "#808080"  # mid-tone for hints/comments

let tomorrow_light_theme = {
    # --- Structural / table chrome ---
    separator:                   $tomorrow_lgray
    leading_trailing_space_bg:   { bg: $tomorrow_sel_bg }
    header:                      { fg: $tomorrow_green  attr: b }
    row_index:                   { fg: $tomorrow_cyan   attr: b }
    empty:                       $tomorrow_blue
    hints:                       $tomorrow_dgray

    # --- Primitive value colors ---
    bool:       { fg: $tomorrow_blue   attr: b }
    int:        $tomorrow_purple
    float:      $tomorrow_purple
    string:     $tomorrow_green
    datetime:   $tomorrow_cyan
    duration:   $tomorrow_yellow
    filesize:   $tomorrow_blue
    range:      $tomorrow_yellow
    record:     $tomorrow_fg
    list:       $tomorrow_cyan
    block:      $tomorrow_blue
    nothing:    $tomorrow_red
    binary:     $tomorrow_red
    cell-path:  $tomorrow_blue

    # --- Syntax shapes (REPL / script coloring) ---
    shape_garbage:              { fg: $tomorrow_white  bg: $tomorrow_red    attr: b }
    shape_bool:                 { fg: $tomorrow_blue   attr: b }
    shape_int:                  { fg: $tomorrow_purple attr: b }
    shape_float:                { fg: $tomorrow_purple attr: b }
    shape_range:                { fg: $tomorrow_yellow attr: b }
    shape_string:               $tomorrow_green
    shape_string_interpolation: { fg: $tomorrow_cyan   attr: b }
    shape_literal:              $tomorrow_blue
    shape_operator:             $tomorrow_yellow
    shape_signature:            { fg: $tomorrow_green  attr: b }
    shape_internalcall:         { fg: $tomorrow_cyan   attr: b }
    shape_external:             $tomorrow_cyan
    shape_externalarg:          { fg: $tomorrow_green  attr: b }
    shape_filepath:             $tomorrow_blue
    shape_globpattern:          { fg: $tomorrow_cyan   attr: b }
    shape_variable:             $tomorrow_purple
    shape_flag:                 { fg: $tomorrow_blue   attr: b }
    shape_custom:               { fg: $tomorrow_green  attr: b }
    shape_block:                { fg: $tomorrow_blue   attr: b }
    shape_list:                 { fg: $tomorrow_cyan   attr: b }
    shape_record:               { fg: $tomorrow_cyan   attr: b }
    shape_table:                { fg: $tomorrow_blue   attr: b }
    shape_pipe:                 { fg: $tomorrow_purple attr: b }
    shape_nothing:              $tomorrow_lgray
}

# Apply the theme
$env.config.color_config = $tomorrow_light_theme

# Optional: recommended display settings that complement a light theme
$env.config.table.mode = "rounded"
$env.config.use_ansi_coloring = true
$env.config.ls.use_ls_colors = true

# LS_COLORS tuned to the Tomorrow Light palette
# Uses 24-bit RGB so it matches the hex values exactly
$env.LS_COLORS = (
    [
        "di=1;38;2;66;113;174"        # directories  → blue bold       (#4271ae)
        "ln=3;38;2;62;153;159"        # symlinks     → cyan italic      (#3e999f)
        "ex=1;38;2;113;140;0"         # executables  → green bold       (#718c00)
        "fi=38;2;77;77;76"            # regular file → foreground       (#4d4d4c)
        "*.nu=38;2;113;140;0"         # .nu scripts  → green            (#718c00)
        "*.rs=38;2;137;89;168"        # Rust source  → purple           (#8959a8)
        "*.toml=38;2;234;183;0"       # TOML config  → yellow           (#eab700)
        "*.json=38;2;234;183;0"       # JSON         → yellow
        "*.md=38;2;62;153;159"        # Markdown     → cyan             (#3e999f)
        "*.txt=38;2;77;77;76"         # plain text   → foreground
        "*.log=38;2;191;191;191"      # logs         → light gray       (#bfbfbf)
        "*.tar=1;38;2;200;40;41"      # archives     → red bold         (#c82829)
        "*.gz=1;38;2;200;40;41"
        "*.zip=1;38;2;200;40;41"
        "*.7z=1;38;2;200;40;41"
    ] | str join ":"
)
