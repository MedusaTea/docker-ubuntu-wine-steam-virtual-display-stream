FROM nvidia/cuda:12.2.0-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEPREFIX=/wineprefix

RUN apt update && apt install -y \
    software-properties-common \
    wine64 winetricks \
    xvfb ffmpeg \
    cabextract curl unzip wget \
    libgl1-mesa-glx libxcomposite1 libxrandr2 libxi6 libxcursor1 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /wineprefix && wineboot --init
RUN winetricks -q steam

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
