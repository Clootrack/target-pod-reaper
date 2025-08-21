# Build
FROM golang:1.17 AS build

RUN mkdir /app
WORKDIR /app

ENV CGO_ENABLED=0 GOOS=linux

COPY ./ ./
RUN go build -o pod-reaper -a -installsuffix go ./reaper

# Application
FROM scratch
COPY --from=build /app/pod-reaper /
CMD ["/pod-reaper"]
