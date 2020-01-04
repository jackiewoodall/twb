INPUT_ADOC=book.adoc
INDIR=asciidoc/
INFILE=$(INDIR)$(INPUT_ADOC)
OUTNAME=the_way_beyond
OUTDIR=./
OUTFILE=$(OUTDIR)$(OUTNAME)
IMAGES=./images/*.jpg
EXTS=htm html xhtml5 pdf docx md txt epub mobi

all: $(EXTS)

clean:
	for ext in $(EXTS); do rm -f $(OUTFILE).$$ext; done

htm: $(OUTFILE).htm

$(OUTFILE).htm: $(INFILE)
	asciidoctor -d book $(INFILE) -o $(OUTFILE).htm

html: $(OUTFILE).html

$(OUTFILE).html: $(INFILE) $(IMAGES)
	asciidoctor -b html5 -d book -a data-uri $(INFILE) -o $(OUTFILE).html

xhtml5: $(OUTFILE).xhtml5

$(OUTFILE).xhtml5: $(INFILE) $(IMAGES)
	asciidoctor -b xhtml5 -d book -a data-uri $(INFILE) -o $(OUTFILE).xhtml5

pdf: $(OUTFILE).pdf

$(OUTFILE).pdf: $(INFILE) $(IMAGES)
	asciidoctor-pdf $(INFILE) -o $(OUTFILE).pdf

docx: $(OUTFILE).docx

$(OUTFILE).docx: $(INFILE) $(IMAGES)
	asciidoctor -b docbook -d book --out-file - $(INFILE) | pandoc --from docbook --to docx --toc --toc-depth=2 --output $(OUTFILE).docx

md: $(OUTFILE).md

$(OUTFILE).md: $(OUTFILE).htm
	pandoc -f html -t gfm -o $(OUTFILE).md $(OUTFILE).htm

txt: $(OUTFILE).txt

$(OUTFILE).txt: $(OUTFILE).htm
	pandoc -f html -t plain -o $(OUTFILE).txt $(OUTFILE).htm

epub: $(OUTFILE).epub

$(OUTFILE).epub: $(OUTFILE).htm
	pandoc -f html -t epub3 --epub-cover-image=images/0-cover-1-front.jpg -o $(OUTFILE).epub $(OUTFILE).htm

mobi: $(OUTFILE).mobi

$(OUTFILE).mobi: $(OUTFILE).epub
	ebook-convert $(OUTFILE).epub $(OUTFILE).mobi

