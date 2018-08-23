FROM clearlinux:latest
MAINTAINER mark.d.horn@intel.com

# Configure Go
ENV GOPATH="/go" PATH="/go/bin:${PATH}"

    # Configure trust
RUN clrtrust generate && \
    # Update and add bundles
    swupd update && \
    swupd bundle-add sysadmin-basic storage-utils network-basic go-basic-dev git telemetrics && \
    # Install the Go Linters
    go get -u gopkg.in/alecthomas/gometalinter.v2 && \
    gometalinter.v2 --install
