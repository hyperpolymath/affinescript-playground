;; SPDX-License-Identifier: AGPL-3.0-or-later
;; META.scm - Project metadata and architecture decisions

(define project-meta
  `((version . "1.0.0")
    (name . "affinescript-playground")
    (architecture-decisions
      ((adr-001
         ((status . "accepted")
          (date . "2025-12-30")
          (context . "Need affine type semantics for WebAssembly resource management")
          (decision . "Implement affine types with at-most-once usage semantics")
          (consequences . "Resources can be dropped without use, simpler than linear types")))))
    (development-practices
      ((code-style . "ocaml-standard")
       (security . "openssf-scorecard")
       (testing . "property-based")
       (versioning . "semver")
       (documentation . "asciidoc")
       (branching . "trunk-based")))
    (design-rationale
      ((why-ocaml . "Strong type system for compiler implementation")
       (why-wasm . "Universal target for web and edge computing")
       (why-affine . "Simpler resource management than linear types")))))
