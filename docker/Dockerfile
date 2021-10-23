FROM registry.fedoraproject.org/fedora-minimal:34 as builder
# GCC Toolchain is SYSTEM for eb for now
RUN microdnf install -y make cmake binutils gcc gcc-c++ libstdc++ libstdc++-devel curl git tar xterm perl zlib zlib-devel pkgconf-pkg-config libpng libpng-devel lua Lmod which bzip2 patch diffutils openssl-devel xz libffi-devel vi bzip2-devel \
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

# an annoying patch for easybuild untar cmds for deps in containers
COPY eb-patch /tmp/eb-patch
RUN (cd / && patch -p0) < /tmp/eb-patch

# setup lmod
COPY lmod-env.sh /tmp/lmod-env.sh
RUN bash -c '/tmp/lmod-env.sh'

#
# Multi-stage-builds
#

# Copy in our ODH configs
FROM builder as odh-builder
RUN git clone https://github.com/eformat/easybuild-easyconfigs-odh.git
WORKDIR /opt/app-root/src/easybuild-easyconfigs-odh

# Python
FROM odh-builder as python-3.8-gcc
RUN eb Python-3.8.12.eb -rfTl --search-paths=/opt/app-root/src/easybuild-easyconfigs-odh --installpath=/opt/apps/easybuild --allow-use-as-root-and-accept-consequences
RUN mkdir -p /opt/apps/easybuild/modules/featured/Python
RUN cp /opt/apps/easybuild/modules/all/Python/3.8.12.lua /opt/apps/easybuild/modules/featured/Python/

# Tensorflow
FROM python-3.8-gcc as tf-python-3.8-gcc
RUN eb TensorFlow-2.6.0-python3.8.eb -rfTl --search-paths=/opt/app-root/src/easybuild-easyconfigs-odh --installpath=/opt/apps/easybuild --allow-use-as-root-and-accept-consequences
RUN mkdir -p /opt/apps/easybuild/modules/featured/TensorFlow
RUN cp /opt/apps/easybuild/modules/all/TensorFlow/2.6.0.lua /opt/apps/easybuild/modules/featured/TensorFlow
