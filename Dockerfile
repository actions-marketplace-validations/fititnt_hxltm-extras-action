# ==============================================================================
#
#          FILE:  Dockerfile
#
#         USAGE:  This Dockerfile is used as part of GitHub Action. Any
#                 command here is just for internal debugging.
#                 Quick test:
#                   docker run --rm -it $(docker build -q .) 'find /usr/local/bin/ -executable -type f'
#                   docker run --rm -it $(docker build -q .) 'awk --help'
#                 Docker, quick build
#                   docker build .
#                 Docker, disk usage
#                   docker system df -v
#                 Docker, Remove unused data
#                   docker system prune
#
#   DESCRIPTION:  ---
#
#       OPTIONS:  ---
#
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  - https://docs.github.com/en/actions/creating-actions
#                   /dockerfile-support-for-github-actions
#                   - It's recommended to use Docker images based on the
#                     Debian operating system when Alpine is not viable.
#                 - Know commands which cannot run on Alpine:
#                   - RUN pip install rows[all]
#                      - Okay pip install rows[cli], ~12MB
#                   - RUN pip install translate-toolkit[all]
#                   - RUN pip install csvkit
#       AUTHORS:  Emerson Rocha <rocha[at]ieee.org>
# COLLABORATORS:  <@TODO: put additional non-anonymous names here>
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain dedication OR Zero-Clause BSD
#                 SPDX-License-Identifier: Unlicense OR 0BSD
#       VERSION:  v1.1
#       CREATED:  2021-11-04 11:27 UTC started (on hxltm-action)
#       CREATED:  2021-11-09 13:59 UTC v1.1 hxltm-extras-action fork
# ==============================================================================

# FROM python:3.9-alpine
FROM python:3.9-bullseye

# Trivia:
# FROM python:3.9-bullseye -> ~ 45.1MB
# FROM python:3.9-bullseye -> ~ 912MB

### SKIP: already installed with hxltm-action
## Extra size over python:3.9-alpine = ~ 15.34MB
# RUN pip install libhxl

### SKIP: already installed with hxltm-action
## Extra size over python:3.9-alpine + libhxl = ~ 14.97MB
## Extra size over python:3.9-alpine = ~29.97MB
## Installed with hxltm-action
# RUN pip install hdp-toolchain[hxltm]

### @see https://github.com/simonw/csv-diff
## Extra size over python:3.9-alpine = ~6.827MB
RUN pip install csv-diff

#### https://github.com/turicas/rows
## Extra size over python:3.9-alpine = ~12MB
RUN pip install rows[cli]
# RUN pip install rows[all]
# TODO: the documented 'rows csv-merge' is not exposed neither
#       via pip install rows[cli] or pip install rows[all]

### https://github.com/wireservice/csvkit
## Extra size over python:3.9-bullseye =  ~38MB
RUN pip install csvkit

### @see https://github.com/translate/translate
## Extra size over python:3.9-bullseye =  ~147.1MB
RUN pip install translate-toolkit[all]

# ### @see https://github.com/johnkerl/miller
# ## Extra size over python:3.9-bullseye + csvkit + translate-toolkit[all] =  ~140MB
RUN apt-get update && apt-get install miller
# RUN apt install miller

# https://github.com/BurntSushi/xsv
# xsv would require install cargo; skiping for now

# @see https://github.com/dbohdan/structured-text-tools#csv

# CSV Diffs
#  - https://github.com/simonw/csv-diff
#  - https://github.com/aswinkarthik/csvdiff


# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]