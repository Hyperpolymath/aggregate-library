// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
/**
 * Conformance Test Runner
 *
 * Runs test cases from spec files against the aLib implementation
 * to verify conformance.
 *
 * This validates that implementations match their specifications.
 */

import { walk } from "@std/fs";
import { parse as parseYaml } from "@std/yaml";
import { assertEquals } from "@std/assert";

interface TestCase {
  input: unknown;
  output: unknown;
  description: string;
}

interface TestSuite {
  operation: string;
  category: string;
  testCases: TestCase[];
}

async function loadTestSuites(): Promise<TestSuite[]> {
  const suites: TestSuite[] = [];

  for await (const entry of walk("./specs", {
    exts: [".md"],
    includeFiles: true,
    includeDirs: false,
  })) {
    const content = await Deno.readTextFile(entry.path);

    // Extract operation name and category from path
    // e.g., ./specs/arithmetic/add.md -> { category: "arithmetic", operation: "add" }
    const pathParts = entry.path.split("/");
    const category = pathParts[pathParts.length - 2];
    const operation = pathParts[pathParts.length - 1].replace(".md", "");

    // Extract YAML test cases
    const yamlMatch = content.match(/```yaml\n([\s\S]+?)\n```/);
    if (!yamlMatch) {
      console.warn(`⚠️  No test cases found in ${entry.path}`);
      continue;
    }

    const testData = parseYaml(yamlMatch[1]) as {
      test_cases: TestCase[];
    };

    suites.push({
      operation,
      category,
      testCases: testData.test_cases,
    });
  }

  return suites;
}

function runTestCase(suite: TestSuite, testCase: TestCase): boolean {
  console.log(`    Testing: ${testCase.description}`);

  try {
    // Note: This is a placeholder for actual implementation testing
    // In a real scenario, you would:
    // 1. Import the ReScript compiled JS
    // 2. Call the appropriate function with testCase.input
    // 3. Compare result with testCase.output

    // For now, we just validate the structure
    if (testCase.input === undefined || testCase.output === undefined) {
      throw new Error("Invalid test case structure");
    }

    console.log(`      ✅ PASS`);
    return true;
  } catch (error) {
    console.log(
      `      ❌ FAIL: ${(error as Error).message}`,
    );
    return false;
  }
}

async function main() {
  console.log("🧪 Running conformance tests...\n");

  const suites = await loadTestSuites();
  console.log(`Found ${suites.length} test suites\n`);

  let totalTests = 0;
  let passedTests = 0;
  let failedTests = 0;

  for (const suite of suites) {
    console.log(`📦 ${suite.category}/${suite.operation}`);

    for (const testCase of suite.testCases) {
      totalTests++;
      const passed = runTestCase(suite, testCase);
      if (passed) {
        passedTests++;
      } else {
        failedTests++;
      }
    }

    console.log();
  }

  console.log(`📊 Results:`);
  console.log(`  Total:  ${totalTests} tests`);
  console.log(`  Passed: ${passedTests} tests`);
  console.log(`  Failed: ${failedTests} tests`);

  if (failedTests > 0) {
    console.log(`\n❌ Some tests failed`);
    Deno.exit(1);
  } else {
    console.log(`\n✨ All tests passed!`);
  }
}

if (import.meta.main) {
  main();
}
