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
    - [POSIX commands](#posix-commands)
    - [csvkit](#csvkit)
    - [csv-diff](#csv-diff)
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

### POSIX commands

| Name | Description |
|------|-------------|
| `comm` | Select the lines common to two sorted files or the lines contained in only one of them.  (Manual: `man 1 comm` on your system, [GNU](https://linux.die.net/man/1/comm), [FreeBSD](https://www.freebsd.org/cgi/man.cgi?query=comm&sektion=1).) |
| `cut` | Select portions of each line in one or more files.  (Manual: `man 1 cut`, [GNU](https://linux.die.net/man/1/cut), [FreeBSD](https://www.freebsd.org/cgi/man.cgi?query=cut&sektion=1).) |
| `grep` | Select the lines that match or do not match a pattern from one or more files.  (Manual: `man 1 grep`, [GNU](https://linux.die.net/man/1/grep), [FreeBSD](https://www.freebsd.org/cgi/man.cgi?query=grep&sektion=1).) |
| `join` | Take two files sorted by a common field and join their lines on the value of that field.  Lines with values that do not appear in the other file are discarded.  (Manual: `man 1 join`, [GNU](https://linux.die.net/man/1/join), [FreeBSD](https://www.freebsd.org/cgi/man.cgi?query=join&sektion=1).) |
| `paste` | Combine several consecutive lines in a text file into one.  (Manual: `man 1 paste`, [GNU](https://linux.die.net/man/1/paste), [FreeBSD](https://www.freebsd.org/cgi/man.cgi?query=paste&sektion=1).) |
| `sort` | Sort lines by key fields.  (Manual: `man 1 sort`, [GNU](https://linux.die.net/man/1/sort), [FreeBSD](https://www.freebsd.org/cgi/man.cgi?query=sort&sektion=1).) |
| `uniq` | Find or remove repeated lines.  (Manual: `man 1 uniq`, [GNU](https://linux.die.net/man/1/uniq), [FreeBSD](https://www.freebsd.org/cgi/man.cgi?query=uniq&sektion=1).) |

> Documentation source: [dbohdan/structured-text-tools](https://github.com/dbohdan/structured-text-tools)

Other commands installed

- `bash` (as 2021-11-09: _GNU bash, version 5.1.4(1)-release (x86_64-pc-linux-gnu)_)
- `diff` (as 2021-11-09: _diff (GNU diffutils) 3.7_)
- `git` (as 2021-11-09: _git version 2.30.2_)
- `sed` (as 2021-11-09: _sed (GNU sed) 4.7_)
- `unzip` (as 2021-11-09: _UnZip 6.00 of 20 April 2009, by Debian. Original by Info-ZIP._)
- `tar` (as 2021-11-09: _tar (GNU tar) 1.34_)
- `xz` (as 2021-11-09: _xz (XZ Utils) 5.2.5_)

### csvkit
- <https://csvkit.readthedocs.io>

### csv-diff
- <https://github.com/simonw/csv-diff>

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