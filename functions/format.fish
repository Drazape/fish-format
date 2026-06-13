function format --description='Intuitively format ANSI'
    begin
        set --local -- output_name (set_color --dim)(status function)(set_color --reset)
        set --function -- argparse argparse --name={$output_name}
        set --function -- print echo {$output_name}(set_color --dim white):(set_color --reset)
    end

    $argparse --stop-nonopt 'h/help&' -- {$argv}

    switch {$argv[1]}
    end
end
