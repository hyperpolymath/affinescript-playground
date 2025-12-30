#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# SPDX-FileCopyrightText: 2025 hyperpolymath
#
# verify-rsr.sh - RSR (Rhodium Standard Repository) compliance verification
# For AffineScript Playground

set -euo pipefail

echo "=== RSR Compliance Verification ==="
echo ""

PASS=0
FAIL=0

check_file() {
    local file="$1"
    local description="$2"
    if [[ -f "$file" ]]; then
        echo "  ✓ $description ($file)"
        ((PASS++))
    else
        echo "  ✗ $description ($file) - MISSING"
        ((FAIL++))
    fi
}

check_dir() {
    local dir="$1"
    local description="$2"
    if [[ -d "$dir" ]]; then
        echo "  ✓ $description ($dir/)"
        ((PASS++))
    else
        echo "  ✗ $description ($dir/) - MISSING"
        ((FAIL++))
    fi
}

echo "Bronze Level Requirements:"
echo ""

# Documentation
echo "Documentation:"
check_file "README.adoc" "README"
check_file "LICENSE.txt" "License"
check_file "SECURITY.md" "Security Policy"
check_file "CODE_OF_CONDUCT.md" "Code of Conduct"
check_file "CONTRIBUTING.adoc" "Contributing Guide"
check_file "CHANGELOG.md" "Changelog"

echo ""
echo "Build Configuration (RSR Language Policy):"
check_file "deno.json" "Deno configuration (replaces Node/npm)"
check_file "rescript.json" "ReScript configuration (replaces TypeScript)"
check_file "justfile" "Build commands"
check_file "Mustfile" "Mandatory checks"

echo ""
echo "Project Structure:"
check_dir "src" "Source directory"
check_dir "test" "Test directory"
check_dir "examples" "Examples directory"
check_dir "docs" "Documentation directory"
check_dir "scripts" "Scripts directory"
check_dir ".well-known" "Well-known directory"

echo ""
echo "AffineScript Specific:"
echo "  - Affine types: Use resources at most once"
echo "  - WebAssembly target: WASM compilation"
echo "  - Memory safety: Zero undefined behavior"

echo ""
echo "=== Summary ==="
echo "  Passed: $PASS"
echo "  Failed: $FAIL"
echo ""

if [[ $FAIL -eq 0 ]]; then
    echo "✓ RSR Compliance: PASSED"
    exit 0
else
    echo "✗ RSR Compliance: FAILED"
    exit 1
fi
