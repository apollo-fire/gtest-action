FROM alpine:3.16.2

RUN apk --no-cache add build-base=0.5-r3 \
                       cmake=3.28.1-r0 \
                       gtest=1.11.0_git20220205-r1 \
                       gtest-dev=1.11.0_git20220205-r1 \
                       gcovr=5.2-r0 \
                       uuidgen=2.38-r1 \
                       bash=5.1.16-r2 \
                       valgrind=3.19.0-r0
RUN mkdir /workdir

COPY entrypoint.sh /entrypoint.sh
COPY CMakeLists.txt /CMakeLists.txt

ENTRYPOINT ["/entrypoint.sh"]
