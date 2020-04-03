cmake_minimum_required(VERSION 3.14)

project(vsqlite++ VERSION 0.3.13)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(Boost)
if ( NOT Boost_FOUND )
	message(FATAL_ERROR "Could not find Boost dependency")
endif()

find_package(sqlite3)
if ( NOT SQLite3_FOUND )
	message(FATAL_ERROR "Could not find sqlite3 dependency")
endif()

include_directories(
.
"${Boost_INCLUDE_DIRS}" 
"${SQLite3_INCLUDE_DIRS}"
)

aux_source_directory(src/sqlite/ SOURCE_FILES)

add_library("${PROJECT_NAME}" STATIC "${SOURCE_FILES}")

target_include_directories("${PROJECT_NAME}" PRIVATE include)

target_link_libraries("${PROJECT_NAME}" PRIVATE 
"${Boost_INCLUDE_DIRS}" 
"${SQLite3_LIBRARIES}"
)

install(TARGETS "${PROJECT_NAME}" DESTINATION lib)
install(DIRECTORY include/sqlite DESTINATION include) 
