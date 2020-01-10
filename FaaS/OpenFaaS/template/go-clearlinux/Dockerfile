FROM openfaas/classic-watchdog:0.18.1 as watchdog

FROM clearlinux/golang as builder

# Allows you to add additional packages via build-arg
ARG CGO_ENABLED=0

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

WORKDIR /go/src/handler
COPY . .

# install bundles if required
# PLEASE input bundle line by line
COPY function/bundles.txt  .
RUN for bundle in $(cat bundles.txt); do \
        swupd bundle-add $bundle $swupd_args; \
    done

# Run a gofmt and exclude all vendored code.
RUN test -z "$(gofmt -l $(find . -type f -name '*.go' -not -path "./vendor/*" -not -path "./function/vendor/*"))" || { echo "Run \"gofmt -s -w\" on your Golang code"; exit 1; }

RUN CGO_ENABLED=${CGO_ENABLED} GOOS=linux \
    go build --ldflags "-s -w" -a -installsuffix cgo -o handler . && \
    go test $(go list ./... | grep -v /vendor/) -cover

FROM clearlinux:base

# Add non root user
RUN groupadd app && useradd -g app app
RUN mkdir -p /home/app

WORKDIR /home/app

# install bundles if required
# PLEASE input bundle line by line
COPY function/bundles.txt  .
RUN for bundle in $(cat bundles.txt); do \
        swupd bundle-add $bundle $swupd_args; \
    done

COPY --from=builder /usr/bin/fwatchdog         .
COPY --from=builder /go/src/handler/function/  .
COPY --from=builder /go/src/handler/handler    .

RUN chown -R app /home/app

USER app

ENV fprocess="./handler"
EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fwatchdog"]
