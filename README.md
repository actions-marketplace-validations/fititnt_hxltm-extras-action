# hxltm-extras-action
**[non-production-ready] Ad hoc GitHub Actions for non-HXL / non-HXLTM cli tools. See https://github.com/fititnt/hxltm-action/issues/6**

---

**Table of Contents**

<!-- TOC depthFrom:2 -->

- [Documentation](#documentation)
    - [Baseline inputs](#baseline-inputs)
        - [`bin`](#bin)
        - [`args`](#args)
        - [`infile`](#infile)
        - [`outfile`](#outfile)
    - [Environment variables](#environment-variables)
        - [Reusable defaults](#reusable-defaults)
    - [Syntactic sugar inputs](#syntactic-sugar-inputs)
        - [`syntactic-sugar-not-implemented`](#syntactic-sugar-not-implemented)
- [hxltm-extras-action tools](#hxltm-extras-action-tools)
    - [csvkit](#csvkit)
    - [miller](#miller)
    - [rows](#rows)
    - [translate-toolkit](#translate-toolkit)
- [License](#license)

<!-- /TOC -->

---

<!--
- https://github.com/nektos/act
- https://github.com/actions/hello-world-docker-action
- https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action
- https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

cp -r /workspace/git/fititnt/hxltm-extras-action /home/fititnt/Downloads/hxltm-extras-action-backup

rsync -r -a -v /workspace/git/fititnt/hxltm-extras-action/ /home/fititnt/Downloads/hxltm-extras-action
cd /home/fititnt/Downloads/hxltm-extras-action
docker run --rm -it $(docker build -q .)

docker run --rm -it $(docker build -q .) 'compgen -c'  # nao disponivel
docker run --rm -it $(docker build -q .) 'which csvstat'
docker run --rm -it $(docker build -q .) 'which csv2po'
docker run --rm -it $(docker build -q .) 'ls /usr/local/bin/'
docker run --rm -it $(docker build -q .) 'find /usr/local/bin/ -executable -type f'
docker run --rm -it $(docker build -q -f Dockerfile-extras .) 'hxltmcli --help'

> Delete old images
docker rmi $(docker images -f "dangling=true" -q)

cp .github/hxltm/hxltm-exemplum-linguam.tm.hxl.csv hxltm-exemplum-linguam.tm.hxl.csv

docker run --rm -it $(docker build -q .) 'hxltmcli' 'tests/hxltm-exemplum-linguam.tm.hxl.csv' 'objectivum.tbx' '--objectivum-TBX-Basim'

- # Using act
act
act --privileged

-#
-# Issues
-#  - https://github.com/nektos/act/issues/555
-#    - https://github.com/nektos/act/issues/410#issuecomment-732096442
-->

## Documentation

This documentation explains the [action.yml](action.yml) and
[entrypoint.sh](entrypoint.sh).

### Baseline inputs

Baseline inputs, together with [Environment variables](#environment-variables),
are enough to abstract how to use the underlying command line tools.

#### `bin`
**Required** The executable to run.

> _Parameter examples_:
> - `csvstat`
> - `hxltmdexml` _(or `.github/hxltm/hxltmdexml.py`)_ (*)

#### `args`
Arguments passed for the program defined by [bin](#bin) parameter.
Default: undefined.

> _Parameter examples_:
> - `--help`
> - `-v`
> - `--sheet 7` (_Select sheet from a Excel workbook (1 is first sheet)_)

#### `infile`
The input file for the program defined by [bin](#bin) parameter
<sup>[Note on non use of pipelines](#note-on-non-use-of-pipelines)</sup>.
Default: undefined.

> _Parameter examples_:
> - `fontem.hxl.csv`
> - `fontem.tbx`

#### `outfile`
The output file for the program defined by [bin](#bin) parameter
<sup>[Note on non use of pipelines](#note-on-non-use-of-pipelines)</sup>.
Default: undefined.

> _Parameter examples_:
> - `objectivum.tbx`
> - `objecricum.hxl.csv`

### Environment variables
- See <https://docs.github.com/en/actions/learn-github-actions/environment-variables>.

#### Reusable defaults
The way GitHub Actions steps works, environment variables can be both passed
at the entire job level or at specific tasks. One implication of
[action.yml](action.yml) and [entrypoint.sh](entrypoint.sh) is that the use of
environment variables at job level can be used to create default values for
potentially repetitive values for each individual task.

> _TODO: test this potential implication and document it._

### Syntactic sugar inputs
This section shows some [syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar)
(or intentional _syntactic saccharins_) for what could be done using other ways,
often with [args](#args) parameter. Some of these only use English for what
hxltm cli tools use Latin.

#### `syntactic-sugar-not-implemented`

None implemented on the current version. Use [Baseline inputs](#baseline-inputs)
and [Environment variables](#environment-variables).

## hxltm-extras-action tools

### csvkit
- <https://csvkit.readthedocs.io>

### miller
- <https://miller.readthedocs.io>

### rows
- <http://turicas.info/rows/>

### translate-toolkit
- <http://docs.translatehouse.org/projects/translate-toolkit/en/latest/commands/index.html>

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
and [non anonymous collaborators](https://github.com/fititnt/hxltm-extras-action/graphs/contributors)
have waived all copyright and related or neighboring rights to this work to
[Public Domain](UNLICENSE).

Optionally, the [BSD Zero Clause License](https://spdx.org/licenses/0BSD.html)
is also one explicit alternative to the Unlicense as an older license approved
by the OSI:

`SPDX-License-Identifier: Unlicense OR 0BSD`