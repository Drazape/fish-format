function format --description='Intuitively format ANSI' --argument-names=subcommand
    begin
        set --local -- output_name (set_color --dim)(status function)(set_color --reset)
        set --function -- argparse argparse --name={$output_name}
        set --function -- print echo {$output_name}(set_color --dim white):(set_color --reset)
    end

    $argparse --stop-nonopt 'h/help&' -- {$argv}
    set --erase -- argv[1]

    if set --local --query -- _flag_help
        help-text 'Intuitively format ANSI' \
            --sub-command={
                'text | Format the string itself',
                'background | Colorize the background',
                'line | Add line accessories'
            } \
            --flag='help:h | Show a reference manual for a sub-command'
        return 0
    end
    switch "$subcommand"
        case text
        case background
        case line
        case \*
            $print 'unknown sub-command:' (format text bold (format background --bright red {$argv[1]})) >&2
    end
end
