#      _            _             
#   __| | ___   ___| | _____ _ __ 
#  / _` |/ _ \ / __| |/ / _ \ '__|
# | (_| | (_) | (__|   <  __/ |   
#  \__,_|\___/ \___|_|\_\___|_|   
                                
FROM imma:base
                 
#   ___ _ ____   __
#  / _ \ '_ \ \ / /
# |  __/ | | \ V / 
#  \___|_| |_|\_/  

ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV meh meh

#                  _   
#  _ __ ___   ___ | |_ 
# | '__/ _ \ / _ \| __|
# | | | (_) | (_) | |_ 
# |_|  \___/ \___/ \__|

USER root

RUN cloud-init init

#        _                 _         
#  _   _| |__  _   _ _ __ | |_ _   _ 
# | | | | '_ \| | | | '_ \| __| | | |
# | |_| | |_) | |_| | | | | |_| |_| |
#  \__,_|_.__/ \__,_|_| |_|\__|\__,_|
                                   
USER ubuntu

RUN mkdir -p ~/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCa58hGFG5RYR3eDrJLX8SSQtLtM9ofOzQx3yxDMkFlfg1jsKkIWpZ5jv+Zga3k08Xuaqpm21LPVtlC+N8LPXSPEbwymxNgbkbO+LJF9TL4l/ZhzBXSiooXCZ7XJUtSc6OrjpXHpsMvCN7ghFugryt7YgFmjXxnAN9kqNxYs5KVYgWPyzSWIHCDWvfrXrlTOArb+8+72XbdkUxd1DPG4sfreQsdyajAkIKEd/fJLAkOIgZqcmxoxUIV1ElX3dceI3grxZLPDs88Joncu4ycYObIjXI/qeat2gu5EeSOgEwsY3MrgAtTLc9oSptArZcS5HSIb6rc6wAXDzVa95k0Hskf defn0" | tee ~/.ssh/authorized_keys
ADD etc/authorized_keys ~/.ssh/meh

#                  _   
#  _ __ ___   ___ | |_ 
# | '__/ _ \ / _ \| __|
# | | | (_) | (_) | |_ 
# |_|  \___/ \___/ \__|

USER root

ENTRYPOINT exec /usr/sbin/sshd -De
EXPOSE 22
VOLUME /vagrant
