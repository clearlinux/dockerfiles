FROM clearlinux:latest
ARG clear_ver

# Configure Go
ENV GOPATH="/go" PATH="/go/bin:${PATH}"

# Update and add bundles
RUN swupd update -V $clear_ver && \
    swupd bundle-add sysadmin-basic storage-utils network-basic go-basic-dev devpkg-gtk3 clr-installer-gui && \
    swupd clean && \
    # Install the Go Linters
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
