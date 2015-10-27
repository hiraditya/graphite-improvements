paper = graphite_design
$(paper).pdf: $(paper).tex Bibliography.bib
	pdflatex $(paper)
	bibtex $(paper)
	pdflatex $(paper)
	pdflatex $(paper)

latexmk: $(paper).tex Bibliography.bib
	latexmk -pdf -pvc $< -pdflatex="pdflatex --shell-escape %O %S"

clean:
	rm -rf *.aux *.bbl *.blg *.log *.out *.pdf

all: $(paper).pdf
