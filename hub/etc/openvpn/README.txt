1) Symlink pair-net-hook from the pair user bin directory to /etc/openvpn/pair-hook

2) Add someting like the following to your connect/disconnect hook script(s)

  [ -x /etc/openvpn/pair-hook ] && /etc/openvpn/pair-hook openvpn

Overview:

  Script will create a sqlite db reabable by the pair menu.
  The db will contain any connected vpn address which the pair menu can match against it's user configuration.
