INPUT_ADOC=book.txt
OUTNAME=the_way_beyond
OUTDIR=../

all: html5 pdf docx md txt

clean:
	rm -f $(OUTDIR)/$(OUTNAME).html
	rm -f $(OUTDIR)/$(OUTNAME).pdf
	rm -f $(OUTDIR)/$(OUTNAME).docx
	rm -f $(OUTDIR)/$(OUTNAME).md
	rm -f $(OUTDIR)/$(OUTNAME).txt

html: $(INPUT_ADOC) ../images/*
	asciidoctor -d book $(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).html

html5: $(INPUT_ADOC) ../images/*
	asciidoctor -b html5 -d book -a data-uri $(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).html

pdf: $(INPUT_ADOC) ../images/*
	asciidoctor-pdf $(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).pdf

docx: $(INPUT_ADOC) ../images/*
	asciidoctor -b docbook -d book --out-file - $(INPUT_ADOC) | pandoc --from docbook --to docx --toc --toc-depth=2 --output $(OUTDIR)/$(OUTNAME).docx

md: book.txt ../images/*
	asciidoctor -b html --out-file - $(INPUT_ADOC) | pandoc -f html -t markdown_strict -o $(OUTDIR)/$(OUTNAME).md

txt: $(OUTDIR)/$(OUTNAME).html
	html2text -nobs -style pretty $(OUTDIR)/$(OUTNAME).html > $(OUTDIR)/$(OUTNAME).txt
