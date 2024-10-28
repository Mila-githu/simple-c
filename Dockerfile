FROM rockylinux:8

# Ensure all mirrors use base URLs instead of mirror lists
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g; s|^#baseurl=http|baseurl=http|g' /etc/yum.repos.d/*.repo

# Set DNS to avoid connectivity issues
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# Install EPEL repository
RUN yum install -y epel-release && yum update -y

# Install tools for building RPMs
RUN yum install -y yum-utils rpm-build rpmdevtools gcc make coreutils python3 git

# Configure yum to skip unavailable packages for additional reliability
RUN yum-config-manager --setopt=base.skip_if_unavailable=true --save

# Set up RPM build directory structure
RUN rpmdev-setuptree

# Set working directory for rpmbuild
WORKDIR /root/rpmbuild

# Keep container running with Bash
ENTRYPOINT ["/bin/bash"]

