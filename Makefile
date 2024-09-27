include .env
export

all: cv_en.pdf cv_pt.pdf

define escape_for_perl
$(subst &,\&,$(subst ?,\?,$(subst =,\=,$(1))))
endef

define perl_replace
	perl -pe 's/\\newcommand\{\\fullname\}\{\}/\\newcommand{\\fullname}{$(call escape_for_perl,$(1))}/g; \
		s/\\newcommand\{\\email\}\{\}/\\newcommand{\\email}{$(call escape_for_perl,$(2))}/g; \
		s/\\newcommand\{\\phone\}\{\}/\\newcommand{\\phone}{$(call escape_for_perl,$(3))}/g; \
		s/\\newcommand\{\\location\}\{\}/\\newcommand{\\location}{$(call escape_for_perl,$(4))}/g; \
		s|\\newcommand\{\\linkedinurl\}\{\}|\\newcommand{\\linkedinurl}{$(call escape_for_perl,$(5))}|g;'
endef

cv_en.pdf: main_en.tex chapters/*_en.tex config/*.tex
	@echo "Compiling English version..."
	$(call perl_replace,$(FULLNAME),$(EMAIL),$(PHONE),$(LOCATION),$(LINKEDINURL)) main_en.tex > main_en_temp.tex
	pdflatex -interaction=nonstopmode -file-line-error main_en_temp.tex
	pdflatex -interaction=nonstopmode -file-line-error main_en_temp.tex
	mv main_en_temp.pdf cv_en.pdf
	rm main_en_temp.*

cv_pt.pdf: main_pt.tex chapters/*_pt.tex config/*.tex
	@echo "Compiling Portuguese version..."
	$(call perl_replace,$(FULLNAME_PT),$(EMAIL_PT),$(PHONE_PT),$(LOCATION_PT),$(LINKEDINURL_PT)) main_pt.tex > main_pt_temp.tex
	pdflatex -interaction=nonstopmode -file-line-error main_pt_temp.tex
	pdflatex -interaction=nonstopmode -file-line-error main_pt_temp.tex
	mv main_pt_temp.pdf cv_pt.pdf
	rm main_pt_temp.*

clean:
	@echo "Cleaning up..."
	rm -f *.aux *.log *.out *.pdf main_*_temp.* cv_en.pdf cv_pt.pdf

.PHONY: all clean