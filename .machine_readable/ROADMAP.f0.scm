;; SPDX-License-Identifier: AGPL-3.0-or-later
;; ROADMAP.f0.scm - First pass (f0) roadmap for AffineScript Playground

(define roadmap-f0
  '((schema . "hyperpolymath.roadmap/1")
    (repo . "hyperpolymath/affinescript-playground")
    (updated . "2026-01-01")
    (phase . "f0-control-pass")

    (objective
      . "Establish scope boundaries and minimal working demonstration")

    (status . "in-progress")

    (f0-deliverables
      . ((scope-arrest
           . ((status . "complete")
              (artifact . "ANCHOR.scope-arrest.2026-01-01.Jewell.scm")
              (purpose . "Prevent scope creep into compiler territory")))

         (machine-readable-config
           . ((status . "complete")
              (artifacts
                . ("LLM_SUPERINTENDENT.scm"
                   "SPEC.core.scm"
                   "ROADMAP.f0.scm"))
              (purpose . "Enable AI agents to understand repo constraints")))

         (canonical-entrypoints
           . ((status . "pending")
              (artifacts . ("deno.json" "rescript.json"))
              (purpose . "Single source of truth for build/dev commands")))

         (smoke-test
           . ((status . "pending")
              (command . "deno task test")
              (success-criteria
                . ("Runs without network"
                   "Loads at least one WASM artifact"
                   "Demonstrates affine resource behavior"))))

         (demo-artifact
           . ((status . "pending")
              (requirement . "One checked-in WASM file or pinned upstream ref")
              (purpose . "Reproducible demonstration without build step")))))

    (f0-constraints
      . ("No new TypeScript files (use ReScript)"
         "No npm package-lock.json (use Deno)"
         "No parser/compiler code (upstream only)"
         "All execution paths must work offline"))

    (success-criteria
      . ((minimum
           . ("ANCHOR file in place"
              "Machine-read files created"
              "deno task test passes"))
         (target
           . ("One working demo with WASM"
              "Clear upstream authority documentation"
              "ReScript-based playground skeleton"))))

    (next-phase
      . ((name . "f1-bronze")
         (prerequisites . ("f0 complete" "smoke test green"))
         (planned-work
           . ("CI pipeline"
              "Pinned upstream artifact fetching"
              "Basic playground UI"))))))
