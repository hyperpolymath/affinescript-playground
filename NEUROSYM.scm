;; SPDX-License-Identifier: AGPL-3.0-or-later
;; NEUROSYM.scm - Neurosymbolic integration config

(define neurosym-config
  `((version . "1.0.0")
    (project . "affinescript-playground")
    (symbolic-layer
      ((type . "scheme")
       (reasoning . "deductive")
       (verification . "formal")
       (language-specific
         ((type-system . "affine")
          (grammar . "ebnf-defined")
          (semantics . "operational")))))
    (neural-layer
      ((embeddings . #f)
       (fine-tuning . #f)
       (inference . #f)))
    (integration
      ((ai-assisted-development . "duet-style")
       (type-inference-hints . #t)))))
