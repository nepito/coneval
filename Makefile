# I Declaración del _phony_ *all* que enlista todos los objetivos principales
# ==============================================================================
all: reports/gini_mexico.pdf

define runLintr
	R -e "library(lintr)" \
      -e "lint('tests/testthat/test_read_gini_data.R', linters = with_defaults(line_length_linter(100)))"
endef

# II Declaración de las variables
# ==============================================================================
csvExitoEclosion = \
	data/raw/exito_eclosion_masa_vuelo_pollos_petrel_negro_san_benito_2017.csv

# III Reglas para construir los objetivos principales
# ==============================================================================
reports/gini_mexico.pdf: reports/gini_mexico.tex
	cd $(<D) && pdflatex $(<F)
	cd $(<D) && pythontex $(<F)
	cd $(<D) && bibtex $(subst .tex,,$(<F))
	cd $(<D) && pdflatex $(<F)
	cd $(<D) && pdflatex $(<F)

# IV Reglas para construir las dependencias de los objetivos principales
# ==============================================================================
src/Fledging_mass.R: src/notebooks/Fledging_mass.ipynb
	jupytext --output $@ $<

src/Fledging_mass.ipynb: src/Fledging_mass.R
	jupytext --output $@ $<

reports/Fledging_mass.md: src/notebooks/Fledging_mass.ipynb
	mkdir --parents $(@D)
	jupytext --output $@ $<

$(csvExitoEclosion):
	mkdir --parents $(@D)
	descarga_datos $(@F) $(@D)
# V Regla del resto de los phonies
# ==============================================================================
.PHONY: clean cleanLatex tests

clean: cleanLatex
	rm --force --recursive reports/pythontex*
	rm --force coneva*.tar.gz

cleanLatex:
	rm --force reports/*.aux
	rm --force reports/*.bbl
	rm --force reports/*.blg
	rm --force reports/*.log
	rm --force reports/*.out
	rm --force reports/*.pdf
	rm --force reports/*.pytxcode

install:
	R CMD build coneval
	R CMD INSTALL coneval_1.0.tar.gz

lintr:
	$(runLintr)
	$(runLintr) | grep -e "\^" && exit 1 || exit 0

tests:
	R -e "testthat::test_dir('coneval/tests/testthat/', report = 'summary', stop_on_failure = TRUE)"