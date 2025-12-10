PYTHON ?= uv run --project datasets

DATASET_SCRIPTS := $(wildcard datasets/*.py)
DATASET_NAMES := $(patsubst datasets/%.py,%,$(DATASET_SCRIPTS))
JSON_TARGETS := $(addprefix public/,$(addsuffix .json,$(DATASET_NAMES)))

.PHONY: data build setup dev check

data: $(JSON_TARGETS)

$(JSON_TARGETS): public/%.json: datasets/%.py
	@mkdir -p public
	@$(PYTHON) $<

setup: package.json package-lock.json
	npm install

dev: setup
	npm run dev

build: setup data
	npm run build

check: setup
	npm run astro check
