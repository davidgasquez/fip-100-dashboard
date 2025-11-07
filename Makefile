PYTHON ?= uv run --project datasets

DATASET_SCRIPTS := $(wildcard datasets/*.py)
DATASET_NAMES := $(patsubst datasets/%.py,%,$(DATASET_SCRIPTS))
JSON_TARGETS := $(addprefix public/,$(addsuffix .json,$(DATASET_NAMES)))

.PHONY: data

data: $(JSON_TARGETS)

$(JSON_TARGETS): public/%.json: datasets/%.py
	@mkdir -p public
	@$(PYTHON) $<

.PHONY: dev
dev:
	npm run dev

.PHONY: check
check:
	npm run astro check
