#!/bin/bash
#chmod +x run_steam_container.sh

# Allow X11 from container
xhost +local:docker

# Run the container
docker run --rm -it \
  --gpus all \
  -e DISPLAY=:0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -p 5900:5900 \
  --runtime=nvidia \
  steam-wine-gpu
