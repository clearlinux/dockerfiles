# iperf3 service on clearlinux
Iperf is a widely used tool for network performance measurement and tuning.

## Build
```
sudo docker build -t clr-iperf:latest .
```

## Run as Server:
```
sudo docker run -it --rm --name=iperf-srv -p 5201:5201 clr-iperf -s
```

## Run as Client (first get server IP address):
```
sudo docker run -it --rm --network=host clr-iperf -c <SERVER_IP>
```

## Extra Build ARGs
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
