1) Symlink pair-net-hook from the pair user bin directory to /etc/ppp/pair-hook

2) Add something like these to the up and down scripts

  [ -x /etc/ppp/pair-hook ] && /etc/ppp/pair-hook pptp up "$@" 

  [ -x /etc/ppp/pair-hook ] && /etc/ppp/pair-hook pptp down "$@" 
