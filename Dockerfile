ARG DISTRO
ARG DISTRO_VER
FROM ${DISTRO}:${DISTRO_VER}

RUN dnf update -y \
 && dnf install -y \
    rpm-build \
    rpm-devel \
    rpmlint \
    rpmdevtools \
    coreutils \
    diffutils \
    patch \
    gcc \
    make \
    gpg* \
    rng-tools \
    wget \
    curl
 #&& dnf clean all
RUN dnf update -y \
 && dnf install -y \
    ncurses-devel

RUN groupadd --gid 1000 rpmbuild \
 && useradd --uid 1000 --gid 1000 rpmbuild \
 && usermod -L rpmbuild

USER rpmbuild
WORKDIR /home/rpmbuild

ARG PICK_VERSION
ARG PICK_VERSION_TARBALL
ARG PICK_VERSION_SPEC_FILE

ENV PICK_VERSION ${PICK_VERSION}
ENV PICK_VERSION_TARBALL ${PICK_VERSION_TARBALL}
ENV PICK_VERSION_SPEC_FILE ${PICK_VERSION_SPEC_FILE}

RUN rpmdev-setuptree

# Download source
RUN cd rpmbuild/SOURCES/ \
 && wget "https://github.com/mptre/pick/archive/${PICK_VERSION_TARBALL}"

COPY pick.spec.tmpl template-to-spec.sh /home/rpmbuild/
RUN /home/rpmbuild/template-to-spec.sh

RUN rpmbuild -ba rpmbuild/SPECS/${PICK_VERSION_SPEC_FILE}
RUN rpmbuild -bs rpmbuild/SPECS/${PICK_VERSION_SPEC_FILE}

# Copy RPM files to home dir for easy extraction
RUN mkdir -p /home/rpmbuild/rpms \
 && mv rpmbuild/RPMS/x86_64/pick*.rpm rpmbuild/SRPMS/pick*.rpm /home/rpmbuild/rpms/
