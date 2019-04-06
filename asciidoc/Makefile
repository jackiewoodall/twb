INPUT_ADOC=book.txt

all: html5 pdf docx

clean:
	rm -f book.html
	rm -f book.docx
	rm -f book.pdf

html: book.html

book.html: book.txt ../images/*
	asciidoctor -a toc -d book $(INPUT_ADOC)

html5: book.txt ../images/*
	asciidoctor --backend html5 -a data-uri -a toc book.txt

pdf: book.txt ../images/*
	asciidoctor-pdf -a toc $(INPUT_ADOC)

docx: book.txt ../images/*
	asciidoctor --backend docbook -a toc --out-file - $(INPUT_ADOC)|pandoc --from docbook --to docx --output book.docx

txt: book.html
	html2text -nobs -style pretty book.html > book_out.txt

