FROM fedora:latest

RUN dnf install -y rpmdevtools rpmlint git \
    && mkdir -p /rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} \
    && dnf clean all


# Set up the RPM build environment
RUN rpmdev-setuptree

WORKDIR /rpmbuild

ENTRYPOINT ["bash"]

