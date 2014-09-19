# Preshell - Interactive C/C++ preprocessor shell
# Copyright (C) 2013, Abel Sinkovics (abel@sinkovics.hu)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cmake_minimum_required(VERSION 2.6)

project(cmpshelld)
set(CMAKE_PROJECT_NAME cmpshelld)
set(MAJOR_VERSION 0)
set(MINOR_VERSION 1)
set(PATCH_VERSION 0)

macro(create_init_symlink RUNLEVEL SHELL START_OR_KILL)
  set(LINK_NAME ${CMAKE_CURRENT_BINARY_DIR}/${START_OR_KILL}20${SHELL})

  execute_process(
    COMMAND
      "${CMAKE_COMMAND}" -E create_symlink /etc/init.d/${SHELL} "${LINK_NAME}"
  )
  install(FILES "${LINK_NAME}" DESTINATION /etc/rc${RUNLEVEL}.d)
endmacro(create_init_symlink)

# Daemon
set(CMAKE_INSTALL_PREFIX "/usr")
install(PROGRAMS cmpshelld DESTINATION bin)
install(FILES solarized.css DESTINATION share)
foreach (I preshell metashell)
  install(PROGRAMS ${I} DESTINATION /etc/init.d)
  create_init_symlink(0 ${I} K)
  create_init_symlink(1 ${I} K)
  create_init_symlink(2 ${I} S)
  create_init_symlink(3 ${I} S)
  create_init_symlink(4 ${I} S)
  create_init_symlink(5 ${I} S)
  create_init_symlink(6 ${I} K)
endforeach(I)

# Debian package
if(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
  include(InstallRequiredSystemLibraries)
   
  set(CPACK_SET_DESTDIR "on")
  set(CPACK_PACKAGING_INSTALL_PREFIX "/tmp")
  set(CPACK_GENERATOR "DEB")
   
  set(CPACK_PACKAGE_DESCRIPTION "C++ Metaprogramming shell daemons")
  set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "It is a daemon for Preshell and Metashell")
  set(CPACK_PACKAGE_VENDOR "Abel Sinkovics")
  set(CPACK_PACKAGE_CONTACT "abel@sinkovics.hu")
  set(CPACK_PACKAGE_VERSION_MAJOR "${MAJOR_VERSION}")
  set(CPACK_PACKAGE_VERSION_MINOR "${MINOR_VERSION}")
  set(CPACK_PACKAGE_VERSION_PATCH "${PATCH_VERSION}")
  set(CPACK_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}_${MAJOR_VERSION}.${MINOR_VERSION}.${CPACK_PACKAGE_VERSION_PATCH}_${CMAKE_SYSTEM_PROCESSOR}")
  set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}_${MAJOR_VERSION}.${MINOR_VERSION}.${CPACK_PACKAGE_VERSION_PATCH}")

  set(CPACK_DEBIAN_PACKAGE_DEPENDS "preshell, metashell, shellinabox")
  set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
  set(CPACK_DEBIAN_PACKAGE_SECTION "devel")
  set(CPACK_DEBIAN_ARCHITECTURE "all") # Config-only
   
  set(CPACK_COMPONENTS_ALL Libraries ApplicationData)
  include(CPack)
   
endif(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")



