# Copyright (C) 2014 Google Inc.
#
# This file is part of ycmd.
#
# ycmd is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ycmd is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ycmd.  If not, see <http://www.gnu.org/licenses/>.

import os
import ycm_core

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
'-fexceptions',
'-DNDEBUG',
'-ggdb3',
'-fexceptions',
'-ferror-limit=10000',
'-DNDEBUG',
'-pedantic',
'-Wno-comment',
'-Wno-invalid-offsetof',
'-fno-omit-frame-pointer',
'-fno-stack-protector',
'-fno-strict-aliasing',
# THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
# language to use when compiling headers. So it will guess. Badly. So C++
# headers will be compiled as C headers. You don't want that so ALWAYS specify
# a "-std=<something>".
# For a C project, you would set this to something like 'c99' instead of
# 'c++11'.
'-std=c++17',
# ...and the same thing goes for the magic -x option which specifies the
# language that the files to be compiled are written in. This is mostly
# relevant for c++ headers.
# For a C project, you would set this to 'c' instead of 'c++'.
'-x', 'c++',
'-isystem', '/usr/include/c++/10/',
'-isystem', '/usr/include',
'-isystem', '/usr/local/include',
'-isystem', '/usr/local/share/drop/gtest-1.8-c++17/include/',
'-isystem', '/usr/local/share/drop/cryptopp-5.6.5/include/',
'-isystem', '/usr/local/share/drop/exanic/v2.7.1/include',
'-I', '/usr/local/share/drop/mFAST/0.0.2/',
'-I', '/usr/local/share/drop/gcem/v1.16.0/include/',
'-I', '/usr/local/share/drop/openonload/openonload-7.1.2.141/include',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/Example',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/feeder',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/Sapphire',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/pricefeeders',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/Ccs2',
'-I', '/home/ppatel/git/example/sapphire/.',
'-I', '/home/ppatel/git/example/sapphire/sapphire',
'-I', '/home/ppatel/git/example/sapphire/sapphire/e7core',
'-I', '/home/ppatel/git/example/sapphire/sapphire/hawk',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated',
'-I', '/home/ppatel/git/example/sapphire/sapphire/sapphirelibs',
'-I', '/home/ppatel/git/example/sapphire/sapphire/nodes',
'-I', '/usr/local/share/drop',
'-I', '/usr/local/share/drop/cryptopp-5.6.5/include',
'-I', '/usr/include/postgresql',
'-I', '/usr/include/postgresql/12/server',
'-I', '/usr/local/share/drop/libtins-3.4/include',
'-I', '/usr/local/share/drop/taocpp/1.0.0-beta11/include',
'-I', '/usr/local/share/drop/aws/aws-1.8.135/include',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/_deps/condor_api-src/condor_api',
'-I', '/home/ppatel/git/example/sapphire/sapphire/messages/',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/Example',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/feeder',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/Sapphire',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/pricefeeders',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/Ccs2',
'-I', '/home/ppatel/git/example/sapphire/sapphire/e7core/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/hawk/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/hawk/hawk/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/hawk/hawk/*.*/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/hawk/hawk/message_queue/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/hawk/hawk/io/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/hawk/hawk/feeder/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/strategy20/',
'-I', '/home/ppatel/git/example/sapphire/',
'-I', '/home/ppatel/extra_git/spdlog/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/gateways/feeder/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/gateways/router/lib/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/gateways/router/lib/channels/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/gateways/router/lib/condor/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/gateways/router/lib/channels/execution/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/gateways/router/',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/messages/generated/feeder',
'-I', '/home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/hawk/hawk/feeder/exchanges/eurex/fast/decoder/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/',
'-I', '/home/ppatel/git/example/sapphire/sapphire/ccs2/',
]

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags.
compilation_database_folder = ''

# This is the entry point; this function is called by ycmd to produce flags for
# a file.
def Settings( **kwargs ):
  # python list, but a "list-like" StringVec object.
  return {
    'flags': flags,
    'include_paths_relative_to_dir': '/home/ppatel/git/example/'
  }
