# easybuild image builder

Uses multi-stage dockerfile build to build module toolchain image.

We can use the output images to mount into our jupyterub containers.

Base GCC
```
podman build -f Dockerfile --target builder -t quay.io/eformat/easybuild-odh-base:latest
```

ODH Base
```
podman build -f Dockerfile --target odh-builder -t quay.io/eformat/easybuild-odh-builder:latest
```

Python-3.8.12
```
podman build -f Dockerfile --target python-3.8-gcc -t quay.io/eformat/easybuild-odh-py3.8-gcc:latest
```

TensorFlow-2.6.0-python3.8
```
podman build -f Dockerfile --target tf-python-3.8-gcc -t quay.io/eformat/easybuild-odh-tf-py3.8-gcc:latest
```
