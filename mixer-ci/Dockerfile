FROM clearlinux:latest
ARG clear_ver

# Configure Go
ENV GOPATH /home/clr/go
ENV PATH="/home/clr/go/bin:${PATH}"

# Update and add bundles
RUN swupd update -V $clear_ver && \
    swupd bundle-add mixer go-basic c-basic os-core-update-dev sudo && \
    useradd -G wheelnopw clr && \
    mkdir -p /run/lock
USER clr
RUN git config --global user.email "travis@example.com" && \
    git config --global user.name "Travis CI"
