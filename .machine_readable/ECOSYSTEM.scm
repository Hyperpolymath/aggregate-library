;; SPDX-License-Identifier: PMPL-1.0-or-later
;; ECOSYSTEM.scm - Project relationship mapping
;;
;; This file describes how this repo relates to other repos in the ecosystem.
;; It is not a build artifact and is intentionally human-readable.

(ecosystem
  (version "1.0")
  (name "aggregate-library")
  (type "project")

  (purpose
    "Methods and stress-test lab for aLib: demonstrate how to define a minimal overlap surface, specify semantics, and validate behavior via conformance tests — without proposing any ecosystem replace its standard library.")

  (position-in-ecosystem
    (role "methods-lab")
    (layer "design-and-validation")
    (description
      "This repo exists to stress-test the aLib method under extreme diversity. It is intentionally allowed to be weird and extreme so ideas break early, not downstream."))

  ;; Relationship list is intentionally descriptive rather than prescriptive.
  ;; This repo should not become a dependency magnet.
  (related-projects
    ((project
       (name "proven")
       (repo "https://github.com/hyperpolymath/proven")
       (relationship "reference-implementation")
       (why
         "Proven demonstrates a formally verified approach to parts of the aLib method, serving as a reference point for semantics and tests. It is not required by this repo."))

     (project
       (name "alib-for-rescript")
       (repo "https://github.com/hyperpolymath/alib-for-rescript")
       (relationship "ecosystem-implementation")
       (why
         "A practical ReScript/Melange-oriented proving ground that applies the aLib method (clear boundaries + tests + reversibility) to real ecosystem needs, optionally integrating Proven ideas where they help."))))

  (what-this-is
    "A methods repository: a stress-test and demonstration of how to build a minimal overlap library safely using specification, semantics notes, and conformance tests.")

  (what-this-is-not
    ("Not a replacement standard library."
     "Not a proposal that all ecosystems should share one stdlib."
     "Not a dependency that implementation repos must import."
     "Not a claim that this repo's overlap is the correct overlap for any specific ecosystem.")))
