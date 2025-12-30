;; SPDX-License-Identifier: AGPL-3.0-or-later
;; AGENTIC.scm - AI agent interaction patterns

(define agentic-config
  `((version . "1.0.0")
    (project . "affinescript-playground")
    (claude-code
      ((model . "claude-opus-4-5-20251101")
       (tools . ("read" "edit" "bash" "grep" "glob"))
       (permissions . "read-all")))
    (patterns
      ((code-review . "thorough")
       (refactoring . "conservative")
       (testing . "comprehensive")
       (type-checking . "strict")))
    (constraints
      ((languages . ("ocaml" "scheme"))
       (banned . ("typescript" "go" "python" "makefile"))))
    (project-specific
      ((wasm-output . "validate-with-wabt")
       (type-system . "enforce-affine-semantics")))))
