complete -c dgpu-mode -f
complete -c dgpu-mode -n "not __fish_seen_subcommand_from nvidia vfio off" -a nvidia -d "Bind dGPU to host nvidia driver"
complete -c dgpu-mode -n "not __fish_seen_subcommand_from nvidia vfio off" -a vfio -d "Bind dGPU to vfio-pci for VM passthrough"
complete -c dgpu-mode -n "not __fish_seen_subcommand_from nvidia vfio off" -a off -d "Power off dGPU via ASUS WMI"
complete -c dgpu-mode -l force -d "Force switch even when current state is unknown"
complete -c dgpu-mode -s h -l help -d "Show help"
