FROM alpine:latest
MAINTAINER Steve Cirelli "steve@cirelli.org"

RUN apk add --no-cache alpine-sdk git python3 && \
    cd /opt && \
        git clone https://github.com/scirelli/8bitdev.git && \
    cd 8bitdev && \
        python3 -m venv --prompt 8bitdev ./.venv && \
            ./.venv/bin/python3 -m pip install --upgrade pip && \
            ./.venv/bin/pip install -r requirements.txt && \
            BUILDDIR=/opt/8bitdev/build ./.venv/bin/python3 ./tool/asl/Setup && \
            ln -s /opt/8bitdev/build/tool/bin/asl /usr/local/bin/asl && \
    echo 'clean up' && \
        rm -rf .venv .git && \
        apk del alpine-sdk git python3 && \
    echo 'done'

ENTRYPOINT ["asl", "-cpu", "68000"]
