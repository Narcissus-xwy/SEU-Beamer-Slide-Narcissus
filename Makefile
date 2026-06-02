TeX = xelatex
out = out
ARGS = -output-directory=$(out) -interaction=nonstopmode

$(out):
	mkdir -p $(out)

example_clean: $(out)
	$(TeX) $(ARGS) example_clean
	$(TeX) $(ARGS) example_clean
	$(MAKE) clean-tmp

# 自定义编译：make tex=文件名
tex: $(out)
	$(TeX) $(ARGS) $(tex)
	$(TeX) $(ARGS) $(tex)
	$(MAKE) clean-tmp

.PHONY: clean clean-tmp

clean-tmp:
	rm -f $(out)/*.aux $(out)/*.bak $(out)/*.bbl $(out)/*.blg \
	      $(out)/*.dvi $(out)/*.fdb_latexmk $(out)/*.lof \
	      $(out)/*.lol $(out)/*.lot $(out)/*.nav $(out)/*.out \
	      $(out)/*.snm $(out)/*.synctex.gz $(out)/*.thm $(out)/*.toc

clean: clean-tmp
	rm -rf $(out)
