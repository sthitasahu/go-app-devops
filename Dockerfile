#This is the dockerfile of the go-project
#This dockerfile will be used to build the image and run the container

FROM golang:1.22  as base

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .
  
RUN go build -o main .


FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]

