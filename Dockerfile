FROM centos:7

# Update repositories to use vault.centos.org
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install EPEL repository
RUN yum install -y epel-release

# Installing tools needed for rpmbuild
RUN yum install -y \
    rpm-build \
    rpmdevtools \
    gcc \
    make \
    coreutils \
    python \
    git \
    && yum clean all

# Set up RPM build directory structure
RUN rpmdev-setuptree

# Set working directory
WORKDIR /root/rpmbuild

# Keep container running
ENTRYPOINT ["/bin/bash"]
