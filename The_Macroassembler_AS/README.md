```
mkdir -P /tmp/mnt
cp quickTest.sh /tmp/mnt
docker run --rm -it --volume /tmp/mnt:/tmp/mnt --entrypoint bash python:latest
```

```
docker run --rm -it --entrypoint sh -v /tmp/t:/tmp/t asl:latest
docker run --rm asl:latest /tmp/t/gamehut.s
```

### References
* http://john.ccac.rwth-aachen.de:8000/as/
* https://github.com/KubaO/asl
* https://github.com/0cjs/8bitdev
* https://www.systutorials.com/docs/linux/man/1-asl/
