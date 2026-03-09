#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
#GitHub actions require that the docker image use the root user
#https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user

FROM alpine:3.23.3

RUN apk --no-cache add build-base=0.5-r3 \
                       cmake=4.1.3-r0 \
                       gtest=1.17.0-r0 \
                       gtest-dev=1.17.0-r0 \
                       gcovr=8.4-r0 \
                       uuidgen=2.41.2-r0 \
                       bash=5.3.3-r1 \
                       valgrind=3.25.1-r2
RUN mkdir /workdir

COPY entrypoint.sh /entrypoint.sh
COPY CMakeLists.txt /CMakeLists.txt

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK CMD exit 0
