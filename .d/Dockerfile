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

ARG http_proxy

ENV http_proxy ${http_proxy}
ENV https_proxy ${http_proxy}

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

ARG ssh_key

RUN mkdir -p ~/.ssh
RUN echo "${ssh_key}" | tee ~/.ssh/authorized_keys

#                  _   
#  _ __ ___   ___ | |_ 
# | '__/ _ \ / _ \| __|
# | | | (_) | (_) | |_ 
# |_|  \___/ \___/ \__|

USER root

ENTRYPOINT exec /usr/sbin/sshd -De
EXPOSE 22
VOLUME /vagrant
