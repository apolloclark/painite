FROM apolloclark/kali-linux-web-cli
MAINTAINER apolloclark@gmail.com

# configure apt-get
ENV DEBIAN_FRONTEND noninteractive

# upgrade Kali, install the kali-linux-top10
RUN apt-get -y update

# install Gauntlt
COPY install_gauntlt.sh /root/install_gauntlt.sh
COPY run_gauntlt.sh /root/run_gauntlt.sh
RUN chmod +x /root/run_gauntlt.sh && \
    chmod +x /root/install_gauntlt.sh
    
RUN /root/install_gauntlt.sh

CMD ["/bin/bash", "-l"]
