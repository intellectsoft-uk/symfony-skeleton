.PHONY: all test clean build install apidoc

all: build

build: install
	@echo building for CI
	mkdir -p build
	rm -Rf build/*

	@echo Run tests

	@echo build optimized autoloader
	composer --ignore-platform-reqs  -q -n install
	composer dump -o

	@echo Build artifacts
	tar --exclude=".git" \
	    --exclude=".idea" \
	    --exclude="*.iml" \
	    --exclude="*.iml" \
	    --exclude=".vagrant" \
	    --exclude="build" \
	    --exclude="push_server" \
	    --exclude="node_modules" \
	    --exclude="devops" \
	    --exclude="features" \
	    --exclude="app/cache" \
	    --exclude="app/logs" \
	    --exclude="parameters.yml" \
	    -zcf build/build.tgz .

clean:
	@echo cleaning up build artifacts from previous build
	rm -rf builds

install:
	@echo Installing dependencies
	npm install
	composer --ignore-platform-reqs  -q -n install

apidoc: install
	@echo Build API documentation

	./node_modules/.bin/aglio   -i src/Resources/docs/api_documentation.md \
								-o web/api_documentation.html

test: install
	@echo Run tests