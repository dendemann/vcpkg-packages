vcpkg_download_distfile(ARCHIVE
    URLS "http://evilissimo.fedorapeople.org/releases/vsqlite--/0.3.13/vsqlite++-0.3.13.tar.gz"
    FILENAME "vsqlite++-0.3.13.tar.gz"
    SHA512 c30ba98f1ef0e824e29140736b7aed1b1e625a3b33b568cecece17e7b0eeee20d1fcd90cb1ff18764f8ac85e88464c9edfd859cf7b4ef2fc3d45418cd1bf92fd
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# # Moves all .cmake files from /debug/share/vsqlite/ to /share/vsqlite/
# # See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
# vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/vsqlite)

# # Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/vsqlite RENAME copyright)

# # Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME vsqlite)
