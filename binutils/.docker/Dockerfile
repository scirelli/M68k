FROM alpine:latest
MAINTAINER Steve Cirelli "steve@cirelli.org"

ARG BINUTILS_BASE=binutils-2.16.1
ARG BINUTILS=${BINUTILS_BASE}a.tar.bz2
ARG BINUTILS_TAR_FLAGS=xvfj
ARG GCC_BASE=gcc-3.4.3
ARG GCC=${GCC_BASE}.tar.bz2
ARG GCC_TAR_FLAGS=xvfj

ENV INSTALL_PACKAGES='alpine-sdk git wget'

RUN apk add --no-cache $INSTALL_PACKAGES && \
    cd /tmp && \
        wget https://ftp.gnu.org/gnu/binutils/$BINUTILS && \
        tar $BINUTILS_TAR_FLAGS $BINUTILS && \
    cd $BINUTILS_BASE && \
        export CROSSDIRECTORY=/opt/m68k && \
        CFLAGS=-Wno-error ./configure --prefix=$CROSSDIRECTORY --target=m68k-coff --enable-obsolete && \
        make && make install && \
    cd /tmp && \
        wget https://ftp.gnu.org/gnu/gcc/$GCC_BASE/$GCC && \
        tar $GCC_TAR_FLAGS $GCC && \
    cd $GCC_BASE && \
        ./configure --prefix=$CROSSDIRECTORY --target=m68k-coff --enable-languages=c && \
        PATH=$PATH:$CROSSDIRECTORY/bin make && \
        PATH=$PATH:$CROSSDIRECTORY/bin make install && \
    cat 'export PATH=$PATH:/opt/m68k/bin' >> /etc/profile && \
    echo 'clean up' && \
        cd /tmp && \
        rm -rf /tmp/binutils-gdb && \
        rm -rf /tmp/gcc && \
        apk del $INSTALL_PACKAGES && \
    echo 'done'

ENTRYPOINT ["m68k-coff-gcc"]