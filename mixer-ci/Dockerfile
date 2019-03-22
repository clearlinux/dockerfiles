FROM clearlinux:latest
MAINTAINER kevin.c.wells@intel.com

# Configure Go
ENV GOPATH /home/clr/go
ENV PATH="/home/clr/go/bin:${PATH}"

# Update and add bundles
RUN swupd update && \
    swupd bundle-add mixer go-basic c-basic os-core-update-dev && \
    useradd -G wheelnopw clr && \
    mkdir -p /run/lock
USER clr
RUN git config --global user.email "travis@example.com" && \
    git config --global user.name "Travis CI" && \
    go get -u gopkg.in/alecthomas/gometalinter.v2 && \
    gometalinter.v2 --install

