#PARTIALS=footer.mustache header.mustache

all: docs/index.html docs/download.html docs/games.html docs/about.html docs/contribute.html docs/criteria.html docs/faq.html docs/docs/style.css

#npx mustache $(ls partials/* | xargs -L1 echo -p | xargs) data.json index.mustache > index.html
#npx mustache `echo ${PARTIALS} | xargs -L1 echo -p | xargs` data.json index.mustache > index.html

docs/%.html: %.mustache
	npx mustache -p partials/header.mustache -p partials/footer.mustache data.json $< > $@

docs/style.css: style.css
	cp style.css docs/style.css
