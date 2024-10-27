# Start from CentOS 7 base image
FROM centos:7

# Update repository links to vault.centos.org for archived CentOS 7
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-* \
    && sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

ARG DNS_SERVER
RUN echo "nameserver $DNS_SERVER" > /etc/resolv.conf
# Install EPEL repository
RUN yum install -y epel-release && yum update -y

# Install tools for building RPMs
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

# Set working directory for rpmbuild
WORKDIR /root/rpmbuild

# Keep container running with Bash
ENTRYPOINT ["/bin/bash"]

