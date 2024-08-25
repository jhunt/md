md
==

A small and fast shell utility for converting Markdown into HTML.

Usage is straightforward:

    $ md <README.md >README.html

but can get as complex as the pipeline you want to slot it into:

    $ find . -name '*.md' -exec sh -c \
        'md <$1 >${1%%.md}.html' sh \{} \;

Building
--------

`md` is written in OCaml, and uses dune:

    dune build
    cp _build/default/md.exe ~/bin
