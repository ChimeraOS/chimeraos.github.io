#PARTIALS=footer.mustache header.mustache

all: docs/index.html docs/download.html docs/games.html docs/about.html docs/contribute.html docs/criteria.html docs/help.html docs/faq.html docs/docs.html docs/style.css docs/blog/proton-ge.html docs/blog/steam-deck.html

docs/%.html: %.mustache
	npx mustache -p partials/header.mustache -p partials/footer.mustache data.json $< > $@

docs/blog/%.html: blog/%.mustache
	npx mustache -p partials/header.mustache -p partials/footer.mustache data.json $< > $@

docs/style.css: style.css
	cp style.css docs/style.css

