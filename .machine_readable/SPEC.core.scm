;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPEC.core.scm - Core specification for the AffineScript Playground

(define spec-core
  '((schema . "hyperpolymath.spec/1")
    (repo . "hyperpolymath/affinescript-playground")
    (updated . "2026-01-01")

    (project-definition
      . ((name . "AffineScript Playground")
         (purpose . "Web playground and demo suite for AffineScript")
         (scope . "UI, WASM interop, demonstrations of affine resource semantics")))

    (upstream-dependency
      . ((repo . "hyperpolymath/affinescript")
         (relationship . "consumer")
         (artifacts-consumed
           . ("Compiled WASM modules"
              "Runtime library"
              "Conformance test specifications"))
         (artifacts-NOT-produced
           . ("Language parser"
              "Type checker"
              "Compiler passes"))))

    (core-concepts
      . ((affine-resources
           . ((definition . "Values that can be used at most once")
              (playground-role . "Demonstrate affine behavior via examples")))
         (wasm-interop
           . ((definition . "Loading and calling WASM from JavaScript/ReScript")
              (playground-role . "Provide ergonomic bindings and visualization")))
         (offline-first
           . ((definition . "All execution must work without network after build")
              (playground-role . "Enable local development and demos")))))

    (interface-contracts
      . ((wasm-loader
           . ((input . "WASM binary artifact")
              (output . "Callable module instance")
              (constraint . "Must not require network at runtime")))
         (demo-runner
           . ((input . "Example source + precompiled WASM")
              (output . "Execution result + visualization")
              (constraint . "Must show affine semantics in action")))
         (playground-ui
           . ((input . "User code or example selection")
              (output . "Compiled result or error message")
              (constraint . "Clear indication of affine violations")))))

    (quality-attributes
      . ((reproducibility . "Pinned dependencies, deterministic builds")
         (simplicity . "Minimal dependencies, prefer Deno over npm")
         (clarity . "Examples must clearly demonstrate affine concepts")
         (offline-capability . "No network calls during execution")))))
