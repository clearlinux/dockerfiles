FROM clearlinux:latest
MAINTAINER long1.wang@intel.com
#RUN swupd mirror -s http://xxx.xxx/pub/mirrors/clearlinux/update
RUN swupd bundle-add sysadmin-basic

# Define default command
ENTRYPOINT ["iperf3"]

# Expose ports
EXPOSE 5201
