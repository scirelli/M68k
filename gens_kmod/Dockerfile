FROM i386/alpine:latest
MAINTAINER Steve Cirelli "steve@cirelli.org"

ARG DISPLAY=docker.for.mac.host.internal:0
ARG REMOVEABLE_INSTALLS=unzip

ENV DISPLAY=$DISPLAY

COPY ./resources/* /opt/

RUN apk add --no-cache wine freetype ncurses libx11 xpra xorg-server-xephyr xinit xauth xclip xhost xrandr xdpyinfo $REMOVEABLE_INSTALLS && \
    cd /opt && \
    unzip gens_kmod.zip && \
    echo alias ll=\'ls -lah\' >> /etc/profile.d/aliases.sh && \
    mkdir -p /root/project && \
    echo 'clean up' && \
        cd /tmp && \
        rm -rf /opt/*.zip && \
        apk del $INSTALL_PACKAGES && \
    wine --version && \
    wine /opt/gens_kmod/gens.exe || echo 'done'

WORKDIR "/root/project"

ENTRYPOINT ["wine", "/opt/gens_kmod/gens.exe"]


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
