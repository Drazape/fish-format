function format --description='Intuitively format ANSI' --argument-names=subcommand --inherit-variable=_format_colors
    begin
        set --local -- output_name (set_color --dim)(status function)(set_color --reset)
        set --function -- argparse{,} --name={$output_name}
        set --function -- print echo -- {$output_name}(set_color --dim white)':'(set_color --reset)
    end

    $argparse --stop-nonopt h/help\& -- {$argv}

    function evaluate-color --description='Parse color names for use with `set_color`' --inherit-variable={print,argparse,_format_colors}
        set --local text {$argv[3..]}
        $argparse --min-args=1 --ignore-unknown b/bright\& -- {$argv[1..2]}
        set --query --local -- _flag_bright && set --local -- bright br

        set --local -- color {$argv[1]}
        if ! contains -- {$color} {$_format_colors}
            $print 'Unknown color name:' (format text bold (format background --bright red {$color})) >&2
            return 10
        end

        string repeat -- 1 "$bright"{$color} {$argv[2]} {$text}
    end

    # Root Descriptions
    set --local -- text_description 'Format the string itself'
    set --local -- line_description (set_color --underline{,-color=yellow})' Add'(set_color --reset)' and '(set_color --strikethrough)'customize'(set_color --reset)' lines'
    if set --local --query -- _flag_help
        help-text 'Intuitively format ANSI' \
            --sub-command={
                'text | '{$text_description},
                'background | Modify the '(format background yellow 'Background')' color',
                'line | '{$line_description}
                'url | Hyperlink the string'
            } \
            --flag='help:h | Show a reference manual for a sub-command'
        return 0
    end

    set --local -- root_subargs {$argv[2..]}
    switch "$subcommand"
        case text
            $argparse --stop-nonopt h/help\& -- {$root_subargs}
            if set --query --local -- _flag_help
                help-text {$text_description} \
                    --sub-command={
                        'color | '(format text color yellow 'Colorize')' the text string',
                        'bold | '(format text bold 'Bolden')' the text font',
                        'italics | '(format text italics 'Italicize')' the text font',
                        'dim | '(format text dim 'Dim')' the text color'
                    }
                return 0
            end

            switch "$root_subargs[1]"
                case color
                    set --local -- color_subargs (evaluate-color {$root_subargs[2..]} || return {$status})
                    set_color {$color_subargs[1]}
                    echo -n -- {$color_subargs[2..]}
                    set_color --reset
                    echo
                case bold italics dim
                    set_color --{$root_subargs[1]}
                    echo -n -- {$root_subargs[2..]}
                    set_color --reset
                    echo
                case \*
                    $print unknown (format text italics 'Text') sub-command: (format text bold (format background --bright red {$root_subargs[1]})) >&2
            end
        case background
            set --local -- background_subargs (evaluate-color {$root_subargs} || return {$status})
            set_color --background={$background_subargs[1]}
            echo -n -- {$background_subargs[2..]}
            set_color --reset
            echo
        case line
            $argparse --stop-nonopt h/help\& -- {$root_subargs}
            if set --query --local -- _flag_help
                help-text {$line_description} \
                    --sub-command={
                        'under | '(format line under Underline)' the text',
                        'strikethrough | '(format line strikethrough 'Strikethrough')' the string'
                    }
                return 0
            end

            set --local -- line_args {$root_subargs[2..]}
            switch "$root_subargs[1]"
                case under
                    $argparse h/help\& c/color=\& b/bright\& -- {$line_args}
                    if set --query --local -- _flag_help
                        help-text 'Underline the text string' \
                            --positional='+String | Piped string to underline' \
                            --switch='
                                c:color | Set color of the underline
                                b:bright | Brighten the underline color
                            '
                        return 0
                    end
                    set --query --local -- _flag_bright && ! set --query --local -- _flag_color && set --local -- _flag_color white # default color
                    set --query --local -- _flag_color && set --local -- color (evaluate-color {$_flag_bright} -- {$_flag_color} || return {$status})

                    set_color --underline --underline-color={$color}
                    echo -n -- {$argv}
                    set_color --reset
                    echo
                case strikethrough
                    set_color --strikethrough
                    echo -n -- {$line_args}
                    set_color --reset
                    echo
                case \*
                    $print unknown (format text italics 'Line') sub-command: (format text bold (format background --bright red {$root_subargs[1]})) >&2
            end
        case url
            test (count {$root_subargs}) -gt 2 && $print (format text bold 'url'): Expected (format text italics 2) 'arguments; got' (format background red (count {$root_asubargs}))
            echo -e -- '\e]8;;'"$root_subargs[1]"'\a'{$root_subargs[2..]}'\e]8;;\a'
        case \*
            $print 'unknown sub-command:' (format text bold (format background --bright red {$argv[1]})) >&2
            return 1
    end
end
