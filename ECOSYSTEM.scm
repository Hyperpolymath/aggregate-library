;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — aggregate-library

(ecosystem
  (version "1.0.0")
  (name "aggregate-library")
  (type "project")
  (purpose "**A Common Library specification shared across radically different programming languages**")

  (position-in-ecosystem
    "Part of hyperpolymath ecosystem. Follows RSR guidelines.")

  (related-projects
    (project (name "rhodium-standard-repositories")
             (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
             (relationship "standard")))

  (what-this-is "**A Common Library specification shared across radically different programming languages**")
  (what-this-is-not "- NOT exempt from RSR compliance"))
