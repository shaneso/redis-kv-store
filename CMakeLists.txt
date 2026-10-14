cmake_minimum_required(VERSION 3.15)
project(kv_store CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Compiler warnings
add_compile_options(-Wall -Wextra -Wpedantic -Werror)

# Include directories
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# Server executable
add_executable(kv_store_server src/net/server.cc)

# Client executable
add_executable(kv_store_client src/net/client.cc)
