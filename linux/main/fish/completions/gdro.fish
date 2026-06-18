complete -c gdro -f

function __gdro_get_docker_run_completions
    set -l tokens (commandline -opc)
    set -l lastArg (string escape -- (commandline -ct))
    set -e tokens[1]
    set -l fake_args docker run

    for t in $tokens
        if test "$t" != "-rw"
            set fake_args $fake_args $t
        end
    end

    set -l requestComp "DOCKER_ACTIVE_HELP=0 $fake_args[1] __complete $fake_args[2..-1] $lastArg"
    set -l results (eval $requestComp 2> /dev/null)

    if test (count $results) -gt 1
        set -l flagPrefix (string match -r -- '-.*=' "$lastArg")
        for comp in $results[1..-2]
            if test (string trim -- "$comp") != ""
                printf "%s%s\n" "$flagPrefix" "$comp"
            end
        end
    end
end

complete -c gdro -a "(__gdro_get_docker_run_completions)"
complete -c gdro -n "string match -r '^-' -- (commandline -ct)" -l rw -d 'Mount current directory with Read-Write permissions'
