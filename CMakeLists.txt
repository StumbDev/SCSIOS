cmake_minimum_required(VERSION 3.10)

# Set the project name
project(SCSIOS)

# Add an executable
add_executable(SCSIOS main.cpp)

# Add custom command to handle JavaScript and TypeScript files
add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/bundle.js
    COMMAND npx webpack
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    DEPENDS ${CMAKE_SOURCE_DIR}/src/index.js ${CMAKE_SOURCE_DIR}/src/index.ts
    COMMENT "Building JavaScript and TypeScript files"
)

# Add custom target to run the custom command
add_custom_target(build_js ALL
    DEPENDS ${CMAKE_BINARY_DIR}/bundle.js
)

# Ensure the executable depends on the JavaScript build
add_dependencies(SCSIOS build_js)

# Add custom command to compile the Windows driver
add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/SCSIOSDriver.sys
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/win32driver
    COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR}/win32driver nmake /f ${CMAKE_SOURCE_DIR}/win32driver/SCSIOSDriver/Makefile
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/win32driver/SCSIOSDriver
    DEPENDS ${CMAKE_SOURCE_DIR}/win32driver/SCSIOSDriver/*.c ${CMAKE_SOURCE_DIR}/win32driver/SCSIOSDriver/*.h
    COMMENT "Compiling Windows driver"
)

# Add custom target to run the driver compilation command
add_custom_target(build_driver ALL
    DEPENDS ${CMAKE_BINARY_DIR}/SCSIOSDriver.sys
)

# Ensure the executable depends on the driver build
add_dependencies(SCSIOS build_driver)