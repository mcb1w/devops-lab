FROM golang:1.27-alpine

WORKDIR /app

COPY go.mod ./
COPY *.go ./

RUN go build -o devops-lab .

EXPOSE 8000

HEALTHCHECK --interval=10s --timeout=3s --start-period=3s --retries=3 \
  CMD wget -q -O /dev/null "http://127.0.0.1:${PORT:-8000}/health" || exit 1

CMD ["./devops-lab"]