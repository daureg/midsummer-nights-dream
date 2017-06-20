# vim: ft=make
PDFLATEX = pdflatex -interaction=batchmode
PDFCROP  = pdfcrop
FIGDIR   = assets/tikz/
StandAloneGraphicsTeXFiles = $(wildcard assets/tikz/*_tikz.tex)
PDFGraphics = $(patsubst %_tikz.tex,%_tikz.pdf,$(StandAloneGraphicsTeXFiles))

figures: drawing.tex $(PDFGraphics)

%_tikz.pdf : %_tikz.tex
	cd $(FIGDIR) && $(PDFLATEX) $(shell basename $<) && $(PDFCROP) $(shell basename $@) $(shell basename $@)

.PHONY: clean distclean

clean:
	cd $(FIGDIR) && rm -f *_tikz.aux *_tikz.log

distclean: clean
	cd $(FIGDIR) && rm -f *_tikz.pdf
