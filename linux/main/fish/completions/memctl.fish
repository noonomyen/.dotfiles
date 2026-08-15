# Fish completion for memctl
complete -c memctl -f

# Main subcommands
complete -c memctl -n "__fish_use_subcommand" -a info -d "Show memory status overview"
complete -c memctl -n "__fish_use_subcommand" -a swap -d "Swap management"
complete -c memctl -n "__fish_use_subcommand" -a cache -d "Cache management"
complete -c memctl -n "__fish_use_subcommand" -a huge -d "Hugepages management"
complete -c memctl -s h -l help -d "Show help"

# Subcommands for 'swap'
complete -c memctl -n "__fish_seen_subcommand_from swap; and not __fish_seen_subcommand_from release status" -a release -d "Safely release swap memory back into RAM"
complete -c memctl -n "__fish_seen_subcommand_from swap; and not __fish_seen_subcommand_from release status" -a status -d "Show swap & zswap status details"
complete -c memctl -n "__fish_seen_subcommand_from swap; and __fish_seen_subcommand_from release" -s f -l force -d "Force release despite low RAM warning"

# Subcommands for 'cache'
complete -c memctl -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from drop" -a drop -d "Drop system caches"
complete -c memctl -n "__fish_seen_subcommand_from drop" -a "1" -d "Pagecache"
complete -c memctl -n "__fish_seen_subcommand_from drop" -a "2" -d "Dentries & Inodes"
complete -c memctl -n "__fish_seen_subcommand_from drop" -a "3" -d "Pagecache, Dentries & Inodes (default)"

# Subcommands for 'huge'
complete -c memctl -n "__fish_seen_subcommand_from huge; and not __fish_seen_subcommand_from status list release set" -a status -d "Show hugepages status"
complete -c memctl -n "__fish_seen_subcommand_from huge; and not __fish_seen_subcommand_from status list release set" -a list -d "List processes using hugepages"
complete -c memctl -n "__fish_seen_subcommand_from huge; and not __fish_seen_subcommand_from status list release set" -a release -d "Release all hugepages"
complete -c memctl -n "__fish_seen_subcommand_from huge; and not __fish_seen_subcommand_from status list release set" -a set -d "Allocate N 2MB hugepages"
