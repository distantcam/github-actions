FROM alpine:latest

LABEL maintainer="Cameron MacFarland <distantcam@gmail.com>"

LABEL com.github.actions.name="Delete PR Branch"
LABEL com.github.actions.description="Delete the PR Branch"
LABEL com.github.actions.icon="activity"
LABEL com.github.actions.color="red"

RUN	apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    jq

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]