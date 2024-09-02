A test suite to benchmark CPU, memory, and disk performance. Based on [Phoronix Test Suite](https://www.phoronix-test-suite.com/)

## Quick Start
```bash
PTS_STORAGE_BENCHMARK_PATH="$PWD/fio" # a path to a directory on a storage you want to benchmark
PTS_TEST_RESULTS_PATH="$PWD/test-results" # a path to the test results
mkdir -p "$PTS_STORAGE_BENCHMARK_PATH" "$PTS_TEST_RESULTS_PATH"
podman run --rm -it --security-opt=seccomp=unconfined \
  -v "$PTS_TEST_RESULTS_PATH:/test-results" \
  -v "$PTS_STORAGE_BENCHMARK_PATH:/fio" \
  public.ecr.aws/b1b9d4e2/pts-standard-benchmark:latest
```

The suite includes tools to test disk (using fio), memory (using stream), and CPU (using a Linux Kernel compilation) performance.

Upon the completion the benchmark will output the results to `$PTS_TEST_RESULTS_PATH`. It should contain both CSV and HTML formatted reports.
