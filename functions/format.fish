function format --description='Intuitively format ANSI' --argument-names=subcommand
    begin
        set --local -- output_name (set_color --dim)(status function)(set_color --reset)
        set --function -- argparse{,} --name={$output_name}
        set --function -- print echo {$output_name}(set_color --dim white):(set_color --reset)
    end

    $argparse h/help\& -- {$argv}

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
                        'bold | Make the text font '(format text bold 'Bold'),
                        'italics | Make the text font '(format text italics 'Italics')
                        'dim | Make the text font '(format text dim 'Dim')
                    }
                return 0
            end

            switch "$root_subargs[1]"
                case color
                    set --local -- color_subargs (_format_parse-color {$root_subargs[2..]} || return {$status})
                    set_color {$color_subargs[1]}
                    echo {$color_subargs[2..]}
                    set_color --reset
                case bold italics dim
                    set_color --{$root_subargs[1]}
                    echo {$root_subargs[2..]}
                    set_color --reset
                case \*
                    $print unknown (format text italics 'Text') sub-command: (format text bold (format background --bright red {$root_subargs[1]})) >&2
            end
        case background
            set --local -- background_subargs (_format_parse-color {$root_subargs[2..]})
            set_color --background={$background_subargs[1]}
            echo {$background_subargs[2..]}
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

            switch "$root_subargs[1]"
                case under
                case strikethrough
                case \*
                    $print unknown (format text italics 'Line') sub-command: (format text bold (format background --bright red {$root_subargs[1]})) >&2
            end
        case \*
            $print 'unknown sub-command:' (format text bold (format background --bright red {$argv[1]})) >&2
            return 1
    end
end
