- In OBS:
  - Add Media Source
  - Uncheck "Local File"
  - Input: rtmp://localhost/live/stream
  - Set buffer to 100ms or less for low latency

- If you’re on WSL2 and not Docker Desktop, use $(grep nameserver /etc/resolv.conf | awk '{print $2}') instead of host.docker.internal.

$ `docker-compose build`
$ `docker-compose up`
