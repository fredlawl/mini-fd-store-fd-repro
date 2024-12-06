Diagnostics:

Window 1:
```bash
$ sudo systemd-analyze set-log-level debug
$ sudo journalctl -f /usr/lib/systemd/systemd
```

Window 2:
```bash
$ sudo journalctl -fu test-unit.service
```

Window 3:
```bash
$ sudo -s make uninstall
$ sudo -s make start
$ sudo -s make swap
```