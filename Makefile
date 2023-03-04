build: clean
	npx eleventy

serve: build
	npx eleventy --serve

clean:
	rm -rf docs/*
