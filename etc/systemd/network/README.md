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


## Configuration

For each container network we have a virtual bridge device that is configured with a `.netdev` file. Here is [an example](./40-vpnbridge0.netdev), the netdev file will ensure the virtual network device is created when systemd-networkd starts.

For instance if we configure the [.netdev file for the vpnbridge](./40-vpnbridge0.netdev), then when systemd-networkd starts/restarts we should see a virtual device called `vpnbridge0` along with other confitured devices.

```sh
$ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: eno0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether d4:93:90:21:1a:30 brd ff:ff:ff:ff:ff:ff
    altname enp73s0
    altname enxd49390211a30
4: cbridge0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 1e:ac:8e:7f:1e:ff brd ff:ff:ff:ff:ff:ff
5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether f4:c8:8a:3c:d9:35 brd ff:ff:ff:ff:ff:ff
    inet 192.168.50.167/24 metric 1024 brd 192.168.50.255 scope global dynamic wlan0
       valid_lft 86393sec preferred_lft 86393sec
    inet6 fe80::f6c8:8aff:fe3c:d935/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
6: vpnbridge0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether ca:66:37:c6:91:78 brd ff:ff:ff:ff:ff:ff

```

The network configuration is processed in alpha-numeric order so files with a name `30-vpn-container.network` will match devices before `40-cbridge0.network`.


