INPUT_ADOC=book.txt
INDIR=asciidoc/
OUTNAME=the_way_beyond
OUTDIR=./

all: html5 pdf docx md txt epub mobi

clean:
	rm -f $(OUTDIR)/$(OUTNAME).html
	rm -f $(OUTDIR)/$(OUTNAME).pdf
	rm -f $(OUTDIR)/$(OUTNAME).docx
	rm -f $(OUTDIR)/$(OUTNAME).md
	rm -f $(OUTDIR)/$(OUTNAME).txt
	rm -f $(OUTDIR)/$(OUTNAME).epub
	rm -f $(OUTDIR)/$(OUTNAME).mobi

html: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -d book $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).html

html5: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b html5 -d book -a data-uri $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).html

pdf: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor-pdf $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).pdf

docx: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b docbook -d book --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc --from docbook --to docx --toc --toc-depth=2 --output $(OUTDIR)/$(OUTNAME).docx

md: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b html --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc -f html -t gfm -o $(OUTDIR)/$(OUTNAME).md

txt: $(OUTDIR)/$(OUTNAME).html
	asciidoctor -b html --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc -f html -t plain -o $(OUTDIR)/$(OUTNAME).txt

epub: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor-epub3 $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).epub

mobi: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor-epub3 -v -D . -a ebook-format=kf8 $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).mobi
