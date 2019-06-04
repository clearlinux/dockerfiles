FROM clearlinux:latest
MAINTAINER mark.d.horn@intel.com

# Configure Go
ENV GOPATH="/go" PATH="/go/bin:${PATH}"

# Update and add bundles
RUN swupd update && \
    swupd bundle-add sysadmin-basic storage-utils network-basic go-basic-dev devpkg-gtk3 clr-installer-gui && \
    swupd clean && \
    # Install the Go Linters
    go get -u gopkg.in/alecthomas/gometalinter.v2 && \
    gometalinter.v2 --install
