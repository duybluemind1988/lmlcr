# (C) 2020 Marek Gagolewski, https://www.gagolewski.com

RMD_SOURCES = \
    01-regression-simple.Rmd                     \
    02-regression-multiple.Rmd                   \
    03-classification-neighbours.Rmd             \
    04-classification-trees_and_logistic.Rmd     \
    05-classification-nnets.Rmd                  \
    06-optimisation-iterative.Rmd                \
    07-clustering.Rmd                            \
    08-optimisation-genetic.Rmd                  \
    09-recommenders.Rmd                          \
    10-postscript.Rmd                            \
    99-references.Rmd


SVG_SOURCES = \
    figures/combination1.svg                     \
    figures/combination2.svg                     \
    figures/combination3.svg                     \
    figures/convex_concave.svg                   \
    figures/convex_function.svg                  \
    figures/convex_set.svg                       \
    figures/cover.svg                            \
    figures/crossover.svg                        \
    figures/neuron.svg                           \
    figures/perceptron.svg


VPATH=.

HTML_OUTDIR=out-html
BEAMER_OUTDIR=out-beamer
BOOKDOWN_GITBOOK_OUTDIR=out-bookdown-gitbook
BOOKDOWN_GITBOOK_TMPDIR=tmp-bookdown-gitbook
BOOKDOWN_LATEX_OUTDIR=out-bookdown-latex
BOOKDOWN_LATEX_TMPDIR=tmp-bookdown-latex

HTML_OUTPUTS=$(patsubst %.Rmd,$(HTML_OUTDIR)/%.html,$(RMD_SOURCES))
BEAMER_OUTPUTS=$(patsubst %.Rmd,$(BEAMER_OUTDIR)/%.pdf,$(RMD_SOURCES))
BOOKDOWN_GITBOOK_OUTPUTS=$(patsubst %.Rmd,$(BOOKDOWN_GITBOOK_TMPDIR)/%.Rmd,$(RMD_SOURCES))
BOOKDOWN_LATEX_OUTPUTS=$(patsubst %.Rmd,$(BOOKDOWN_LATEX_TMPDIR)/%.Rmd,$(RMD_SOURCES))

PDF_OUTPUTS=$(patsubst %.svg,%.pdf,$(SVG_SOURCES))
PNG_OUTPUTS=$(patsubst %.svg,%.png,$(SVG_SOURCES))


.PHONY: all clean purge html beamer bookdown-gitbook bookdown-latex figures

all: please_specify_build_target_manually

html: $(HTML_OUTPUTS)

beamer: $(BEAMER_OUTPUTS)

bookdown-gitbook: out-bookdown-gitbook/index.html

bookdown-latex: out-bookdown-latex/lmlcr.pdf



figures: $(PDF_OUTPUTS) $(PNG_OUTPUTS)

clean:
	rm -f -r tmp-bookdown-gitbook/*.Rmd tmp-bookdown-latex/*.Rmd \
	         out-beamer out-bookdown-gitbook out-bookdown-latex out-html
purge:
	rm -f -r tmp-beamer tmp-bookdown-gitbook tmp-bookdown-latex tmp-html \
	         out-beamer out-bookdown-gitbook out-bookdown-latex out-html

out-bookdown-latex/lmlcr.pdf: $(BOOKDOWN_LATEX_OUTPUTS)
	build-bookdown-latex/render.sh

out-bookdown-gitbook/index.html: $(BOOKDOWN_GITBOOK_OUTPUTS)
	build-bookdown-gitbook/render.sh

$(BEAMER_OUTDIR)/%.pdf: %.Rmd
	build-beamer/compile.sh "$<"

$(HTML_OUTDIR)/%.html: %.Rmd
	build-html/compile.sh "$<"

$(BOOKDOWN_GITBOOK_TMPDIR)/%.Rmd: %.Rmd
	build-bookdown-gitbook/compile.sh "$<"

$(BOOKDOWN_LATEX_TMPDIR)/%.Rmd: %.Rmd
	build-bookdown-latex/compile.sh "$<"

figures/%.png: figures/%.svg
	inkscape "$<" --without-gui --export-dpi=150 --export-png="$@"

figures/%.pdf: figures/%.svg
	inkscape "$<" --without-gui --export-pdf="$@"
