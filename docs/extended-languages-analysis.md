# Extended Languages Analysis

## Adding 4 New Languages to the Common Library

This document analyzes how the 4 new language implementations map to the 20 core operations.

## Language Paradigm Summary

| Language | Type System | Key Feature | Paradigm |
|----------|-------------|-------------|----------|
| **AffineScript** | Affine types | Use-at-most-once | Functional with ownership |
| **Ephapax** | Linear types | Use-exactly-once | Linear logic |
| **BetLang** | Probabilistic | Distributions as values | Probabilistic programming |
| **Anvomidav** | Reversible | Bijective operations | Reversible computing |

---

## Operation Analysis by Language

### AffineScript (Affine Types)

**Philosophy**: Resources can be used at most once, enabling compile-time resource management.

| Category | Operation | Supported | Notes |
|----------|-----------|-----------|-------|
| Arithmetic | add | ✅ | Consumes both operands, produces fresh result |
| Arithmetic | subtract | ✅ | Consumes both operands |
| Arithmetic | multiply | ✅ | Consumes both operands |
| Arithmetic | divide | ✅ | Consumes both operands, may produce error type |
| Arithmetic | modulo | ✅ | Consumes both operands |
| Comparison | less_than | ✅ | Borrows operands (non-consuming) |
| Comparison | greater_than | ✅ | Borrows operands |
| Comparison | equal | ✅ | Borrows operands |
| Comparison | not_equal | ✅ | Borrows operands |
| Comparison | less_equal | ✅ | Borrows operands |
| Comparison | greater_equal | ✅ | Borrows operands |
| Logical | and | ✅ | Short-circuit, affine-safe |
| Logical | or | ✅ | Short-circuit, affine-safe |
| Logical | not | ✅ | Consumes operand |
| String | concat | ✅ | Consumes both strings, produces new |
| String | length | ✅ | Borrows string |
| String | substring | ✅ | Borrows original, produces new substring |
| Collection | map | ✅ | Consumes collection, produces new |
| Collection | filter | ✅ | Consumes collection |
| Collection | fold | ✅ | Consumes collection and accumulator |
| Collection | contains | ✅ | Borrows collection |
| Conditional | if_then_else | ✅ | Branches must have compatible affine types |

**Result**: **20/20 operations supported**

**AffineScript-specific considerations**:
```
// Affine: values can be used at most once
let x = 5
let y = add(x, 3)  // x is consumed
// let z = x + 1   // ERROR: x already consumed

// Borrowing for comparisons
let a = 10
if less_than(&a, &20) {  // borrows a, doesn't consume
    let b = add(a, 5)    // a still available, now consumed
}
```

---

### Ephapax (Linear Types)

**Philosophy**: Every resource must be used exactly once - no more, no less.

| Category | Operation | Supported | Notes |
|----------|-----------|-----------|-------|
| Arithmetic | add | ✅ | Both operands must be consumed exactly once |
| Arithmetic | subtract | ✅ | Linear consumption |
| Arithmetic | multiply | ✅ | Linear consumption |
| Arithmetic | divide | ⚠️ | Must handle error case (uses Either type) |
| Arithmetic | modulo | ⚠️ | Must handle zero case |
| Comparison | less_than | ⚠️ | Returns (Bool, a, b) - operands returned |
| Comparison | greater_than | ⚠️ | Returns tuple with operands |
| Comparison | equal | ⚠️ | Returns tuple with operands |
| Comparison | not_equal | ⚠️ | Returns tuple with operands |
| Comparison | less_equal | ⚠️ | Returns tuple with operands |
| Comparison | greater_equal | ⚠️ | Returns tuple with operands |
| Logical | and | ✅ | Linear, both branches evaluated linearly |
| Logical | or | ✅ | Linear disjunction |
| Logical | not | ✅ | Linear negation |
| String | concat | ✅ | Both strings consumed, new string produced |
| String | length | ⚠️ | Returns (Int, String) - string returned |
| String | substring | ⚠️ | Returns (String, String) - original returned |
| Collection | map | ✅ | Collection consumed, new produced |
| Collection | filter | ✅ | Collection consumed |
| Collection | fold | ✅ | Collection and accumulator consumed |
| Collection | contains | ⚠️ | Returns (Bool, Collection) |
| Conditional | if_then_else | ✅ | Both branches must consume linearly |

**Result**: **20/20 operations supported** (with linear adaptations)

**Ephapax-specific considerations**:
```
// Linear: values must be used exactly once
let x = 5
let y = add(x, 3)  // x consumed
// Cannot ignore x, cannot reuse x

// Comparisons return operands
let (result, a', b') = less_than(a, b)
// a' and b' must still be used exactly once
```

---

### BetLang (Probabilistic Programming)

**Philosophy**: First-class probability distributions and Bayesian inference.

| Category | Operation | Supported | Notes |
|----------|-----------|-----------|-------|
| Arithmetic | add | ✅ | Works on distributions: add(D1, D2) → D3 |
| Arithmetic | subtract | ✅ | Distribution subtraction |
| Arithmetic | multiply | ✅ | Distribution multiplication |
| Arithmetic | divide | ✅ | Distribution division |
| Arithmetic | modulo | ✅ | Distribution modulo |
| Comparison | less_than | ✅ | Returns P(a < b) as probability |
| Comparison | greater_than | ✅ | Returns probability |
| Comparison | equal | ✅ | Returns probability (often 0 for continuous) |
| Comparison | not_equal | ✅ | Returns probability |
| Comparison | less_equal | ✅ | Returns probability |
| Comparison | greater_equal | ✅ | Returns probability |
| Logical | and | ✅ | Probabilistic conjunction |
| Logical | or | ✅ | Probabilistic disjunction |
| Logical | not | ✅ | P(not A) = 1 - P(A) |
| String | concat | ✅ | Deterministic string ops |
| String | length | ✅ | Deterministic |
| String | substring | ✅ | Deterministic |
| Collection | map | ✅ | Maps over distribution samples |
| Collection | filter | ✅ | Conditional distributions |
| Collection | fold | ✅ | Aggregation over distributions |
| Collection | contains | ✅ | Probabilistic membership |
| Conditional | if_then_else | ✅ | Mixture distributions |

**Result**: **20/20 operations supported**

**BetLang-specific considerations**:
```
// Probabilistic values
let x ~ Normal(0, 1)      // x is a distribution
let y ~ Normal(5, 2)
let z = add(x, y)         // z ~ Normal(5, sqrt(5))

// Comparisons return probabilities
let p = less_than(x, y)   // P(x < y) ≈ 0.987

// Conditional creates mixture
let result = if_then_else(
    flip(0.3),            // 30% chance
    x,                    // then branch
    y                     // else branch
)  // result is mixture distribution
```

---

### Anvomidav (Reversible Computing)

**Philosophy**: Every operation is bijective and can be reversed.

| Category | Operation | Supported | Notes |
|----------|-----------|-----------|-------|
| Arithmetic | add | ✅ | add(a, b, 0) ↔ (a, b, a+b), reversible with ancilla |
| Arithmetic | subtract | ✅ | Reversible with ancilla |
| Arithmetic | multiply | ⚠️ | Requires non-zero constraint or ancilla |
| Arithmetic | divide | ⚠️ | Only reversible for exact division |
| Arithmetic | modulo | ⚠️ | Reversible with quotient as ancilla |
| Comparison | less_than | ✅ | Returns (a, b, result), fully reversible |
| Comparison | greater_than | ✅ | Reversible |
| Comparison | equal | ✅ | Reversible |
| Comparison | not_equal | ✅ | Reversible |
| Comparison | less_equal | ✅ | Reversible |
| Comparison | greater_equal | ✅ | Reversible |
| Logical | and | ✅ | Toffoli gate: AND with ancilla |
| Logical | or | ✅ | Reversible via De Morgan |
| Logical | not | ✅ | Self-inverse (NOT ∘ NOT = id) |
| String | concat | ⚠️ | Reversible only with length ancilla |
| String | length | ⚠️ | Read-only, needs careful handling |
| String | substring | ⚠️ | Reversible with indices as ancilla |
| Collection | map | ✅ | Reversible if function is reversible |
| Collection | filter | ❌ | NOT reversible (information loss) |
| Collection | fold | ⚠️ | Reversible only with unfold inverse |
| Collection | contains | ⚠️ | Read-only query, reversible with ancilla |
| Conditional | if_then_else | ✅ | Reversible conditional (Fredkin-like) |

**Result**: **19/20 operations supported** (filter is problematic)

**Anvomidav-specific considerations**:
```
// All operations preserve information
reversible add(a, b, c) {
    c ^= a + b    // XOR-accumulate
}
// Reverse: c ^= a + b again (XOR is self-inverse)

// Filter loses information - NOT directly supported
// Alternative: partition (keeps both halves)
reversible partition(list, pred) -> (matching, non_matching)

// Conditional preserves both branches' existence
reversible if_then_else(cond, x, y) {
    // Fredkin gate: swap x,y controlled by cond
}
```

---

## Extended Common Library Summary

### Operations Across All 11 Languages

| Operation | Original 7 | AffineScript | Ephapax | BetLang | Anvomidav | **All 11** |
|-----------|------------|--------------|---------|---------|-----------|------------|
| add | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| subtract | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| multiply | ✅ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ |
| divide | ✅ | ✅ | ⚠️ | ✅ | ⚠️ | ⚠️ |
| modulo | ✅ | ✅ | ⚠️ | ✅ | ⚠️ | ⚠️ |
| less_than | ✅ | ✅ | ⚠️ | ✅ | ✅ | ⚠️ |
| greater_than | ✅ | ✅ | ⚠️ | ✅ | ✅ | ⚠️ |
| equal | ✅ | ✅ | ⚠️ | ✅ | ✅ | ⚠️ |
| not_equal | ✅ | ✅ | ⚠️ | ✅ | ✅ | ⚠️ |
| less_equal | ✅ | ✅ | ⚠️ | ✅ | ✅ | ⚠️ |
| greater_equal | ✅ | ✅ | ⚠️ | ✅ | ✅ | ⚠️ |
| and | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| or | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| not | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| concat | ✅ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ |
| length | ✅ | ✅ | ⚠️ | ✅ | ⚠️ | ⚠️ |
| substring | ✅ | ✅ | ⚠️ | ✅ | ⚠️ | ⚠️ |
| map | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| filter | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| fold | ✅ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ |
| contains | ✅ | ✅ | ⚠️ | ✅ | ⚠️ | ⚠️ |
| if_then_else | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

**Legend**:
- ✅ = Fully supported
- ⚠️ = Supported with adaptations (different signature or constraints)
- ❌ = Not supported in standard form

---

## Revised Common Library (11 Languages)

### Tier 1: Universal Operations (7 operations)
These work identically across all 11 languages:

1. **add** - Addition
2. **subtract** - Subtraction
3. **and** - Logical conjunction
4. **or** - Logical disjunction
5. **not** - Logical negation
6. **map** - Transform collection elements
7. **if_then_else** - Conditional branching

### Tier 2: Adapted Operations (12 operations)
These require language-specific adaptations but are semantically equivalent:

8. **multiply** - (Anvomidav: requires non-zero or ancilla)
9. **divide** - (Ephapax: returns Either; Anvomidav: exact only)
10. **modulo** - (Similar constraints to divide)
11. **less_than** - (Ephapax: returns tuple; BetLang: returns probability)
12. **greater_than** - (Same adaptations)
13. **equal** - (Same adaptations)
14. **not_equal** - (Same adaptations)
15. **less_equal** - (Same adaptations)
16. **greater_equal** - (Same adaptations)
17. **concat** - (Anvomidav: needs length ancilla)
18. **length** - (Ephapax: returns tuple)
19. **substring** - (Multiple adaptations)
20. **fold** - (Anvomidav: needs unfold inverse)
21. **contains** - (Ephapax: returns tuple)

### Tier 3: Excluded Operations (1 operation)
These cannot be universally supported:

- **filter** - Information-destroying, incompatible with reversible computing
  - **Alternative**: `partition` (returns both matching and non-matching)

---

## Conclusion

Adding the 4 new languages (AffineScript, Ephapax, BetLang, Anvomidav) reduces the "pure" Common Library from 20 to **7 universal operations**, with **12 operations requiring adaptations** and **1 operation (filter) excluded** due to Anvomidav's reversibility constraint.

### Recommendations

1. **Keep 20 operations** in the Common Library specification
2. **Document adaptations** per language in language-specific appendices
3. **Add `partition`** as an alternative to `filter` for reversible contexts
4. **Create compliance levels**:
   - **Level A**: All 20 operations (7 original languages + AffineScript + BetLang)
   - **Level B**: 19 operations + adaptations (Ephapax, Anvomidav)
