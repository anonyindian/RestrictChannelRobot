# Build Stage: Build bot using the alpine image, also install doppler in it
FROM golang:1.18.0-alpine3.15 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=`go env GOHOSTOS` GOARCH=`go env GOHOSTARCH` go build -o out/RestrictChannelRobot

# Run Stage: Run bot using the bot and doppler binary copied from build stage
FROM gcr.io/distroless/static
COPY --from=builder /app/out/RestrictChannelRobot /

CMD ["/RestrictChannelRobot"]
