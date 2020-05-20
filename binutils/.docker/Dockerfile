FROM alpine:latest
MAINTAINER Steve Cirelli "steve@cirelli.org"

ARG BINUTILS_BASE=binutils-2.16.1
ARG BINUTILS=${BINUTILS_BASE}a.tar.bz2
ARG TAR_FLAGS=xvfj
ARG GCC=gcc-10.1.0.tar.gz

RUN apk add --no-cache alpine-sdk git wget gmp mpfr4 mpc && \
    cd /tmp && \
        wget https://ftp.gnu.org/gnu/binutils/$BINUTILS && \
        tar $TAR_FLAGS $BINUTILS && \
    cd $BINUTILS_BASE && \
        export CROSSDIRECTORY=/opt/m68k && \
        CFLAGS=-Wno-error ./configure --prefix=$CROSSDIRECTORY --target=m68k-coff --enable-obsolete && \
        make && make install && \
    cd /tmp && \
        wget https://ftp.gnu.org/gnu/gcc/gcc-10.1.0/$GCC && \
        tar xvfz $GCC && \
    cd gcc-10.1.0 && \
        ./contrib/download_prerequisites && \
        mkdir /tmp/objdir && \
        cd /tmp/objdir && \
        /tmp/gcc-10.1.0/configure --prefix=$CROSSDIRECTORY --target=m68k-coff --enable-languages=c && \
        PATH=$PATH:$CROSSDIRECTORY/bin make && \
        PATH=$PATH:$CROSSDIRECTORY/bin make install && \
    cat 'export PATH=$PATH:/opt/m68k/bin' >> /etc/profile && \
    echo 'clean up' && \
        cd /tmp && \
        rm -rf /tmp/binutils-gdb && \
        rm -rf /tmp/gcc && \
        apk del alpine-sdk git wget gmp mpfr-dev mpc && \
    echo 'done'

ENTRYPOINT ["m68k-coff-gcc"]
