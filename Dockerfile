FROM apolloclark/kali-linux-web-cli
MAINTAINER apolloclark@gmail.com

# configure apt-get
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive

# update Kali, install the kali-linux-web
RUN apt-get -y update

# install Gauntlt
COPY install_gauntlt.sh /root/install_gauntlt.sh
COPY run_gauntlt.sh /root/run_gauntlt.sh
RUN chmod +x /root/run_gauntlt.sh && \
    chmod +x /root/install_gauntlt.sh
    
RUN /root/install_gauntlt.sh

CMD ["/bin/bash", "-l"]
