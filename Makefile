TeX = xelatex

example_clean:
	\This is TeX, Version 3.141592653 (TeX Live 2026) (preloaded format=tex) ** ! End of file on the terminal... why? example_clean
	\This is TeX, Version 3.141592653 (TeX Live 2026) (preloaded format=tex) ** ! End of file on the terminal... why? example_clean

.PHONY: clean

clean:
	rm -f *.aux *.bak *.log *.bbl *.dvi *.blg *.thm *.toc *.out *.lof *.lol *.lot *.nav *.snm *.fdb_latexmk *.synctex.gz
