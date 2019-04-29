# iperf3 service on clearlinux
Iperf is a widely used tool for network performance measurement and tuning.

## build
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


