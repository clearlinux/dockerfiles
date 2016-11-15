FROM clearlinux
MAINTAINER marcos.simental.magana@intel.com

ARG swupd_args
ENV HOME=/root/

RUN swupd update $swupd_args
RUN swupd bundle-add cryptography sysadmin-hostmgmt go-basic c-basic openstack-common openstack-python-clients $swupd_args

RUN ansible-galaxy install -r /usr/share/ansible/examples/ciao/requirements.yml --ignore-certs

RUN rm -rf /var/lib/swupd

CMD 'bash'
