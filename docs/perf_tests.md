# Redis KV Store Performance and Benchmarking Documentation

Shane Liam H. So

Date format in `Y-m-d`

## 2026-11-18 Cache and Memory Usage Test

This test was completed on version commit `0x630fb59`.

### CPU Specifications

Here are selected specifications for the processor used in testing.

| Specification      | Information                          |
| -------------      | -----------                          |
| Architecture       | x86_64                               |
| CPU op-mode(s)     | 32-bit, 64-bit                       |
| Address sizes      | 39 bits physical, 48 bits virtual    |
| Byte Order         | Little Endian                        |
| CPU(s)             | 16                                   |
| Vendor ID          | GenuineIntel                         |
| Model name         | 13th Gen Intel(R) Core(TM) i7-13620H |
| CPU family         | 6                                    |
| Model              | 186                                  |
| Thread(s) per core | 2                                    |
| Core(s) per socket | 10                                   |
| CPU(s) scaling MHz | 32%                                  |
| CPU max MHz        | 4900.0000                            |
| CPU min MHz        | 400.0000                             |

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
