Documents are typeset with LaTeX.

## Installing LaTeX
Below commands are for arch-based or debian-based systems. If you want to install
LaTeX on Windows or Mac, figure it out yourself.

```
# arch-based systems
sudo pacman -S texlive-most texlive-lang

# debian-based systems (e.g. ubuntu)
sudo apt-get install texlive-full
```

## Compile LaTeX

Open a terminal and navigate to the directory holding the LaTeX source file.
When using references in a LaTeX document, it is sometimes necessary to compile
multiple times. Specifically, it is necessary to compile the references used in
the `.bib` file.

```
# first compile
pdflatex mytexdocument.tex

# compile references
bibtex mytexdocument

# compile again
pdflatex mytexdocument.tex
```

