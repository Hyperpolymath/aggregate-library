;; SPDX-License-Identifier: PMPL-1.0
;; STATE.scm - Current project state

(define project-state
  `((metadata
      ((version . "1.0.0")
       (schema-version . "1")
       (created . "2026-01-10T13:47:43+00:00")
       (updated . "2026-01-18T00:00:00+00:00")  ;; update when you edit
       (project . "aggregate-library")
       (repo . "hyperpolymath/aggregate-library")))

    (current-position
      ((phase . "Methods Lab")
       (overall-completion . 60)
       (working-features
         ("README framing: methods repo, not stdlib replacement"
          "Basic repository scaffolding (v1.0 tag present)"))))

    (intent
      ((primary
         "Demonstrate the aLib method: define minimal overlap surfaces, document semantics, and validate via conformance tests under stress.")
       (secondary
         "Provide a stable reference point for ecosystem-specific implementations (e.g., ReScript/Melange), without becoming a required dependency.")))

    (ecosystem-notes
      ((reference-implementations
         ("proven: reference point for formally verified semantics and test intent"))
       (implementation-repos
         ("alib-for-rescript: practical ecosystem proving ground and adapters"))))

    (route-to-mvp
      ((milestones
        ((v1.0
           ((items . ("Initial setup"
                      "Publish methods framing (README)"
                      "Add initial spec + semantics placeholders"
                      "Add initial conformance test harness placeholders"))
            (status . "complete")))

         (v1.1
           ((items . ("Add first real spec slice (tiny overlap surface)"
                      "Add conformance vectors for that slice"
                      "Add at least one runner harness"))
            (status . "planned")))

         (v1.2
           ((items . ("Document how implementation repos should consume method (without importing code)"
                      "Add guidance on reversibility / rollback discipline"))
            (status . "planned")))))))

    (blockers-and-issues
      ((critical . ())
       (high . ())
       (medium . ())
       (low . ())))

    (critical-next-actions
      ((immediate
         ("Replace placeholder SCM text with full ecosystem mapping and state (this file)"
          "Add SPEC/ and tests/ skeleton aligned to README"))
       (this-week
         ("Define first overlap surface and write conformance vectors"
          "Add runner harness for at least one environment"))
       (this-month
         ("Write 'Two meanings of Common' explainer with examples"
          "Publish link-out guidance for ecosystem implementations"))))

    (session-history . ())))
