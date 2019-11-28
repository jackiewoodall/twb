INPUT_ADOC=book.adoc
INDIR=asciidoc/
OUTNAME=the_way_beyond
OUTDIR=./
EXTS=htm html xhtml5 pdf docx md txt epub

all: $(EXTS)

clean:
	for ext in $(EXTS); do rm -f $(OUTDIR)/$(OUTNAME).$$ext; done

htm: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -d book $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).htm

html: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b html5 -d book -a data-uri $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).html

xhtml5: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b xhtml5 -d book -a data-uri $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).xhtml5

pdf: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor-pdf $(INDIR)/$(INPUT_ADOC) -o $(OUTDIR)/$(OUTNAME).pdf

docx: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b docbook -d book --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc --from docbook --to docx --toc --toc-depth=2 --output $(OUTDIR)/$(OUTNAME).docx

md: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b html --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc -f html -t gfm -o $(OUTDIR)/$(OUTNAME).md

txt: $(OUTDIR)/$(OUTNAME).html
	asciidoctor -b html --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc -f html -t plain -o $(OUTDIR)/$(OUTNAME).txt

epub: $(INDIR)/$(INPUT_ADOC) ./images/*
	asciidoctor -b html --out-file - $(INDIR)/$(INPUT_ADOC) | pandoc -f html -t epub3 -o $(OUTDIR)/$(OUTNAME).epub
