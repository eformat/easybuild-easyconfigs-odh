# easybuild image builder

Uses multi-stage dockerfile build to build module toolchain image.

We can use the output images to mount into our jupyterub containers.

Base GCC
```
podman build -f Dockerfile --target builder -t quay.io/eformat/easybuild-odh-base:latest
```

TensorFlow-2.6.0-python3.8
```
podman build -f Dockerfile --target tf-python-3.8-gcc -t quay.io/eformat/easybuild-odh-tf-py3.8-gcc:latest
```
