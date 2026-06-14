function _format_parse-color --description='Parse color names for use with `set_color`' --argument-names=color
    $argparse --{min,max}-args=1 b/bright\& -- {$root_subcommand[2..]} || return 1
    set --query --local -- _flag_bright && set --local -- bright br

    contains {$color} black blue cyan green magenta red white yellow || return 10

    echo "$bright"{$color}
end
