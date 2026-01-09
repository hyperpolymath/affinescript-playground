;; SPDX-License-Identifier: AGPL-3.0-or-later
;; ECOSYSTEM.scm - Ecosystem position for affinescript-playground
;; Media-Type: application/vnd.ecosystem+scm

(ecosystem
  (version "1.0")
  (name "affinescript-playground")
  (type "reference-implementation")
  (purpose "Educational platform demonstrating affine type semantics for WebAssembly memory safety")

  (position-in-ecosystem
    (category "programming-languages")
    (subcategory "type-systems")
    (unique-value
      ("Affine types for JavaScript/WASM interop")
      ("Zero-runtime-cost ownership tracking")
      ("RSR-compliant development practices")
      ("ReScript-based implementation")))

  (related-projects
    (("Rust" "Systems language with affine/ownership types" "inspiration")
     ("Linear Haskell" "Linear types in functional programming" "conceptual")
     ("WebAssembly" "Compilation target with linear memory" "target")
     ("ReScript" "Type-safe JavaScript compilation" "implementation")))

  (what-this-is
    ("A learning playground for affine type concepts")
    ("Reference implementation of affine semantics")
    ("Examples of WASM memory management patterns")
    ("Demonstration of resource safety without garbage collection")
    ("Foundation for a potential AffineScript language"))

  (what-this-is-not
    ("A production-ready compiler")
    ("A complete programming language")
    ("A replacement for Rust or other systems languages")
    ("A garbage collector or memory manager")
    ("A TypeScript or Node.js project")))
