#!/usr/bin/env bash

tempdir=$(mktemp -d) || exit 1

cat <<DOCKERFILE | docker build $tempdir -t jq -f - &> /dev/null
FROM ubuntu

RUN apt-get update && apt-get install -y jq

ENTRYPOINT [ "jq" ]
DOCKERFILE

docker run \
  -u $(id -u):$(id -g) \
  -v $(pwd):$(pwd) \
  --workdir $(pwd) --rm -i \
  jq:latest \
  "$@"
