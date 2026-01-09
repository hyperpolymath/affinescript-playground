;; SPDX-License-Identifier: AGPL-3.0-or-later
;; PLAYBOOK.scm - Operational runbook for affinescript-playground

(define playbook
  `((version . "1.0.0")
    (procedures
      ((deploy . (("check" . "just check")
                  ("build" . "just build")
                  ("test" . "just test")
                  ("verify-rsr" . "just verify")))
       (rollback . (("revert-commit" . "git revert HEAD")
                    ("restore-tag" . "git checkout tags/<version>")
                    ("verify-state" . "just test")))
       (debug . (("check-affine-violations" . "just check-affine")
                 ("analyze-wasm" . "just analyze-wasm")
                 ("verbose-test" . "just test-verbose")
                 ("inspect-state" . "cat .machine_readable/STATE.scm")))))
    (alerts
      ((test-failure . "Test suite failed - check deno test output")
       (lint-error . "Linting errors detected - run just fmt")
       (affine-violation . "Affine type violation in runtime - resource double-consumed")
       (rsr-violation . "RSR compliance check failed - verify required files")))
    (contacts
      ((maintainer . "hyperpolymath")
       (security . "See SECURITY.md for vulnerability reporting")
       (issues . "https://github.com/hyperpolymath/affinescript-playground/issues")))))
