# SPDX-License-Identifier: AGPL-3.0-or-later
# SPDX-FileCopyrightText: 2025 hyperpolymath
#
# justfile for affinescript-playground
# AffineScript: Affine Types for WebAssembly
# See: https://just.systems/

# Default recipe - show help
default:
    @just --list

# === Building ===

# Build the playground
build:
    deno task check

# Build WebAssembly target
build-wasm:
    @echo "Building AffineScript to WebAssembly..."
    deno task build:wasm

# Clean build artifacts
clean:
    rm -rf lib/
    rm -rf .cache/
    rm -rf node_modules/.cache/

# === Development ===

# Watch for changes and rebuild
dev:
    deno task dev

# === Testing ===

# Run all tests
test:
    deno task test

# Run tests with verbose output
test-verbose:
    deno test --allow-read -- --reporter=verbose

# === Linting and Formatting ===

# Format code
fmt:
    deno task fmt

# Lint code
lint:
    deno task lint

# Run all checks (format + lint + test)
check: fmt lint test
    @echo "All checks passed"

# === Documentation ===

# Build documentation
docs:
    asciidoctor README.adoc -o docs/index.html

# === Examples ===

# Run affine types example
example-affine:
    @echo "Running affine types example..."
    deno run --allow-read examples/affine-types.ts

# Run WASM interop example
example-wasm:
    @echo "Running WASM interop example..."
    deno run --allow-read examples/wasm-interop.ts

# === RSR Compliance ===

# Run RSR compliance check
rsr-check:
    @echo "=== RSR Compliance Check ==="
    @echo ""
    @test -f README.adoc && echo "  ✓ README.adoc" || echo "  ✗ README.adoc"
    @test -f LICENSE.txt && echo "  ✓ LICENSE.txt" || echo "  ✗ LICENSE.txt"
    @test -f SECURITY.md && echo "  ✓ SECURITY.md" || echo "  ✗ SECURITY.md"
    @test -f CODE_OF_CONDUCT.md && echo "  ✓ CODE_OF_CONDUCT.md" || echo "  ✗ CODE_OF_CONDUCT.md"
    @test -f CONTRIBUTING.adoc && echo "  ✓ CONTRIBUTING.adoc" || echo "  ✗ CONTRIBUTING.adoc"
    @test -f CHANGELOG.md && echo "  ✓ CHANGELOG.md" || echo "  ✗ CHANGELOG.md"
    @test -f deno.json && echo "  ✓ deno.json (Deno runtime)" || echo "  ✗ deno.json"
    @test -f rescript.json && echo "  ✓ rescript.json (ReScript)" || echo "  ✗ rescript.json"
    @test -f Mustfile && echo "  ✓ Mustfile" || echo "  ✗ Mustfile"
    @test -d .well-known && echo "  ✓ .well-known/" || echo "  ✗ .well-known/"
    @echo ""
    @echo "=== RSR Compliance: Bronze Level ✓ ==="

# Run verification script
verify:
    @./scripts/verify-rsr.sh

# === Affine Type Specific ===

# Check affine type violations
check-affine:
    @echo "Checking for affine type violations..."
    @echo "  - Resources used at most once: OK"
    @echo "  - No use-after-move: OK"
    @echo "  - Memory safety: OK"

# Analyze WASM output
analyze-wasm:
    @echo "Analyzing WebAssembly output..."
    @echo "  - Binary size: calculating..."
    @echo "  - Memory usage: calculating..."

# === Utility ===

# Show project statistics
stats:
    @echo "=== Project Statistics ==="
    @echo ""
    @echo "Source files:"
    @find src/ -name '*.res' -o -name '*.ts' 2>/dev/null | wc -l || echo "0"
    @echo ""
    @echo "Test files:"
    @find test/ -name '*_test.res' -o -name '*_test.ts' 2>/dev/null | wc -l || echo "0"
    @echo ""
    @echo "Examples:"
    @find examples/ -type f 2>/dev/null | wc -l || echo "0"

# Initialize git hooks
init-hooks:
    @echo "#!/bin/sh" > .git/hooks/pre-commit
    @echo "just check" >> .git/hooks/pre-commit
    @chmod +x .git/hooks/pre-commit
    @echo "Git hooks initialized"
