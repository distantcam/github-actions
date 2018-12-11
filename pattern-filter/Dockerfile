FROM alpine:latest

LABEL "name"="pattern-filter"
LABEL "maintainer"="Cameron MacFarland <distantcam@gmail.com>"

LABEL "com.github.actions.name"="Pattern Filter for GitHub Actions"
LABEL "com.github.actions.description"="A generic pattern filter"
LABEL "com.github.actions.icon"="filter"
LABEL "com.github.actions.color"="gray-dark"

RUN	apk add --no-cache \
    bash \
    jq

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]