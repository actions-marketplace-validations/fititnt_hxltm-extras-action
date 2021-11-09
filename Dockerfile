# SPDX-License-Identifier: Unlicense OR 0BSD

# FROM python:3.9-alpine
FROM python:3.9-bullseye

# https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions
# It's recommended to use Docker images based on the Debian operating system.

# RUN pip install libhxl

# RUN pip install hdp-toolchain[hxltm]

# https://github.com/wireservice/csvkit
RUN pip install csvkit

# https://github.com/translate/translate
RUN pip install translate-toolkit[all]


# https://github.com/johnkerl/miller

# docker run --rm -it $(docker build -q -f Dockerfile-extras .) 'csv2po --help'

# TODO: https://stackoverflow.com/questions/43654656/dockerfile-if-else-condition-with-external-arguments

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]