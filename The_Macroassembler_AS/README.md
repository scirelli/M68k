```
script_folder=`pwd` \
docker run --rm -it --volume $script_folder:/tmp/src --entrypoint bash python:latest
```

### References
* http://john.ccac.rwth-aachen.de:8000/as/
* https://github.com/KubaO/asl
* https://github.com/0cjs/8bitdev
