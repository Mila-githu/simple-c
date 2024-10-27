FROM centos:7

RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-* \
    && sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN ping -c 4 mirrorlist.centos.org
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

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
