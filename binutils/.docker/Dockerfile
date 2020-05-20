FROM alpine:latest
MAINTAINER Steve Cirelli "steve@cirelli.org"

RUN apk add --no-cache alpine-sdk git wget && \
    cd /tmp && \
        git clone --depth=1 https://sourceware.org/git/binutils-gdb.git && \
    cd binutils-gdb && \
        export CROSSDIRECTORY=/opt/m68k && \
        ./configure --prefix=$CROSSDIRECTORY --target=m68k-coff && \
        make && make install && \
    cd /tmp && \
        git clone --depth=1 https://gcc.gnu.org/git/gcc.git && \
    cd gcc && \
        configure --prefix=$CROSSDIRECTORY --target=m68k-coff --enable-languages=c && \
        PATH=$PATH:$CROSSDIRECTORY/bin make && \
        PATH=$PATH:$CROSSDIRECTORY/bin make install && \
    cat 'export PATH=$PATH:/opt/m68k/bin' >> /etc/profile && \
    echo 'clean up' && \
        cd /tmp && \
        rm -rf /tmp/binutils-gdb && \
        rm -rf /tmp/gcc && \
        apk del alpine-sdk git wget && \
    echo 'done'

ENTRYPOINT ["m68k-coff-gcc"]
