;; ANCHOR.scope-arrest.2026-01-01.Jewell.scm
;; Repo: hyperpolymath/affinescript-playground
;; Purpose: keep this a playground (UI/interop/demo), NOT a second compiler.

(define anchor
  '((schema . "hyperpolymath.anchor/1")
    (repo . "hyperpolymath/affinescript-playground")
    (date . "2026-01-01")
    (authority . "repo-superintendent")
    (purpose
      . ("Scope arrest: this repo is a playground + demos for AffineScript (WASM + JS interop)."
         "Prevent accidental creation of a second language implementation."
         "Make one reproducible demo path run offline."
         "Prefer ReScript; constrain TypeScript to generated output or minimal glue."))

    (identity
      . ((project . "AffineScript Playground")
         (kind . "playground")
         (one-sentence
           . "A web playground and demo suite for AffineScript: affine resources, WASM compilation, JS integration.")
         (status . "f0-control-pass")))

    (semantic-anchor
      . ((policy . "downstream")
         (upstream-authority
           . ("AffineScript language semantics live in hyperpolymath/affinescript"
              "This repo must consume compiler/runtime artifacts; it must not define semantics"))
         (binding
           . ("Any example code here must be valid against upstream conformance rules"))))

    (implementation-policy
      . ((primary-languages
           . ("ReScript" "Scheme" "Shell" "Just"))
         (allowed
           . ("ReScript"
              "Scheme"
              "Shell"
              "Just"
              "HTML/CSS"
              "Deno (runtime)"
              ))
         (quarantined
           . ("TypeScript (only if generated from ReScript or tiny interop glue; do not expand TS surface)"
              "Bundlers/frameworks (optional; must not become required)"))
         (forbidden
           . ("Implementing a compiler/parser/typechecker for AffineScript here"
              "Introducing npm lock-in if Deno works"
              "Network-required execution (playground must run offline after build)"
              "Telemetry/analytics by default"))))

    (golden-path
      . ((smoke-test-command
           . ("deno task test"
              "deno task dev  ;; or equivalent local serve"
              ))
         (success-criteria
           . ("Repo builds/runs locally without network calls during execution."
              "At least one example compiles/loads a WASM artifact and runs a function."
              "Examples demonstrate affine resource behavior (use-at-most-once) at the API level."))))

    (artifact-contract
      . ((source-of-wasm
           . ("Preferred: checked-in small demo WASM artifacts"
              "Or: fetch/build via pinned upstream revision (must be reproducible)"))
         (versioning
           . ("If upstream artifacts are referenced, pin commit hashes."))))

    (mandatory-files
      . ("./.machine_read/LLM_SUPERINTENDENT.scm"
         "./.machine_read/SPEC.core.scm"
         "./.machine_read/ROADMAP.f0.scm"))

    (first-pass-directives
      . ("Rewrite any 'Getting Started' text that implies tooling which does not exist in this repo."
         "Add an explicit 'Upstream authority' stanza: upstream repo is source of semantics."
         "Ensure deno.json and rescript.json are the canonical tool entrypoints."
         "Add minimal smoke tests that assert the demo runs and returns expected values."
         "If TypeScript exists, document whether it is generated or glue; reduce it if it grows."))

    (rsr
      . ((target-tier . "bronze-now")
         (upgrade-path . "silver-after-f1 (CI + pinned artifacts + browser E2E test)")))))
