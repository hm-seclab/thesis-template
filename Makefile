.PHONY: FORCE_MAKE
MAKEFILEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
MARKDOWNS = $(patsubst %.md,%.md.tex,$(wildcard **/*.md))

all: $(MARKDOWNS) main.pdf

## Additional build options
# Uncomment for a speed up with standalone tikz-pictures (but a less secure build)
#SHELLESCAPE = "-shell-escape"

%.pdf: %.tex FORCE_MAKE
	@ latexmk -cd -use-make -pdf $(LIVEPREVIEW) \
	  -pdflatex="texfot pdflatex $(SHELLESCAPE) -synctex=1 -interaction=nonstopmode" \
	  $<

# Add rule for glossaries
%.gls: %.tex
	@ makeglossaries $*

# Ensure makeglossaries runs in the latexmk cycle
%.pdf: %.gls

LIVEPREVIEW := $(if $(filter live,$(MAKECMDGOALS)),-pvc,)
live: main.pdf

# For external analyses and reviews having other formats of thesis might become handy
%.docx: %.tex
	@ pandoc --standalone $< --output=$@
%.plain: %.tex
	@ pandoc --standalone $< --to=plain --output=$@
docx: main.docx
plain: main.plain

# Option to write in markdown
%.md.tex: %.md
	@ pandoc --top-level-division=chapter --listings --biblatex --biblio="$(MAKEFILEDIR)literature.bib" -o $@ $<

indent:
	@ find . -name "*.tex" -type f -exec latexindent --silent --local="$(MAKEFILEDIR)/zyx/indentconfig.yaml" {} --outputfile={} \;
.PHONY: indent

help:
	@ echo "Please chose one of the following make targets"
	@ echo "  all      : use LaTeX to build the main.pdf (default)"
	@ echo "  indent   : Prettifies your latex code (better make a commit/backup first)"
	@ echo "  plain    : Extracts all plain text from thesis (useful for external tools, e.g. language checks)"
	@ echo "  live     : Automatically rebuild the main document on any change in the source code"
	@ echo "  clean    : remove all files that are ignored by git"
	@ echo "  submit   : build an archive for submission of the thesis"
.PHONY: help

clean:
	@ git clean -X --force --quiet
.PHONY: clean

submit: all
	@ git archive --format=zip -9 HEAD -o thesis.zip
	@ zip -qu thesis.zip main.pdf
	@ echo " => thesis.zip was successfully created"
.PHONY: submit

.gitignore: FORCE_MAKE
	@ echo "## Manual rules" > $@
	@ echo "thesis.zip" >> $@
	@ echo "# Generated files from pandoc" >> $@
	@ echo "*.plain" >> $@
	@ echo "*.md.tex" >> $@
	@ echo "" >> $@
	@ wget --random-wait -qO- >> $@ \
		https://raw.githubusercontent.com/github/gitignore/master/TeX.gitignore \
		https://raw.githubusercontent.com/github/gitignore/master/Global/MicrosoftOffice.gitignore
	@ sed -i -e "s/^# \*.\(pdf\|eps\|ps\)$$/*.\1/" $@
