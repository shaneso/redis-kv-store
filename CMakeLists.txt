cmake_minimum_required(VERSION 3.15)
project(kv_store CXX ASM)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Compile options
add_compile_options(-Wall -Wextra -Wpedantic -Werror)

# Include directories
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# Server executable
add_executable(kv_store_server src/net/server.cc src/utils/utils.S)

# Client executable
add_executable(kv_store_client src/net/client.cc src/utils/utils.S)

# Target source for kv_store_server
target_sources(kv_store_server
  PRIVATE
    src/net/server.cc
)

# Target source for kv_store_client
target_sources(kv_store_client
  PRIVATE
    src/net/client.cc
)
