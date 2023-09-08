SHELL:=/bin/bash -O extglob

# fast compiling
Fast ?= FALSE

TEXS = thesis.tex acronyms.tex abstract.tex introduction.tex polynomials.tex polynomials_preliminaries.tex ikt.tex 7DOF.tex conclusions.tex introduction_old.tex polynomials_old.tex ikt_old.tex sources/code/maple.tex goals_old.tex

TEMPLATE = cmpthesis.cls cmpcover.sty images/CIIRC.pdf images/CTU.pdf

IMAGES = KUKA-LBR-IIWA-Kuhleman-2016.png

ALGS = 

GRAPHS_FILES = 3D_GB 3D_gloptipoly errors_GB timesGloptipoly_GB timesMaple_GB
GRAPHS_PDF = $(addsuffix .pdf, $(GRAPHS_FILES))
GRAPHS_TEX = $(addsuffix .tex, $(GRAPHS_FILES))
GRAPHS_EPS = $(addsuffix .eps, $(GRAPHS_FILES))
GRAPHS = $(GRAPHS_TEX) $(GRAPHS_PDF)

DRAWINGS_FILES = angles proof
DRAWINGS_PDF = $(addsuffix .pdf, $(DRAWINGS_FILES))

TABLES_FILES = 
TABLES_TEXS = $(addsuffix .tex, $(TABLES_FILES))

MACROS_FILES = GB gloptipoly
MACROS_TEXS = $(addsuffix .tex, $(MACROS_FILES))

INTER = $(addprefix graphs/, $(GRAPHS_EPS))

.PHONY: all fast pdf clean
.SECONDEXPANSION:
.INTERMEDIATE: $$(INTER)

all: thesis.pdf

pdf: thesis.pdf

fast: Fast = TRUE
fast: thesis.pdf

thesis.pdf: $(TEXS) citations.bib $(TEMPLATE) $$(addprefix images/, $(IMAGES)) $$(addprefix alg/, $(ALGS)) $$(addprefix graphs/, $(GRAPHS)) $$(addprefix images/, $(DRAWINGS_PDF)) $$(addprefix tables/, $(TABLES_TEXS)) $$(addprefix macros/, $(MACROS_TEXS))
	sed -i 's/\eqB/\begin{align}/g' !(thesis).tex
	sed -i 's/\eqE/\end{align}/g' !(thesis).tex
	pdflatex thesis.tex
	makeglossaries thesis
	if [ "$(Fast)" = "FALSE" ]; then \
		bibtex thesis; \
		pdflatex thesis.tex; \
		pdflatex thesis.tex; \
	fi

graphs/%.pdf: graphs/%.eps
	ps2pdf -dEPSCrop graphs/$*.eps graphs/$*.pdf
	-rm graphs/$*.eps

graphs/%.tex graphs/%.eps: sources/graphs/%.gnuplot
	gnuplot sources/graphs/$*.gnuplot

images/%.pdf: sources/drawings/%.ipe
	ipetoipe -pdf -export sources/drawings/$*.ipe images/$*.pdf

graphs/3D_GB.tex graphs/3D_GB.eps: sources/graphs/3D_GB.gnuplot data/3D_GB.dat
	gnuplot sources/graphs/3D_GB.gnuplot

graphs/3D_gloptipoly.tex graphs/3D_gloptipoly.eps: sources/graphs/3D_gloptipoly.gnuplot data/3D_gloptipoly.dat
	gnuplot sources/graphs/3D_gloptipoly.gnuplot

graphs/errors_GB.tex graphs/errors_GB.eps: sources/graphs/errors_GB.gnuplot data/errorsT_GB.dat data/errorsR_GB.dat
	gnuplot sources/graphs/errors_GB.gnuplot

graphs/timesGloptipoly_GB.tex graphs/timesGloptipoly_GB.eps: sources/graphs/timesGloptipoly_GB.gnuplot data/timesGloptipoly_GB.dat
	gnuplot sources/graphs/timesGloptipoly_GB.gnuplot

graphs/timesMaple_GB.tex graphs/timesMaple_GB.eps: sources/graphs/timesMaple_GB.gnuplot data/timesMaple_GB.dat
	gnuplot sources/graphs/timesMaple_GB.gnuplot

clean:
	-rm thesis.!(tex)
	-rm $(addprefix graphs/, $(GRAPHS)) $(addprefix graphs/, $(GRAPHS_EPS))
