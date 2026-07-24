.PHONY: serve build

serve:
	NO_MKDOCS_2_WARNING=true mkdocs serve

build:
	NO_MKDOCS_2_WARNING=true mkdocs build --clean
