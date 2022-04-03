---
layout: post
title:  "Connecting to WireGuard VPN Tunnel"
date:   2022-04-02 00:00:00 +0530
categories: vpn security
---

This guide provides the minimal first-step instructions required to connect to any WireGuard based VPN server.
If you also want to set up your own WireGuard server, you may start by reading the official [quickstart](https://www.wireguard.com/quickstart/) guide.

I'll be using a free-to-use, WireGuard based VPN service, SecurityKiss. 
They provide a limited free plan and affordable paid plans. No email registration is required to use it. The same steps should apply to other WireGuard based VPN servers as well.

Start by downloading a VPN client configuration file from [securitykiss.com/download](https://securitykiss.com/download.html)

The downloaded file would contain the following details.

```
[Interface]
Address=<interface-ip>
PrivateKey=<client-private-key>
DNS=8.8.8.8

[Peer]
PublicKey=<server-public-key>
Endpoint=<server-public-ip>:7668
AllowedIPs=0.0.0.0/0,::/0
PersistentKeepalive=25
```

SecurityKiss would generate all the placeholder values including the private key. 
So you don't have to make any modifications to the downloaded config file to be able to use it.

Then install the WireGuard client. `wireguard` meta package include command line tools required to connect to WireGuard VPN servers.

```
sudo apt update
sudo apt install wireguard resolvconf
```

`resolvconf` is internally used by `wireguard` to set the interface's DNS servers specified in the configuration file.


Copy or move the config file to `/etc/wireguard/`

```
sudo cp US_New_York_1.conf /etc/wireguard/
```

Then to connect to the VPN tunnel:

```
sudo systemctl enable wg-quick@US_New_York_1
```

Make sure to replace `US_New_York_1` with the name of your configuration file.

This will brings up a new network interface with properties supplied in the given configuration file.
The name of the network interface would be as same as the name of the configuration file.

`systemctl enable` is used to make `wg-quick.service` start at boot.

To find the details about the newly added network interface, run:

```
ip address show
ip address show US_New_York_1
```

