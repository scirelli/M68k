### Setup Instructions
Following [this](https://github.com/scirelli/xeyes_in_docker) since I'm on a Mac.
This image is built to connect to docker mac host. When building it will run wine and an installer will popup.

```
./build.sh
```

### Testing
```
docker run --rm -it --entrypoint sh -v /tmp/t:/tmp/t scirelli/asm68k:latest
docker run --rm -t -v `pwd`:/tmp scirelli/asm68k:latest ./examples/gamehut.s
```

### Execute 
```
/.run.sh
```
