FROM kalilinux/kali-linux-docker
MAINTAINER apolloclark@gmail.com

# configure apt-get
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive

# upgrade Kali, install the kali-linux-top10
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get clean
RUN apt-get -y install kali-linux-top10

# install Gauntlt
ADD install_gauntlt.sh /root/install_gauntlt.sh
RUN chmod +x /root/install_gauntlt.sh && \
    /root/install_gauntlt.sh
    
# expose ports
EXPOSE 0-65535

CMD ["/bin/bash"]
