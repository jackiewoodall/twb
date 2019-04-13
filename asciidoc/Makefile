INPUT_ADOC=book.txt

all: html5 pdf docx

clean:
	rm -f book.html
	rm -f book.docx
	rm -f book.pdf
	rm -f book.md

html: book.html

book.html: book.txt ../images/*
	asciidoctor -d book $(INPUT_ADOC)

html5: book.txt ../images/*
	asciidoctor -b html5 -d book -a data-uri book.txt

pdf: book.txt ../images/*
	asciidoctor-pdf $(INPUT_ADOC)

docx: book.txt ../images/*
	asciidoctor -b docbook -d book --out-file - $(INPUT_ADOC) | pandoc --from docbook --to docx --output book.docx

md: book.txt ../images/*
	asciidoctor -b html --out-file - $(INPUT_ADOC) | pandoc -f html -t markdown_strict -o book.md

txt: book.html
	html2text -nobs -style pretty book.html > book_out.txt
