#!/bin/sh

# Build the template within a docker container

CMD=${*-clean all}

docker run --rm --interactive \
    --user="$(id --user):$(id --group)" \
    --net=none \
    --volume="$PWD":/home/workdir \
    --workdir="/home/workdir" \
    -e HOME="/home" \
raabf/latex-versions:texlive2019 /usr/bin/make $CMD
