INPUT_ADOC=book.txt
INDIR=asciidoc/
OUTNAME=the_way_beyond
OUTDIR=./

all: html5 pdf docx md txt

clean:
	rm -f $(OUTDIR)/$(OUTNAME).html
	rm -f $(OUTDIR)/$(OUTNAME).pdf
	rm -f $(OUTDIR)/$(OUTNAME).docx
	rm -f $(OUTDIR)/$(OUTNAME).md
	rm -f $(OUTDIR)/$(OUTNAME).txt

html: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -d book $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).html

html5: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b html5 -d book -a data-uri $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).html

pdf: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor-pdf $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).pdf

docx: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b docbook -d book --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc --from docbook --to docx --toc --toc-depth=2 --output $(OUTDIR)/$(OUTNAME).docx

md: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b html --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc -f html -t markdown_strict -o $(OUTDIR)/$(OUTNAME).md

txt: $(OUTDIR)/$(OUTNAME).html
	html2text -nobs -style pretty $(OUTDIR)/$(OUTNAME).html > $(OUTDIR)/$(OUTNAME).txt