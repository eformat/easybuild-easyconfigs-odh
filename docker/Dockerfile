FROM registry.fedoraproject.org/fedora-minimal:34 as builder
# GCC Toolchain is SYSTEM for eb for now
RUN microdnf install -y make cmake binutils gcc gcc-c++ libstdc++ libstdc++-devel curl git tar xterm perl zlib zlib-devel pkgconf-pkg-config libpng libpng-devel lua Lmod which bzip2 patch diffutils openssl-devel xz libffi-devel \
    && microdnf clean all
RUN mkdir -p /opt/apps/easybuild

# Install EasyBuild
RUN pip install --prefix /opt/apps/easybuild easybuild==4.4.2
# Create configuration file
RUN mkdir -p /opt/apps/easybuild/easybuild.d
# COPY config.cfg /opt/apps/easybuild/easybuild.d/config.cfg
# Create the "featured" category to filter packages
RUN mkdir -p /opt/apps/easybuild/modules/featured

ENV PATH="/opt/apps/easybuild/bin:/usr/share/lmod/lmod/libexec/:${PATH}"
ENV MODULEPATH="/opt/apps/easybuild/modules:${MODULEPATH}"
ENV PYTHONPATH="/opt/apps/easybuild/lib/python3.9/site-packages:${PYTHONPATH}"
ENV XDG_CONFIG_DIRS="/opt/apps/easybuild"

WORKDIR /opt/app-root/src

# Multi-stage-build
FROM builder as tf-python-3.8-gcc
RUN git clone https://github.com/eformat/easybuild-easyconfigs-odh.git
WORKDIR /opt/app-root/src/easybuild-easyconfigs-odh
RUN eb TensorFlow-2.6.0-python3.8.eb -rfTl --search-paths=/opt/app-root/src/easybuild-easyconfigs-odh --installpath=/opt/apps/easybuild --allow-use-as-root-and-accept-consequences
