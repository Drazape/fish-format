function _format_parse-color --description='Parse color names for use with `set_color`' --inherit-variable={print,argparse}
    $argparse --min-args=1 b/bright\& -- {$argv}
    set --query --local -- _flag_bright && set --local -- bright br

    set --local -- color {$argv[1]}
    if ! contains -- {$color} black blue cyan green magenta red white yellow
        $print 'Unknown color name:' (format text bold (format background --bright red {$color})) >&2
        return 10
    end

    echo "$bright"{$color} {$argv[2..]}
end
