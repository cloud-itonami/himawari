#!/usr/bin/env bash
# himawari — cell test suite on the kbb engine. Exits non-zero on any failure
# or error (verify with a deliberately failing assertion before trusting it).
#
# The namespaces are himawari.cells.* but this repo's root IS himawari, so a
# temporary `himawari -> repo root` link puts the `himawari/` prefix on the
# classpath. Not covered: cells/*/test_*.py (their cell.py were pruned; those
# files cannot run) and methods/test_charter_gates.cljk (`kbb -M:test:charter`).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
ln -s "$ROOT" "$TMP/himawari"
cd "$ROOT"
exec kbb --backend sci --classpath "$TMP:$ROOT/src:$ROOT/test" scripts/run_cell_tests.cljk
