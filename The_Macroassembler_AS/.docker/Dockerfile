FROM alpine:latest
RUN apk add --no-cache alpine-sdk git python3 python3-virtualenv python3-pip && \
    cd /opt && \
        git clone https://github.com/0cjs/8bitdev.git && \
    cd 8bitdev && \
        python3 -m venv --prompt 8bitdev ./.venv && \
            . .venv/bin/activate && \
            pip3 install --upgrade pip && \
            pip3 install -r requirements.txt && \
            BUILDDIR=/opt/8bitdev/build python3 ./tool/asl/Setup && \
    echo 'clean up' && \
        rm -rf .venv && \
        apk del alpine-sdk git python3 python3-virtualenv python3-pip && \
    echo 'done'

ENTRYPOINT ["sh"]
