# Use Rocky Linux 9 as base image
FROM rockylinux/rockylinux:9

# Enable PowerTools repository (needed for some development tools)
RUN dnf install -y 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled crb

# Install required packages for RPM building
RUN dnf update -y && \
    dnf install -y \
    rpm-build \
    rpmdevtools \
    gcc \
    make \
    coreutils \
    python3 \
    git \
    && dnf clean all

# Set up RPM build directory structure
RUN rpmdev-setuptree

# Set working directory
WORKDIR /root/rpmbuild

# Keep container running
ENTRYPOINT ["/bin/bash"]
