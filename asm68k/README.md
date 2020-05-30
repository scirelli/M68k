### Setup Instructions

Testing
```
docker run --rm -it --entrypoint sh -v /tmp/t:/tmp/t scirelli/asm68k:latest
docker run --rm -t -v `pwd`:/tmp scirelli/asm68k:latest ./examples/gamehut.s
```

Example makefile:
```
make
```
