FROM golang:1.14-alpine AS builder
RUN apk add --no-cache curl jq git build-base
WORKDIR /opt
RUN cd /opt
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build  -o dnstest cmd/main.go

FROM alpine:latest
LABEL maintainer="Elf Gzp <gzp@741424975@gmail.com> (https://elfgzp.cn)"
COPY --from=builder /opt/dnstest ./
RUN chmod +x /dnstest
CMD ["/dnstest"]