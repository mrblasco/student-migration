# Makefile for compiling Rmd reports

# Define variables
RMD_FILES := $(wildcard *.Rmd)
HTML_FILES := $(patsubst %.Rmd,%.html,$(RMD_FILES))
OUTPUT_DIR := _output
MAIN_FILE := main.Rmd
PDF_FILE := output.pdf
BIB_FILE := references.bib

# Rule to build HTML files from Rmd files
%.html: %.Rmd
	Rscript -e "rmarkdown::render('$<')"

# Rule to build PDF from main Rmd file
$(PDF_FILE): $(MAIN_FILE) $(RMD_FILES) $(BIB_FILE)
	Rscript -e "rmarkdown::render('$<', output_file = '$@', output_format = 'pdf_document')"

# Default target to build the main HTML file
all: $(MAIN_FILE:.Rmd=.html)

# Clean target to remove HTML, PDF, and output directory
clean:
	rm -rf $(HTML_FILES) $(OUTPUT_DIR) $(PDF_FILE)

view:
	open $(PDF_FILE)

# Phony targets
.PHONY: all clean view
