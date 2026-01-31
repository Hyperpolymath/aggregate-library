// SPDX-License-Identifier: PMPL-1.0-or-later
// Spec validator for aggregate-library (aLib)
// Validates that all specification files follow the required format

import { walk } from "@std/fs/walk";
import { join, relative } from "@std/path";

interface ValidationResult {
  file: string;
  valid: boolean;
  errors: string[];
  warnings: string[];
}

interface SpecMetadata {
  file: string;
  operation: string;
  category: string;
  hasSignature: boolean;
  hasSemantics: boolean;
  hasTests: boolean;
  testCount: number;
}

const REQUIRED_SECTIONS = [
  "## Interface Signature",
  "## Behavioral Semantics",
  "## Executable Test Cases",
];

const RECOMMENDED_FIELDS = [
  "**Purpose**:",
  "**Parameters**:",
  "**Return Value**:",
];

async function validateSpec(filePath: string): Promise<ValidationResult> {
  const errors: string[] = [];
  const warnings: string[] = [];

  try {
    const content = await Deno.readTextFile(filePath);

    // Check for required sections
    for (const section of REQUIRED_SECTIONS) {
      if (!content.includes(section)) {
        errors.push(`Missing required section: ${section}`);
      }
    }

    // Check for recommended fields in Behavioral Semantics
    if (content.includes("## Behavioral Semantics")) {
      for (const field of RECOMMENDED_FIELDS) {
        if (!content.includes(field)) {
          warnings.push(`Missing recommended field: ${field}`);
        }
      }
    }

    // Check for test cases format
    if (content.includes("## Executable Test Cases")) {
      const yamlMatch = content.match(/```yaml\s+([\s\S]*?)```/);
      if (!yamlMatch) {
        errors.push("Test cases section missing YAML code block");
      } else {
        const yamlContent = yamlMatch[1];
        if (!yamlContent.includes("test_cases:")) {
          errors.push("YAML block missing 'test_cases:' key");
        }

        // Count test cases
        const testMatches = yamlContent.match(/- input:/g);
        const testCount = testMatches ? testMatches.length : 0;

        if (testCount === 0) {
          errors.push("No test cases found");
        } else if (testCount < 3) {
          warnings.push(`Only ${testCount} test case(s) - recommend at least 3`);
        }
      }
    }

    // Check for interface signature format
    if (content.includes("## Interface Signature")) {
      const sigMatch = content.match(/```\s*\n([^`]+?)```/);
      if (!sigMatch) {
        errors.push("Interface Signature missing code block");
      } else {
        const signature = sigMatch[1].trim();
        if (!signature.includes(":") || !signature.includes("->")) {
          warnings.push("Interface signature should use format: operation: Type1, Type2 -> ReturnType");
        }
      }
    }

    return {
      file: filePath,
      valid: errors.length === 0,
      errors,
      warnings,
    };
  } catch (error) {
    return {
      file: filePath,
      valid: false,
      errors: [`Failed to read file: ${error.message}`],
      warnings: [],
    };
  }
}

async function getSpecMetadata(filePath: string): Promise<SpecMetadata | null> {
  try {
    const content = await Deno.readTextFile(filePath);
    const relativePath = relative(Deno.cwd(), filePath);
    const parts = relativePath.split("/");

    // Extract operation name from filename
    const filename = parts[parts.length - 1];
    const operation = filename.replace(".md", "");

    // Extract category from directory
    const category = parts[parts.length - 2];

    // Count test cases
    const yamlMatch = content.match(/```yaml\s+([\s\S]*?)```/);
    const testCount = yamlMatch
      ? (yamlMatch[1].match(/- input:/g) || []).length
      : 0;

    return {
      file: relativePath,
      operation,
      category,
      hasSignature: content.includes("## Interface Signature"),
      hasSemantics: content.includes("## Behavioral Semantics"),
      hasTests: content.includes("## Executable Test Cases"),
      testCount,
    };
  } catch {
    return null;
  }
}

async function main() {
  console.log("🔍 Validating aggregate-library specifications...\n");

  const specsDir = join(Deno.cwd(), "specs");
  const results: ValidationResult[] = [];
  const metadata: SpecMetadata[] = [];

  // Find all .md files in specs/ directory
  for await (const entry of walk(specsDir, { exts: [".md"] })) {
    if (entry.isFile) {
      const result = await validateSpec(entry.path);
      results.push(result);

      const meta = await getSpecMetadata(entry.path);
      if (meta) {
        metadata.push(meta);
      }
    }
  }

  // Sort results by file path
  results.sort((a, b) => a.file.localeCompare(b.file));

  // Display results
  let validCount = 0;
  let errorCount = 0;
  let warningCount = 0;

  for (const result of results) {
    const relPath = relative(Deno.cwd(), result.file);

    if (result.valid) {
      console.log(`✅ ${relPath}`);
      validCount++;
    } else {
      console.log(`❌ ${relPath}`);
      errorCount++;
    }

    if (result.errors.length > 0) {
      for (const error of result.errors) {
        console.log(`   ERROR: ${error}`);
      }
    }

    if (result.warnings.length > 0) {
      warningCount += result.warnings.length;
      for (const warning of result.warnings) {
        console.log(`   WARNING: ${warning}`);
      }
    }
  }

  // Summary statistics
  console.log("\n" + "=".repeat(60));
  console.log("📊 Validation Summary");
  console.log("=".repeat(60));
  console.log(`Total specifications: ${results.length}`);
  console.log(`Valid: ${validCount} ✅`);
  console.log(`Invalid: ${errorCount} ❌`);
  console.log(`Warnings: ${warningCount} ⚠️`);

  // Category breakdown
  console.log("\n" + "=".repeat(60));
  console.log("📁 Specifications by Category");
  console.log("=".repeat(60));

  const categories = new Map<string, SpecMetadata[]>();
  for (const spec of metadata) {
    if (!categories.has(spec.category)) {
      categories.set(spec.category, []);
    }
    categories.get(spec.category)!.push(spec);
  }

  for (const [category, specs] of Array.from(categories.entries()).sort()) {
    console.log(`\n${category}/ (${specs.length} operations)`);
    for (const spec of specs.sort((a, b) => a.operation.localeCompare(b.operation))) {
      const status = spec.hasSignature && spec.hasSemantics && spec.hasTests ? "✅" : "⚠️";
      console.log(`  ${status} ${spec.operation} (${spec.testCount} tests)`);
    }
  }

  // Total test cases
  const totalTests = metadata.reduce((sum, spec) => sum + spec.testCount, 0);
  console.log("\n" + "=".repeat(60));
  console.log(`Total test cases across all specs: ${totalTests}`);
  console.log("=".repeat(60));

  // Exit with error if any specs are invalid
  if (errorCount > 0) {
    console.error(`\n❌ Validation failed: ${errorCount} specification(s) have errors`);
    Deno.exit(1);
  }

  console.log("\n✅ All specifications are valid!");
  Deno.exit(0);
}

if (import.meta.main) {
  main();
}
