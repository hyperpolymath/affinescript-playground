;; SPDX-License-Identifier: AGPL-3.0-or-later
;; LLM_SUPERINTENDENT.scm - Instructions for AI agents operating on this repository

(define llm-superintendent
  '((schema . "hyperpolymath.superintendent/1")
    (repo . "hyperpolymath/affinescript-playground")
    (updated . "2026-01-01")

    (identity
      . ((role . "playground-demo-suite")
         (NOT . "compiler-implementation")))

    (prime-directive
      . ("This repository is a DOWNSTREAM consumer of AffineScript."
         "Do NOT implement language semantics here."
         "All language behavior must come from upstream: hyperpolymath/affinescript"))

    (scope-constraints
      . ((allowed
           . ("UI components for playground"
              "WASM loading and interop glue"
              "Demo examples that exercise affine semantics"
              "ReScript source for playground logic"
              "Scheme configuration files"
              "Shell/Just build orchestration"
              "HTML/CSS for presentation"))
         (forbidden
           . ("Parser implementations for AffineScript"
              "Type checker implementations"
              "Code generators targeting WASM"
              "Semantic analysis passes"
              "Expanding TypeScript beyond generated/glue code"
              "npm dependencies when Deno suffices"))))

    (preferred-stack
      . ((primary . "ReScript")
         (config . "Scheme")
         (build . ("Just" "Shell" "Deno"))
         (avoid . ("TypeScript growth" "npm lock-in" "heavy frameworks"))))

    (verification
      . ((smoke-test . "deno task test")
         (dev-server . "deno task dev")
         (must-work-offline . #t)))

    (when-in-doubt
      . ("Ask: does this belong in the upstream compiler repo?"
         "Ask: can this use ReScript instead of TypeScript?"
         "Ask: does this add network-required dependencies?"
         "If yes to any: stop and reconsider."))))
