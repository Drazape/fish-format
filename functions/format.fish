function format --description='Intuitively format ANSI' --argument-names=subcommand --inherit-variable=_format_colors
    set --local -- fun_name (status current-function)
    begin
        set --local -- output_name ($fun_name text dim {$fun_name})
        set --function -- argparse{,} --name={$output_name}
        set --function -- print echo -- {$output_name}($fun_name text dim ($fun_name text color white :))
    end

    $argparse --stop-nonopt h/help\& -- {$argv}

    function evaluate-color --description='Parse color names for use with `set_color`' --inherit-variable={print,argparse,_format_colors}
        set --local text {$argv[3..]}
        $argparse --min-args=1 --ignore-unknown b/bright\& -- {$argv[1..2]}
        set --query --local -- _flag_bright && set --local -- bright br

        set --local -- color {$argv[1]}
        if ! contains -- {$color} {$_format_colors}
            $print 'Unknown color name:' ($fun_name text bold ($fun_name background --bright red {$color})) >&2
            return 10
        end

        string repeat -- 1 "$bright"{$color} {$argv[2]} {$text}
    end

    # Root Descriptions
    set --local -- text_description 'Format the string itself'
    set --local -- line_description 'Add and customize lines'
    if set --local --query -- _flag_help
        help-text 'Intuitively format ANSI' \
            --sub-command={
                'text | '{$text_description},
                'background | Modify the '($fun_name background yellow 'Background')' color',
                'line | '{$line_description},
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
                        'color | '($fun_name text color yellow 'Colorize')' the text string',
                        'bold | '($fun_name text bold 'Bolden')' the text font',
                        'italics | '($fun_name text italics 'Italicize')' the text font',
                        'dim | '($fun_name text dim 'Dim')' the text color'
                    }
                return 0
            end

            switch "$root_subargs[1]"
                case color
                    set --local -- color_subargs (evaluate-color {$root_subargs[2..]} || return {$status})
                    string repeat -- 1 (set_color {$color_subargs[1]}
                        ){$color_subargs[2..]}(
                        set_color --reset)
                case bold italics dim
                    string repeat -- 1 (set_color --{$root_subargs[1]}
                        ){$root_subargs[2..]}(
                        set_color --reset)
                case \*
                    $print unknown ($fun_name text italics 'Text') sub-command: ($fun_name text bold ($fun_name background --bright red {$root_subargs[1]})) >&2
            end
        case background
            set --local -- background_subargs (evaluate-color {$root_subargs} || return {$status})
            string repeat -- 1 (set_color --background={$background_subargs[1]}
                ){$background_subargs[2..]}(
                set_color --reset)
        case line
            $argparse --stop-nonopt h/help\& -- {$root_subargs}
            if set --query --local -- _flag_help
                help-text {$line_description} \
                    --sub-command={
                        'under | '($fun_name line under white 'Underline')' the text',
                        'strikethrough | '($fun_name line strikethrough 'Strikethrough')' the string'
                    }
                return 0
            end

            set --local -- line_args {$root_subargs[2..]}
            switch "$root_subargs[1]"
                case under
                    set --local -- color_subargs (evaluate-color {$line_args} || return {$status})
                    string repeat -- 1 (set_color --underline --underline-color={$color_subargs[1]}
                        ){$color_subargs[2..]}(
                        set_color --reset)
                case strikethrough
                    string repeat -- 1 (set_color --strikethrough
                        ){$line_args}(
                        set_color --reset)
                case \*
                    $print unknown ($fun_name text italics 'Line') sub-command: ($fun_name text bold ($fun_name background --bright red {$root_subargs[1]})) >&2
            end
        case url
            test (count {$root_subargs}) -gt 2 && $print ($fun_name text bold 'url'): Expected ($fun_name text italics 2) 'arguments; got' ($fun_name background red (count {$root_asubargs}))
            echo -e -- '\e]8;;'"$root_subargs[1]"'\a'{$root_subargs[2..]}'\e]8;;\a'
        case reverse
            string repeat -- 1 (set_color --reverse
                ){$root_subargs}(
                set_color --reset)
        case \*
            $print 'unknown sub-command:' ($fun_name text bold ($fun_name background --bright red {$argv[1]})) >&2
            return 1
    end
end
