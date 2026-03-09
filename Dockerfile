#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
#GitHub actions require that the docker image use the root user
#https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user

FROM alpine:3.16.2

RUN apk --no-cache add build-base=0.5-r3 \
                       cmake=3.23.5-r0 \
                       gcovr=5.2-r0 \
                       uuidgen=2.38-r1 \
                       bash=5.1.16-r2 \
                       valgrind=3.19.0-r0
# hadolint ignore=DL3018
RUN apk --no-cache add git curl zip unzip

RUN git clone --depth 1 --branch 2024.12.16 https://github.com/microsoft/vcpkg /vcpkg && \
    /vcpkg/bootstrap-vcpkg.sh -disableMetrics && \
    /vcpkg/vcpkg install "gtest:x64-linux" --no-print-usage

ENV VCPKG_ROOT=/vcpkg

RUN mkdir /workdir

COPY entrypoint.sh /entrypoint.sh
COPY CMakeLists.txt /CMakeLists.txt
COPY vcpkg.json /vcpkg.json

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK CMD exit 0
