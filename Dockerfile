FROM nvidia/cuda:12.2.0-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && apt-get update

RUN apt update && apt install -y \
    software-properties-common \
    wine64 wine32 winetricks \
    xvfb ffmpeg \
    cabextract curl unzip wget \
    libgl1-mesa-glx libxcomposite1 libxrandr2 libxi6 libxcursor1 \
    lib32z1 \
    lib32ncurses6 \
    && rm -rf /var/lib/apt/lists/*

#RUN wineboot --init

#RUN wget -O /tmp/steamsetup.exe https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe && \
#    wine /tmp/steamsetup.exe

#ENV WINEPREFIX=/wineprefix
#RUN mkdir -p $WINEPREFIX && wineboot --init

#RUN rm -f /tmp/steamsetup.exe

#RUN winetricks -q steam

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
