srcdir  = .

main = disc3
figs = $(wildcard figs/*)
style = $(shell find . -maxdepth 2 -name "*.sty")

pdf : $(main).pdf
.PHONY: pdf

%.pdf: %.tex $(figs) $(style)
	texfot lualatex -shell-escape $(main).tex

clean :
	 rm -rf $(main).pdf *.aux *.out *.log _minted* *.bbl *.bcf *.blg *.nav *.run.xml *.snm *.toc *.vrb
