#PARTIALS=footer.mustache header.mustache

all: build/index.html build/download.html build/games.html build/about.html build/contribute.html build/criteria.html build/style.css

#npx mustache $(ls partials/* | xargs -L1 echo -p | xargs) data.json index.mustache > index.html
#npx mustache `echo ${PARTIALS} | xargs -L1 echo -p | xargs` data.json index.mustache > index.html

build/%.html: %.mustache
	npx mustache -p partials/header.mustache -p partials/footer.mustache data.json $< > $@

build/style.css: style.css
	cp style.css build/style.css
