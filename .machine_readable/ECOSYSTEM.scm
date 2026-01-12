;; SPDX-License-Identifier: AGPL-3.0-or-later
;; ECOSYSTEM.scm - Ecosystem position for aggregate-library
;; Media-Type: application/vnd.ecosystem+scm

(ecosystem
  (version "1.0")
  (name "aggregate-library")
  (type "specification")
  (purpose "Define minimal Common Library operations shared across radically different programming languages")

  (position-in-ecosystem
    (category "language-design")
    (subcategory "cross-language-specification")
    (unique-value
      ("Defines universal operations across 7 diverse paradigms"
       "Language-agnostic behavioral specifications"
       "Executable test cases for compliance verification")))

  (related-projects
    ;; Reference implementations and verification
    ((name . "proven")
     (repo . "github.com/hyperpolymath/proven")
     (relationship . "reference-implementation")
     (description . "Idris 2 verified safety library - provides formally verified implementations of aLib operations")
     (integration-notes
       ("proven's SafeMath implements aLib arithmetic with overflow protection"
        "proven's SafeString implements aLib string ops with UTF-8 safety"
        "All proven operations have termination proofs (totality)"
        "Use proven as gold standard for correctness verification")))

    ;; The seven target languages
    ((name . "wokelang")
     (relationship . "target-language")
     (description . "Consent-driven, emotional computing"))
    ((name . "duet-ensemble")
     (relationship . "target-language")
     (description . "AI-first, session types, effect systems"))
    ((name . "eclexia")
     (relationship . "target-language")
     (description . "Sustainability-focused, energy budgets"))
    ((name . "oblibeny")
     (relationship . "target-language")
     (description . "Security-first, provable termination"))
    ((name . "rt-lang")
     (relationship . "target-language")
     (description . "Real-time systems, dependent types"))
    ((name . "phronesis")
     (relationship . "target-language")
     (description . "Ethical reasoning, values-based"))
    ((name . "julia-the-viper")
     (relationship . "target-language")
     (description . "Reversible computing, totality")))

  (what-this-is
    ("Specification of 20 core operations across 6 categories"
     "Interface signatures independent of language syntax"
     "Behavioral semantics with mathematical properties"
     "Executable test cases in YAML format"
     "Foundation for cross-language interoperability"))

  (what-this-is-not
    ("Not a programming language implementation"
     "Not a runtime or execution engine"
     "Does not include I/O, concurrency, or error handling"
     "Does not specify memory management or type systems")))
