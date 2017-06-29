# vim: ft=make
PDFLATEX = pdflatex -interaction=batchmode
PDFCROP  = pdfcrop
FIGDIR   = assets/tikz/
StandAloneGraphicsTeXFiles = $(wildcard assets/tikz/*_tikz.tex)
PDFGraphics = $(patsubst %_tikz.tex,%_tikz.pdf,$(StandAloneGraphicsTeXFiles))

figures: drawing.tex $(PDFGraphics)

%_tikz.pdf : %_tikz.tex
	cd $(FIGDIR) && $(PDFLATEX) $(shell basename $<) && $(PDFCROP) $(shell basename $@) $(shell basename $@)

low: lowstretch_and_cc.tex gtx_algorithm.tex
	rm -f lowstretch_and_cc.{acn,acr,alg,aux,bbl,bcf,blg,dvi,fdb_latexmk,fls,glg,glo,gls,idx,ilg,ind,ist,lof,log,lot,maf,mtc,mtc0,nav,nlo,out,pdfsync,ps,run.xml,snm,synctex.gz,toc,vrb,xdy,tdo,lol,tps,tcp,thm}
	pdflatex lowstretch_and_cc.tex && biber lowstretch_and_cc && pdflatex -interaction=batchmode lowstretch_and_cc && pdflatex -interaction=batchmode lowstretch_and_cc

.PHONY: clean distclean

clean:
	cd $(FIGDIR) && rm -f *_tikz.aux *_tikz.log

distclean: clean
	cd $(FIGDIR) && rm -f *_tikz.pdf
