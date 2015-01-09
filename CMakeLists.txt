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
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "/usr")
endif()
install(PROGRAMS app/cmpshelld DESTINATION bin)
install(PROGRAMS app/shell_demo DESTINATION bin)
install(FILES share/solarized.css DESTINATION share)
foreach (I preshell metashell shell_demo)
  install(PROGRAMS init.d/${I} DESTINATION /etc/init.d)
  create_init_symlink(0 ${I} K)
  create_init_symlink(1 ${I} K)
  create_init_symlink(2 ${I} S)
  create_init_symlink(3 ${I} S)
  create_init_symlink(4 ${I} S)
  create_init_symlink(5 ${I} S)
  create_init_symlink(6 ${I} K)
endforeach(I)

