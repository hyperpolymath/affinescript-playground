;; SPDX-License-Identifier: AGPL-3.0-or-later
;; ECOSYSTEM.scm - Ecosystem positioning

(ecosystem
  (version . "1.0.0")
  (name . "affinescript-playground")
  (type . "language-playground")
  (purpose . "Experimentation with affine types for WebAssembly")

  (position-in-ecosystem
    ((parent . "language-playgrounds")
     (grandparent . "nextgen-languages")
     (category . "resource-management-languages")))

  (related-projects
    ((ephapax-playground
       ((relationship . "sibling-standard")
        (description . "Linear types counterpart - exactly-once usage")))
     (mylang-playground
       ((relationship . "sibling-standard")
        (description . "Progressive type system family")))
     (rust
       ((relationship . "inspiration")
        (description . "Affine type concepts from Rust ownership")))))

  (what-this-is
    ("Affine type experimentation for WASM"
     "Memory safety through type-level resource tracking"
     "JavaScript interop exploration"))

  (what-this-is-not
    ("Production compiler"
     "Linear types (see ephapax)"
     "General purpose language")))
