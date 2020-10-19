FROM golang:1.14-alpine AS builder
RUN apk add --no-cache curl jq git build-base
WORKDIR /opt
RUN cd /opt
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build  -o dnstest cmd/main.go

#FROM alpine:latest
FROM debian:buster-slim
LABEL maintainer="Elf Gzp <gzp@741424975@gmail.com> (https://elfgzp.cn)"
COPY --from=builder /opt/dnstest ./
RUN chmod +x /dnstest
CMD ["/dnstest"]