## Datetime and NTP Sync

- https://ubuntu.com/server/docs/network-ntp

---

### install
```sh
sudo apt install chrony
```

### config
`/etc/chrony/chrony.conf`

---

### systemd
```sh
sudo systemctl restart chrony.service
```

### non-systemd
```sh
sudo service chrony restart
```

