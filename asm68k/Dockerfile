FROM i386/alpine:latest
MAINTAINER Steve Cirelli "steve@cirelli.org"

COPY ./resources/* /opt/asm68k/

RUN apk add --no-cache wine freetype ncurses && \
    mkdir -p /opt/asm68k/bin && \
    ln -s /opt/asm68k/asm68k.sh /opt/asm68k/bin/asm68k && \
    echo 'export PATH=$PATH:/opt/asm68k/bin' >> /etc/profile && \
    ln -s /opt/asm68k/bin/* /usr/local/bin/ && \
    echo alias ll='ls -lah' >> /etc/profile.d/aliases.sh && \
    wine --version && \
    wine /opt/asm68k/asm68k.exe || echo 'done'

WORKDIR "/tmp"

ENTRYPOINT ["wine", "/opt/asm68k/asm68k.exe"]


# org-server 
# ARG USER=m68k
#     addgroup -S $USER && \
#     adduser \
#         --disabled-password \
#         --ingroup "$USER" \
#         --no-create-home \
#         --disabled-password \
#         --gecos "" \
#         -S "$USER"

# USER $USER
