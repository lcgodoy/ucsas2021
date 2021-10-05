SOURCES=$(shell find . -name "*.Rmd")
TARGET=$(SOURCES:%.Rmd=%.html)

all: $(TARGET)

%.html : %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

clean :
	rm -rf *.pdf *.log *.aux *.tex *.html *~

clean_temp :
	rm -rf *.log *.tex *.aux *\#* .\#* *~

clean_log :
	rm -rf *.log *.tex *.aux
