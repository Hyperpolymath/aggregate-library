;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm - Project Ecosystem Relationships
;; aggregate-library
;; Reference: https://github.com/hyperpolymath/ECOSYSTEM.scm

(ecosystem
  (version "1.0.0")
  (name "aggregate-library")
  (type "library")
  (purpose "**A Common Library specification shared across radically different programming languages**")

  (satellite-of
    (parent "nextgen-languages")
    (parent-url "https://github.com/hyperpolymath/nextgen-languages")
    (role "Core specification defining the 20 common operations across all language implementations"))

  (position-in-ecosystem
    "Satellite of nextgen-languages meta-repository.
     Part of the hyperpolymath ecosystem of tools, libraries, and specifications.
     Follows RSR (Rhodium Standard Repositories) guidelines for consistency,
     security, and maintainability. Integrated with multi-platform CI/CD
     (GitHub, GitLab, Bitbucket) and OpenSSF Scorecard compliance.")

  (related-projects
    (project
      (name "nextgen-languages")
      (url "https://github.com/hyperpolymath/nextgen-languages")
      (relationship "parent")
      (description "Meta-repository coordinating nextgen language ecosystem")
      (differentiation
        "nextgen-languages = Parent/coordinator for all language projects
         aggregate-library = Satellite providing common specification"))

    (project
      (name "hyperpolymath-ecosystem")
      (url "https://github.com/hyperpolymath")
      (relationship "ecosystem")
      (description "Part of the hyperpolymath project ecosystem")
      (differentiation
        "Individual project within a larger cohesive ecosystem"))

    (project
      (name "rhodium-standard-repositories")
      (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
      (relationship "standard")
      (description "RSR compliance guidelines this project follows")
      (differentiation
        "RSR = Standards and templates
         This project = Implementation following those standards"))

    (project
      (name "META.scm")
      (url "https://github.com/hyperpolymath/META.scm")
      (relationship "sibling-standard")
      (description "Machine-readable Engineering and Technical Architecture format")
      (differentiation
        "META.scm = Architecture decisions format
         ECOSYSTEM.scm = Project relationship format"))

    (project
      (name "state.scm")
      (url "https://github.com/hyperpolymath/state.scm")
      (relationship "sibling-standard")
      (description "Stateful Context Tracking Engine for AI Conversation Continuity")
      (differentiation
        "STATE.scm = Session/conversation persistence format
         ECOSYSTEM.scm = Project relationship format"))

    (project
      (name "affinescript")
      (url "https://github.com/hyperpolymath/affinescript")
      (relationship "language-implementation")
      (description "Programming language with affine type semantics")
      (differentiation
        "AffineScript = Language with affine types for resource safety
         aggregate-library = Common specification across languages"))

    (project
      (name "ephapax")
      (url "https://github.com/hyperpolymath/ephapax")
      (relationship "language-implementation")
      (description "Once-only evaluation language with linear type semantics")
      (differentiation
        "Ephapax = Language with linear types for single-use values
         aggregate-library = Common specification across languages"))

    (project
      (name "betlang")
      (url "https://github.com/hyperpolymath/betlang")
      (relationship "language-implementation")
      (description "Language for probabilistic programming and reasoning under uncertainty")
      (differentiation
        "BetLang = Language for probabilistic computation
         aggregate-library = Common specification across languages"))

    (project
      (name "anvomidav")
      (url "https://github.com/hyperpolymath/anvomidav")
      (relationship "language-implementation")
      (description "Reversible computing language")
      (differentiation
        "Anvomidav = Language for reversible computation
         aggregate-library = Common specification across languages")))

  (what-this-is
    "**A Common Library specification shared across radically different programming languages**

     Design principles:
     - RSR Gold compliance target
     - Multi-platform CI/CD (GitHub, GitLab, Bitbucket)
     - SHA-pinned GitHub Actions for security
     - SPDX license headers on all files
     - OpenSSF Scorecard compliance")

  (what-this-is-not
    "- NOT a standalone tool without ecosystem integration
     - NOT exempt from RSR compliance requirements
     - NOT designed for incompatible license frameworks
     - NOT maintained outside the hyperpolymath ecosystem"))

;;; End of ECOSYSTEM.scm
