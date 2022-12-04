### wsl2_fastcd -> /usr/bin  
- Change directory immediately after login.  
### drop_caches -> /usr/bin  
- Drop cache command.  
### explorer -> /usr/bin  
- Run explorer.exe from wsl to Windows, call target via bash command.  
### wsl2_get_hostip -> /usr/bin
- Get host ip address.  

---

### Custom bin path

#### preload
```
source /cbin/preload
```

#### Path
```
/cbin
├── bin <- binary symbolic link.
├── ...
├── ...
└── preload
```

---

### Windows Terminal Setting

#### wsl2_fastcd
```
"commandline": "wsl --distribution Ubuntu-22.04 --user noonomyen --exec /usr/bin/wsl2_fastcd login noonomyen"
```

#### login to home dir
```
wsl --distribution Ubuntu-22.04 --user noonomyen  --cd ~
```
