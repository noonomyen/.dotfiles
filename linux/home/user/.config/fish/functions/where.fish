function where
    if test (count $argv) -eq 0
        echo "Usage: where <command>"
        return 1
    end

    set cmd $argv[1]

    if not type -q -- $cmd
        echo "Command '$cmd' not found"
        return 127
    end

    if functions -q -- $cmd
        set desc (functions -D -- $cmd)

        if string match -qr '^alias ' -- $desc
            set target (string replace -r "^alias $cmd=" "" $desc)
            echo "Alias: $cmd -> $target"
        else
            echo "Function: $cmd"
            functions -- $cmd
        end
        echo
    end

    if contains -- $cmd (builtin -n)
        echo "Builtin: $cmd"
        echo
    end

    for path in (type -ap -- $cmd)
        if test "$path" != "-" -a -x "$path"
            echo $path
        end
    end

    return 0
end

