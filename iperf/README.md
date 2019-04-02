# iperf3 service on clearlinux
Iperf is a widely used tool for network performance measurement and tuning.

## build
```
sudo docker build -t clr-iperf:latest .
```

## Run as Server:
```
sudo docker run  -it --rm --name=iperf-srv -p 5201:5201 --network host clr-iperf -s
```

## Run as Client (first get server IP address):
```
sudo docker run  -it --rm clr-iperf -c <SERVER_IP> --network host
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
