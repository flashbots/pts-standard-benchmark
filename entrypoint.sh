#!/usr/bin/env bash
set -eu
mkdir -p "$OUTPUT_DIR"
phoronix-test-suite batch-run local/flashloads
rm -f /fio/fiofile
phoronix-test-suite result-file-to-csv "$TEST_RESULTS_NAME"
phoronix-test-suite result-file-to-html "$TEST_RESULTS_NAME"
