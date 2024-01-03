FROM alpine:3.16.2

RUN apk --no-cache add build-base \
                       cmake \
                       gtest \
                       gtest-dev \
                       gcovr \
                       uuidgen \
                       bash \
                       valgrind
RUN mkdir /workdir

COPY entrypoint.sh /entrypoint.sh
COPY CMakeLists.txt /CMakeLists.txt

ENTRYPOINT ["/entrypoint.sh"]
