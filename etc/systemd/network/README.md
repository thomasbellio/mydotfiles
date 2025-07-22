# About

I use [systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd) to manage my local container network. 

The container network is assigned to a [bridge device](https://wiki.archlinux.org/title/Network_bridge) that can be created using the [10-cbridge0.netdev](./10-cbridge0.netdev).

Then the bridge network is configured with [10-cbridge0.network](./10-cbridge0.network), which assigns an ip address to the link and enables DHCP.

Finally the network configuration at [10-container-veth.network](./10-container-veth.network) which matches virtual ethernet devices like 've-*' which is the conventional name for [systemd-nspawn](https://wiki.archlinux.org/title/Systemd-nspawn), when using the `--network-veth` option for starting systemd-nspawn containers. For example like this: 

```sh
sudo systemd-nspawn -D /var/lib/machines/ansible-orchestrator  --private-network --network-veth   --boot
```

This will create an virtual ethernet link on the host that looks like this: 

```txt
10: ve-ansible-KI1d@if2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master cbridge0 state UP mode DEFAULT group default qlen 1000
    link/ether 92:fc:b4:b7:8b:4b brd ff:ff:ff:ff:ff:ff link-netnsid 1
    altname ve-ansible-orchestrator

```

On the container the link is named `host0`. On the container you need to make sure that the `systemd-networkd` service is enabled: `sudo systemctl enable --now systemd-networkd`. Also on the host and the container we need to ensure that `systemd-resolved` is enabled, which enables domain name resolution for the containers and to the internet.  



