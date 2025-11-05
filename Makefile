PYTHON ?= uv run

DATASET_SCRIPTS := $(wildcard datasets/*.py)
DATASET_NAMES := $(patsubst datasets/%.py,%,$(DATASET_SCRIPTS))
CSV_TARGETS := $(addprefix data/,$(addsuffix .csv,$(DATASET_NAMES)))

.PHONY: data

data: $(CSV_TARGETS)

$(CSV_TARGETS): data/%.csv: datasets/%.py
	@mkdir -p data
	@$(PYTHON) $<

.PHONY: dashboard
dashboard:
	npm run dev --prefix dashboard
