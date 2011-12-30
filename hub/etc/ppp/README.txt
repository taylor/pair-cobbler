Add something like these to the up and down stuff

  [ -x /etc/ppp/pair-hook ] && /etc/ppp/pair-hook up "$@" 

  [ -x /etc/ppp/pair-hook ] && /etc/ppp/pair-hook down "$@" 
