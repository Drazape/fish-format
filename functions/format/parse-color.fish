function _format_parse-color --description='Parse color names for use with `set_color`' --inherit-variable={print,argparse,_format_colors}
    $argparse --min-args=1 b/bright\& -- {$argv}
    set --query --local -- _flag_bright && set --local -- bright br

    set --local -- color {$argv[1]}
    if ! contains -- {$color} {$_format_colors}
        $print 'Unknown color name:' (format text bold (format background --bright red {$color})) >&2
        return 10
    end

    echo "$bright"{$color} {$argv[2..]}
end
