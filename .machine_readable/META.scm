;; SPDX-License-Identifier: AGPL-3.0-or-later
;; META.scm - Meta-level information for affinescript-playground
;; Media-Type: application/meta+scheme

(meta
  (architecture-decisions
    (("ADR-001" "Use Deno as Runtime"
      "Deno provides built-in TypeScript/JavaScript execution with security-first design, aligning with RSR compliance")
    ("ADR-002" "ReScript for Core Implementation"
      "ReScript provides strong type safety that compiles to clean JavaScript, avoiding TypeScript bloat")
    ("ADR-003" "Affine Over Linear Types"
      "Affine types (use at most once) are more practical than linear types (use exactly once) for resource management")
    ("ADR-004" "WebAssembly Target"
      "WASM provides portable, sandboxed execution with linear memory that benefits from affine ownership")))

  (development-practices
    (code-style
      ("ReScript standard formatting")
      ("JSDoc comments for JavaScript")
      ("Explicit resource ownership documentation"))
    (security
      (principle "Defense in depth")
      (practices
        ("Affine types prevent use-after-free")
        ("No implicit resource sharing")
        ("Compile-time ownership verification")))
    (testing
      ("Deno test framework")
      ("Property-based testing for type violations")
      ("Example-based tests for happy paths"))
    (versioning "SemVer")
    (documentation "AsciiDoc")
    (branching "main for stable"))

  (design-rationale
    (("Substructural Types"
      "Affine types are part of substructural type systems that restrict structural rules like contraction and weakening")
    ("Memory Safety"
      "By preventing double-use, affine types eliminate use-after-free bugs at compile time")
    ("WASM Integration"
      "WebAssembly's linear memory model naturally aligns with affine ownership semantics")
    ("Zero Runtime Cost"
      "Type checking happens at compile time; runtime code has no ownership overhead"))))
