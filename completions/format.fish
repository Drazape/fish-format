set --local -- common_complete complete --command=format --no-files

$common_complete
$common_complete --short-option=h --long-option=help --description='Reference manuals' \
    --condition='
        set --local -- subcommands (commandline --tokens-expanded --current-process --cut-at-cursor)[2..3]
        test -z "$subcommands" ||
        contains -- "$subcommands[1]" text line && test -z "$subcommands[2]"
    '
begin
    set --local -- subcommand_complete {$common_complete} --condition='test (count (commandline -xpc)) -lt 2'
    $subcommand_complete --arguments=text --description='Format the string itself'
    $subcommand_complete --arguments=background --description='Modify the background color'
    $subcommand_complete --arguments=line --description='Add & Customize lines'
end

begin
    set --local -- text_complete {$common_complete} \
        --condition='
            set --local -- unbase (commandline --tokens-expanded --current-process --cut-at-cursor)[2..3]
            test "$unbase[1]" = text && ! contains -- "$unbase[2]" color bold italics dim
        '
    $text_complete --arguments=color --description='Colorize the text'

    $text_complete --arguments=bold --description='Bolden the font'
    $text_complete --arguments=italics --description='Italicize the font'
    $text_complete --arguments=dim --description='Dim the color'
end

begin # Colors
    function expects-color --description='Check if `format` expects a color' --inherit-variable=_format_colors
        argparse --ignore-unknown b/bright\& -- (commandline --tokens-expanded --current-process --cut-at-cursor)[2..6]
        set --erase -- _flag_b{,right}
        if test "$argv[1]" = text && test "$argv[2]" = color
            test (count {$argv}) -eq 2 && return 0
            contains -- "$argv[3]" {$_format_colors} && return 1
            return 2
        end
        if test "$argv[1]" = background
            contains -- "$argv[2]" {$_format_colors} && return 3
            return 0
        end
        return 4
    end
    $common_complete --arguments="$_format_colors" --condition=expects-color
    $common_complete --short-option=b --long-option=bright --description='Brighten the text color' --condition={expects-color,'! __fish_seen_argument --short=b --long=bright'}
end

begin
    set --local -- line_complete {$common_complete} --condition='
            set --local -- args (commandline --tokens-expanded --current-process --cut-at-cursor)[2..3]
            test (count {$args}) -le 1 && test "$args[1]" = line
        '
    $line_complete --arguments=under --description='Underline the text'
    $line_complete --arguments=strikethrough --description='Strikethrough the string'
end
begin
    function flags-accepted --description='Check if the underline command accepts flags'
        set --local -- args (commandline --tokens-expanded --current-process --cut-at-cursor)[2..]
        contains -- -- {$args} && return 1
        test "$args[1]" = line && test "$args[2]" = under && return 0
        return 2
    end
    set --local -- under_complete {$common_complete} --condition=flags-accepted
    $under_complete --short-option=c --long-option=color --require-parameter --description='Underline color' --arguments="$_format_colors" --condition='! __fish_seen_argument --short=c --long=color'
    $under_complete --short-option=b --long-option=bright --description='Brighten the color' --condition='! __fish_seen_argument --short=b --long=bright'
end
