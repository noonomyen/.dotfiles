complete -c huge -f
complete -c huge -n "not __fish_seen_subcommand_from list 0" -a list -d "List processes currently using hugepages"
complete -c huge -n "not __fish_seen_subcommand_from list 0" -a 0 -d "Release all hugepages"
complete -c huge -s h -l help -d "Show help"
