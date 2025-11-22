# Contributing to aggregate-library

Thank you for your interest in contributing to the aggregate-library (aLib) project! This document provides guidelines for contributing to this cross-language Common Library specification.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Contribution Types](#contribution-types)
- [Development Process](#development-process)
- [Specification Guidelines](#specification-guidelines)
- [Pull Request Process](#pull-request-process)
- [TPCF Perimeter](#tpcf-perimeter)
- [Communication](#communication)

## Code of Conduct

This project adheres to a Code of Conduct (see CODE_OF_CONDUCT.md). By participating, you agree to uphold this code. Please report unacceptable behavior to the maintainers.

## Getting Started

### Prerequisites

- Git for version control
- Text editor or IDE
- Familiarity with at least one of the seven target languages
- Understanding of specification writing (helpful but not required)

### Fork and Clone

```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR-USERNAME/aggregate-library.git
cd aggregate-library

# Add upstream remote
git remote add upstream https://github.com/Hyperpolymath/aggregate-library.git
```

### Repository Structure

```
aggregate-library/
├── specs/              # Operation specifications
│   ├── arithmetic/     # Math operations
│   ├── comparison/     # Comparison operations
│   ├── logical/        # Boolean logic
│   ├── string/         # String operations
│   ├── collection/     # Collection operations
│   └── conditional/    # Control flow
├── SPEC_FORMAT.md      # Specification format guide
├── README.md           # Project overview
└── CLAUDE.md           # AI assistant guidelines
```

## Contribution Types

### 1. Specification Improvements

- Clarify ambiguous wording
- Add missing edge cases
- Improve behavioral semantics
- Enhance property descriptions

### 2. Test Case Additions

- Add more comprehensive test cases
- Cover additional edge cases
- Add test cases for different type combinations
- Improve test descriptions

### 3. Documentation

- Improve README or SPEC_FORMAT
- Fix typos and grammar
- Add examples and usage guides
- Translate documentation

### 4. New Operations (Rare)

- Propose new operations for Common Library
- Must exist across ALL seven languages
- Requires community discussion first
- High bar for acceptance

### 5. Bug Reports

- Report specification errors
- Identify inconsistencies
- Document unclear behaviors
- Suggest improvements

## Development Process

### 1. Create an Issue First

Before starting work, create an issue describing:

- What you want to change
- Why it's needed
- Proposed approach

This allows for discussion before you invest time.

### 2. Create a Branch

```bash
# Update your fork
git fetch upstream
git checkout main
git merge upstream/main

# Create feature branch
git checkout -b feat/your-feature-name
```

Use branch prefixes:
- `feat/` - New features or operations
- `fix/` - Bug fixes or corrections
- `docs/` - Documentation changes
- `test/` - Test case additions
- `refactor/` - Restructuring without behavior changes

### 3. Make Changes

Follow the [Specification Guidelines](#specification-guidelines) below.

### 4. Test Your Changes

For specification changes:
- Ensure formatting is consistent
- Verify all links work
- Check YAML syntax in test cases
- Ensure compliance with SPEC_FORMAT.md

### 5. Commit Your Changes

Use conventional commit messages:

```
type(scope): subject

body

footer
```

**Types:**
- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `test`: Test additions
- `refactor`: Code restructuring
- `chore`: Maintenance tasks

**Example:**
```
feat(arithmetic): add edge case for add operation

Added test case for very large number addition to clarify
overflow behavior expectations.

Closes #123
```

### 6. Push and Create Pull Request

```bash
git push origin feat/your-feature-name
```

Then create a pull request on GitHub.

## Specification Guidelines

### Writing Specifications

Follow the format defined in SPEC_FORMAT.md:

1. **Interface Signature**
   - Use abstract, language-agnostic syntax
   - Specify input and output types clearly

2. **Behavioral Semantics**
   - Write clear, unambiguous descriptions
   - Include mathematical properties where applicable
   - Document all edge cases
   - Mark implementation-defined behaviors

3. **Executable Test Cases**
   - Use YAML format
   - Include diverse inputs
   - Cover edge cases
   - Write descriptive test descriptions

### Quality Standards

- **Clarity**: Specifications must be understandable by implementers
- **Completeness**: Cover all important behaviors and edge cases
- **Consistency**: Use consistent terminology across specifications
- **Testability**: Provide concrete, executable test cases
- **Language-Agnostic**: Avoid language-specific assumptions

### What to Avoid

- ❌ Language-specific syntax or terminology
- ❌ Implementation details (memory management, performance)
- ❌ Operations that don't exist in all seven languages
- ❌ Ambiguous or vague descriptions
- ❌ Untestable requirements

## Pull Request Process

### Before Submitting

- [ ] Read SPEC_FORMAT.md
- [ ] Follow specification guidelines
- [ ] Write clear commit messages
- [ ] Reference related issues
- [ ] Self-review your changes
- [ ] Check for typos and formatting

### PR Description Template

```markdown
## Description
[Brief description of changes]

## Motivation
[Why this change is needed]

## Changes
- [List of specific changes]
- [With bullet points]

## Testing
[How you verified the changes]

## Related Issues
Closes #[issue number]

## Checklist
- [ ] Follows SPEC_FORMAT.md
- [ ] Test cases included
- [ ] Documentation updated
- [ ] Commit messages follow conventions
```

### Review Process

1. **Automated Checks**: Must pass (when available)
2. **Maintainer Review**: At least one maintainer approval required
3. **Community Feedback**: Allow time for community input (3-7 days for major changes)
4. **Revisions**: Address reviewer feedback
5. **Merge**: Maintainer will merge when ready

### Review Timeline

- **Minor changes** (typos, formatting): 1-3 days
- **Test additions**: 3-7 days
- **Specification changes**: 1-2 weeks
- **New operations**: 1-3 months (requires extensive discussion)

## TPCF Perimeter

This project follows the Tri-Perimeter Contribution Framework (TPCF):

### Perimeter 3: Community Sandbox (Current Status)

- **Open Contribution**: Anyone may contribute
- **Public Discussion**: All decisions made publicly
- **Transparent Governance**: Clear contribution and review processes
- **Low Barrier**: Easy to get started

As the project matures, we may introduce Perimeter 2 (Trusted Contributors) for core operations.

## Communication

### Where to Discuss

- **GitHub Issues**: Bug reports, feature requests, discussions
- **Pull Requests**: Code review and specification changes
- **Email**: security@[project-domain] for security issues only

### Response Times

We aim to respond within:
- **Security issues**: 72 hours
- **Bug reports**: 1 week
- **Feature requests**: 2 weeks
- **Pull requests**: 1 week for initial review

### Getting Help

- Read SPEC_FORMAT.md and existing specifications
- Search existing issues and PRs
- Create a new issue if you can't find answers
- Be patient and respectful

## Recognition

Contributors are recognized in multiple ways:

- Listed in MAINTAINERS.md (for significant contributions)
- Mentioned in CHANGELOG.md
- Credited in release notes
- Acknowledged in `.well-known/humans.txt`

## License

By contributing, you agree that your contributions will be licensed under the project's dual license (MIT / Palimpsest v0.8). See LICENSE.txt for details.

## Questions?

If you have questions about contributing, please:

1. Read this guide thoroughly
2. Check existing issues and discussions
3. Create a new issue with the `question` label
4. Be patient and respectful

Thank you for contributing to aggregate-library! 🎉

---

Last updated: 2025-11-22
