function format --description='Intuitively format ANSI' --argument-names=subcommand --inherit-variable=_format_colors
    begin
        set --local -- output_name (format text dim (status function))
        set --function -- argparse{,} --name={$output_name}
        set --function -- print echo -- {$output_name}(format text dim (format text color white ':'))
    end

    $argparse --stop-nonopt h/help\& -- {$argv}

    function parse-color --description='Parse color names for use with `set_color`' --inherit-variable={print,argparse,_format_colors}
        $argparse --min-args=1 b/bright\& -- {$argv}
        set --query --local -- _flag_bright && set --local -- bright br

        set --local -- color {$argv[1]}
        if ! contains -- {$color} {$_format_colors}
            $print 'Unknown color name:' (format text bold (format background --bright red {$color})) >&2
            return 10
        end

        string repeat 1 "$bright"{$color} {$argv[2..]}
    end

    # Root Descriptions
    set --local -- text_description 'Format the string itself'
    set --local -- line_description (format line under --color=yellow 'Add')' and '(format line strikethrough 'customize')' lines'
    if set --local --query -- _flag_help
        help-text 'Intuitively format ANSI' \
            --sub-command={
                'text | '{$text_description},
                'background | Modify the '(format background yellow 'Background')' color',
                'line | '{$line_description}
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
                    set --local -- color_subargs (parse-color {$root_subargs[2..]} || return {$status})
                    set_color {$color_subargs[1]}
                    echo -- {$color_subargs[2..]}
                    set_color --reset
                case bold italics dim
                    set_color --{$root_subargs[1]}
                    echo -- {$root_subargs[2..]}
                    set_color --reset
                case \*
                    $print unknown (format text italics 'Text') sub-command: (format text bold (format background --bright red {$root_subargs[1]})) >&2
            end
        case background
            set --local -- background_subargs (parse-color {$root_subargs} || return {$status})
            set_color --background={$background_subargs[1]}
            echo -- {$background_subargs[2..]}
            set_color --reset
        case line
            $argparse --stop-nonopt h/help\& -- {$root_subargs}
            if set --query --local -- _flag_help
                help-text {$line_description} \
                    --sub-command={
                        'under | Underline the text',
                        'strikethrough | '(format line strikethrough 'Strikethrough')' the string'
                    }
                return 0
            end

            set --local -- line_args {$root_subargs[2..]}
            switch "$root_subargs[1]"
                case under
                    $argparse h/help\& c/color=\& b/bright\& -- {$line_args}
                    set_color --background=(parse-color {$_flag_bright} -- {$_flag_color} || return {$status})
                    echo -- {$argv}
                    set_color --reset
                case strikethrough
                    set_color --strikethrough
                    echo -- {$line_args}
                    set_color --reset
                case \*
                    $print unknown (format text italics 'Line') sub-command: (format text bold (format background --bright red {$root_subargs[1]})) >&2
            end
        case \*
            $print 'unknown sub-command:' (format text bold (format background --bright red {$argv[1]})) >&2
            return 1
    end
end
