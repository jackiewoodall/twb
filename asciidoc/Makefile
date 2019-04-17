INPUT_ADOC=book.txt

all: html5 pdf docx md txt

clean:
	rm -f book.html
	rm -f book.docx
	rm -f book.pdf
	rm -f book.md
	rm -f book_text.txt

html: $(INPUT_ADOC) ../images/*
	asciidoctor -d book $(INPUT_ADOC)

html5: $(INPUT_ADOC) ../images/*
	asciidoctor -b html5 -d book -a data-uri $(INPUT_ADOC)

pdf: $(INPUT_ADOC) ../images/*
	asciidoctor-pdf $(INPUT_ADOC)

docx: $(INPUT_ADOC) ../images/*
	asciidoctor -b docbook -d book --out-file - $(INPUT_ADOC) | pandoc --from docbook --to docx --toc --toc-depth=2 --output book.docx

md: book.txt ../images/*
	asciidoctor -b html --out-file - $(INPUT_ADOC) | pandoc -f html -t markdown_strict -o book.md

txt: book.html
	html2text -nobs -style pretty book.html > book_text.txt
