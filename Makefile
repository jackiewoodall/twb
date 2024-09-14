INPUT_ADOC=book.adoc
INDIR=asciidoc/
INFILE=$(INDIR)$(INPUT_ADOC)
OUTNAME=the_way_beyond
OUTDIR=./
OUTFILE=$(OUTDIR)$(OUTNAME)
IMAGES=./images/*.jpg
EXTS=htm html pdf docx md txt epub mobi azw3 xml

all: $(EXTS)

clean:
	for ext in $(EXTS); do rm -f $(OUTFILE).$$ext; done

htm: $(OUTFILE).htm

$(OUTFILE).htm: $(INFILE)
	asciidoctor -d book $(INFILE) -o $(OUTFILE).htm

html: $(OUTFILE).html

$(OUTFILE).html: $(INFILE) $(IMAGES)
	asciidoctor -b html5 -d book -a data-uri $(INFILE) -o $(OUTFILE).html

pdf: $(OUTFILE).pdf

$(OUTFILE).pdf: $(INFILE) $(IMAGES)
	asciidoctor-pdf $(INFILE) -o $(OUTFILE).pdf

xml: $(OUTFILE).xml

$(OUTFILE).xml: $(INFILE) $(IMAGES)
	asciidoctor -b docbook -d book $(INFILE) -o $(OUTFILE).xml

docx: $(OUTFILE).docx

$(OUTFILE).docx: $(OUTFILE).xml
	pandoc -f docbook -t docx --toc --toc-depth=2 -o $(OUTFILE).docx $(OUTFILE).xml

md: $(OUTFILE).md

$(OUTFILE).md: $(OUTFILE).htm
	pandoc -f html -t gfm -s --toc --toc-depth=2 -o $(OUTFILE).md $(OUTFILE).htm

txt: $(OUTFILE).txt

$(OUTFILE).txt: $(OUTFILE).htm
	pandoc -f html -t plain -s --toc --toc-depth=2 -o $(OUTFILE).txt $(OUTFILE).htm

epub: $(OUTFILE).epub

$(OUTFILE).epub: $(OUTFILE).xml
	pandoc -f docbook -t epub3 --epub-cover-image=images/0-cover-1-front.jpg --toc --toc-depth=2 -o $(OUTFILE).epub $(OUTFILE).xml
	ebook-polish -u -i -U $(OUTFILE).epub $(OUTFILE).epub

mobi: $(OUTFILE).mobi

$(OUTFILE).mobi: $(OUTFILE).epub
	ebook-convert $(OUTFILE).epub $(OUTFILE).mobi

azw3: $(OUTFILE).azw3

$(OUTFILE).azw3: $(OUTFILE).epub
	ebook-convert $(OUTFILE).epub $(OUTFILE).azw3

