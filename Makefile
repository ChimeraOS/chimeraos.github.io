#PARTIALS=footer.mustache header.mustache

all: docs/index.html docs/download.html docs/games.html docs/about.html docs/contribute.html docs/status.html docs/help.html docs/faq.html docs/docs.html docs/style.css docs/blog/proton-ge.html docs/blog/steam-deck.html docs/gamedb.yaml

docs/%.html: %.mustache
	npx mustache -p partials/header.mustache -p partials/footer.mustache data.json $< > $@

docs/blog/%.html: blog/%.mustache
	npx mustache -p partials/header.mustache -p partials/footer.mustache data.json $< > $@

docs/style.css: style.css
	cp style.css docs/style.css

docs/gamedb.yaml: FORCE
	wget -O docs/gamedb.yaml https://raw.githubusercontent.com/ChimeraOS/chimera-data/master/gamedb.yaml

FORCE:
