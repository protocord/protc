.PHONY: test

DUNE = dune

build:
	$(DUNE) build

test:
	$(DUNE) runtest

clean:
	$(DUNE) clean

format:
	ocamlformat --enable-outside-detected-project --inplace $(shell find src test -name "*.ml" -o -name "*.mli")

install:
	opam install . --deps-only

check:
	$(DUNE) build @check

run:
	$(DUNE) exec protc

defult:
	build

