ARG DISTRO
ARG DISTRO_VER
FROM ${DISTRO}:${DISTRO_VER}

RUN dnf update -y \
 && dnf install -y \
    rpm-build \
    rpm-devel \
    rpmlint \
    rpmdevtools \
    diffutils \
    patch \
    gcc \
    make \
    gpg* \
    rng-tools \
    wget \
    curl \
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
ENV PICK_VERSION_SPEC_FILE_FROM_HOME "rpmbuild/SPECS/${PICK_VERSION_SPEC_FILE}"

RUN rpmdev-setuptree

# Download source
RUN cd rpmbuild/SOURCES/ \
 && wget "https://github.com/mptre/pick/archive/${PICK_VERSION_TARBALL}"

# This chown isn't working in podman for some reason. Manually running chown until it is fixed
COPY --chown=rpmbuild:rpmbuild pick.spec.tmpl /home/rpmbuild/
USER root
RUN chown rpmbuild:rpmbuild /home/rpmbuild/pick.spec.tmpl

USER rpmbuild
RUN echo "Spec file is ${PICK_VERSION_SPEC_FILE}" \
 && cp pick.spec.tmpl "$PICK_VERSION_SPEC_FILE_FROM_HOME" \
 && sed -i -e "s/PICK_VERSION_TARBALL/$PICK_VERSION_TARBALL/g" "$PICK_VERSION_SPEC_FILE_FROM_HOME" \
 && sed -i -e "s/PICK_VERSION/$PICK_VERSION/g" "$PICK_VERSION_SPEC_FILE_FROM_HOME"

RUN rpmbuild -ba ${PICK_VERSION_SPEC_FILE_FROM_HOME}
RUN rpmbuild -bs ${PICK_VERSION_SPEC_FILE_FROM_HOME}

# Copy RPM files to home dir for easy extraction
RUN mkdir -p /home/rpmbuild/rpms \
 && mv rpmbuild/RPMS/*/pick*.rpm rpmbuild/SRPMS/pick*.rpm /home/rpmbuild/rpms/
