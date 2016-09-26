FROM clearlinux
MAINTAINER marcos.simental.magana@intel.com

ARG swupd_args
ENV HOME=/root/

RUN swupd bundle-add sysadmin-hostmgmt go-basic c-basic kvm-host openstack-common $swupd_args

RUN cp -r /usr/share/ansible/examples/ciao /root/
RUN ansible-galaxy install -r /root/ciao/requirements.yml --ignore-certs

RUN rm -rf /var/lib/swupd

CMD 'bash'
