function _format_parse-color --description='Parse color names for use with `set_color`'
    $argparse --min-args=1 max-args=2 b/bright\& -- {$argv}
    set --query --local -- _flag_bright && set --local -- bright br

    set --local -- color {$argv[1]}
    contains -- {$color} black blue cyan green magenta red white yellow || return 10

    echo "$bright"{$color}
end
