#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
#GitHub actions require that the docker image use the root user
#https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user

FROM alpine:3.23.3

RUN apk --no-cache add build-base=0.5-r3 \
                       cmake=4.1.3-r0 \
                       gcovr=8.4-r0 \
                       uuidgen=2.41.2-r0 \
                       bash=5.3.3-r1 \
                       valgrind=3.25.1-r2 \
                       git=2.52.0-r0 \
                       curl=8.17.0-r1 \
                       zip=3.0-r13 \
                       unzip=6.0-r16 \
                       samurai=1.2-r7 \
                       pkgconf=2.5.1-r0

ENV VCPKG_FORCE_SYSTEM_BINARIES=1 \
    VCPKG_ROOT=/vcpkg

RUN git clone https://github.com/microsoft/vcpkg /vcpkg && \
    git -C /vcpkg checkout b322364f06308bdd24823f9d8f03fe0cc86fd46f && \
    /vcpkg/bootstrap-vcpkg.sh -disableMetrics && \
    /vcpkg/vcpkg install "gtest:x64-linux" --no-print-usage

RUN mkdir /workdir

COPY entrypoint.sh /entrypoint.sh
COPY CMakeLists.txt /CMakeLists.txt
COPY vcpkg.json /vcpkg.json

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK CMD exit 0
