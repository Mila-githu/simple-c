# Start from CentOS 7 base image
FROM centos:7

RUN sed -i 's|^mirrorlist=|#mirrorlist=|g; s|^#baseurl=http|baseurl=http|g' /etc/yum.repos.d/CentOS-Base.repo

# Install EPEL repository
RUN yum install -y epel-release && yum update -y

# Install tools for building RPMs
RUN yum install -y yum-utils && \
    yum-config-manager --setopt=base.skip_if_unavailable=true --save && \
    yum install -y rpm-build rpmdevtools gcc make coreutils python git


# Set up RPM build directory structure
RUN rpmdev-setuptree

# Set working directory for rpmbuild
WORKDIR /root/rpmbuild

# Keep container running with Bash
ENTRYPOINT ["/bin/bash"]

