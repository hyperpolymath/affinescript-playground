;; SPDX-License-Identifier: AGPL-3.0-or-later
;; PLAYBOOK.scm - Operational runbook

(define playbook
  `((version . "1.0.0")
    (project . "affinescript-playground")
    (procedures
      ((build
         (("setup" . "opam install . --deps-only")
          ("build" . "dune build")
          ("test" . "dune test")))
       (run
         (("repl" . "dune exec affinescript")
          ("example" . "dune exec affinescript -- examples/hello.afs")))
       (wasm
         (("compile" . "dune exec affinescript -- --target=wasm32 src/main.afs")
          ("optimize" . "wasm-opt -O3 output.wasm -o output.opt.wasm")))))
    (alerts ())
    (contacts ())))
