function where --description 'Custom where command to locate aliases, functions, builtins, and abbreviations'
    if test (count $argv) -eq 0
        echo (set_color red)"Usage: where <command1> [command2 ...]"(set_color normal)
        return 1
    end

    set -l total (count $argv)
    for i in (seq $total)
        set -l cmd $argv[$i]
        set -l found 0

        # 1. Check if it is an Abbreviation
        if abbr -q -- $cmd
            set -l abbr_show (abbr --show | string match -r -- "^abbr -a (?:-- )?"(string escape --style=regex -- $cmd)"\s+.*")
            # Extract expansion
            set -l expansion (string replace -r -- "^abbr -a (?:-- )?"(string escape --style=regex -- $cmd)"\s+" "" $abbr_show)
            # Strip outer quotes if present
            set expansion (string replace -r -- "^'(.*)'\$" '$1' $expansion)
            set expansion (string replace -r -- '^"(.*)"$' '$1' $expansion)
            
            echo (set_color green)"Abbreviation:"(set_color normal) "$cmd" (set_color yellow)"->"(set_color normal) (set_color --bold)"$expansion"(set_color normal)
            set found 1
        end

        # 2. Check if it is a Function or Alias
        if functions -q -- $cmd
            set -l definition (functions $cmd)
            # Find the line containing the function definition
            set -l func_line (string match -r -- "^function $cmd\s+.*" -- $definition)
            
            # Check if it has an alias description
            set -l alias_match (string match -r -- "--description ['\"]alias "(string escape --style=regex -- $cmd)"=(.*?)['\"]" -- $func_line)
            
            if test (count $alias_match) -gt 0
                set -l target $alias_match[2]
                echo (set_color green)"Alias:"(set_color normal) "$cmd" (set_color yellow)"->"(set_color normal) "$target"
            else
                echo (set_color green)"Function:"(set_color normal) "$cmd"
                # Print definition without source comments
                for line in $definition
                    if not string match -qr '^#' -- $line
                        echo $line
                    end
                end
            end
            set found 1
        end

        # 3. Check if it is a Shell Builtin
        if contains -- $cmd (builtin -n)
            echo (set_color green)"Builtin:"(set_color normal) "$cmd"
            set found 1
        end

        # 4. Check for Executables in PATH
        set -l paths (type -ap -- $cmd)
        if test (count $paths) -gt 0
            for path in $paths
                if test "$path" != "-" -a -x "$path"
                    echo (set_color green)"Executable:"(set_color normal) "$path"
                    set found 1
                end
            end
        end

        # If not found at all
        if test $found -eq 0
            echo (set_color red)"Command '$cmd' not found"(set_color normal)
        end

        # Print empty line ONLY between multiple commands, not at the end
        if test $i -lt $total
            echo
        end
    end

    return 0
end
