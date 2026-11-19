# Redis KV Store Performance and Benchmarking Documentation

Date format in `Y-m-d`

## 2026-11-18 Cache and Memory Usage Test

This test was completed on version commit `0x630fb59`.

### Cache Metrics

Here is a table showing `perf stat -e l1-dcache-loads,l1-dcache-load-misses,l2_request.all,l2_request.miss,llc-loads,llc-load-misses ./build/kv_store_server` test results. Caches `L1d` and `L2` metrics are taken from `cpu_core` (performance cores) while `LLC/L3` cache metrics are taken from `cpu_atom` (efficiency cores) since performance core cache loads/misses were not counted.

| Cache Memory | Total Cache Access | Cache Hits | Cache Hit Rate | Cache Misses | Cache Miss Rate |
| ------------ | ------------------ | ---------- | -------------- | ------------ | --------------- |
| L1d          | 1,335,698          | 1,291,252  | 96.67%         | 44,446       | 3.33%           |
| L2           | 196,625            | 133,324    | 67.81%         | 63,301       | 32.19%          |
| LLC (L3)     | 1,080              | 386        | 35.74%         | 694          | 64.26%          |

Here is a table showing `perf stat -e l1-dcache-loads,l1-dcache-load-misses,l2_request.all,l2_request.miss,llc-loads,llc-load-misses ./build/kv_store_client` test results.

| Cache Memory | Total Cache Access | Cache Hits | Cache Hit Rate | Cache Misses | Cache Miss Rate |
| ------------ | ------------------ | ---------- | -------------- | ------------ | --------------- |
| L1d          | 688,657            | 665,792    | 96.68%         | 22,865       | 3.32%           |
| L2           | 76,826             | 58,116     | 75.65%         | 18,710       | 24.35%          |
| LLC (L3)     | 2,339              | 2,206      | 94.31%         | 133          | 5.69%           |

### Memory Management

Both `server.cc` and `client.cc` freed all heap blocks. The programs saw three allocations (a total of 73,750 bytes) and three frees. Checks for memory leaks were performed with `valgrind --cache-sim=yes --tool=cachegrind` for `./build/kv_store_server` and `./build/kv_store_client`.
