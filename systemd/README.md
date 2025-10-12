# About

Herein contains various systemd services file.


## DNS

There is a service unit configured to run an nspawn container as the dns service. Located at [./usr/lib/systemd/system/nspawn-dns.service](./usr/lib/systemd/system/nspawn-dns.service). To enable this service you can run this command from the root of this repository.


```zsh
sudo cp systemd/usr/lib/systemd/system/nspawn-dns.service

sudo systemctl enable --nown nspawn-dns.service
```
