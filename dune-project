(lang dune 3.5)

(name protc)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license "CC-BY-NC-4.0")

(documentation https://url/to/documentation)

(package
 (name protc)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune menhir)
 (tags
  (topics "to describe" "your" "project")))

(using menhir 2.0)
