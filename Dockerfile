
FROM ocaml/opam:latest

USER opam

WORKDIR /app
COPY . .

RUN make install && \
    eval $(opam env) && \
    make build
