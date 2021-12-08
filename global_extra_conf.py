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
'-Wall',
'-Wextra',
'-ggdb3',
'-fexceptions',
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
'-x',
'c++',
'-isystem',
'/usr/include/c++/8/',
'-isystem',
'/usr/local/share/drop/gtest-1.8-c++17/include/',
'-isystem',
'/usr/local/share/drop/cryptopp-5.6.5/include/',
'-I',
'/usr/local/share/drop/newwave/expressxglite/',
'-I',
'/usr/local/share/drop/mFAST/0.0.2/',
'-I',
'/home/ppatel/git/example/sapphire/messages/',
'-I',
'/home/ppatel/git/example/sapphire/messages/generated/',
'-I',
'/home/ppatel/git/example/sapphire/messages/generated/Sapphire/',
'-I',
'/home/ppatel/git/example/sapphire/messages/generated/Ccs2/',
'-I',
'/home/ppatel/git/example/sapphire/messages/generated/Example/',
'-I',
'/home/ppatel/git/example/sapphire/e7core/',
'-I',
'/home/ppatel/git/example/sapphire/hawk/',
'-I',
'/home/ppatel/git/example/sapphire/hawk/hawk/',
'-I',
'/home/ppatel/git/example/sapphire/hawk/hawk/feeder/',
'-I',
'/home/ppatel/git/example/sapphire/sapphire/',
'-I',
'/home/ppatel/git/example/sapphire/sapphire/strategy20/',
'-I',
'/home/ppatel/git/example/sapphire/',
'-I',
'/home/ppatel/extra_git/spdlog/',
'-I',
'/usr/local/share/drop/condor/condor_exa-3.2.9/include/condor_exa/',
'-I',
'/home/ppatel/git/example/sapphire/sapphire/gateways/feeder/',
'-I',
'/home/ppatel/git/example/sapphire/messages/generated/feeder/',
'-I',
'/home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/hawk/hawk/feeder/exchanges/eurex/fast/decoder/',
]

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags.
#compilation_database_folder = '/home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/'
compilation_database_folder = ''

if os.path.exists( compilation_database_folder ):
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None

SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.inl']

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh', '.ipp', '.inl']

def GetCompilationInfoForFile( filename ):
  # The compilation_commands.json file generated by CMake does not have entries
  # for header files. So we do our best by asking the db for flags for a
  # corresponding source file, if any. If one exists, the flags for that file
  # should be good enough.
  if IsHeaderFile( filename ):
    basename = os.path.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if os.path.exists( replacement_file ):
        compilation_info = database.GetCompilationInfoForFile(
          replacement_file )
        if compilation_info.compiler_flags_:
          return compilation_info
    return None
  return database.GetCompilationInfoForFile( filename )


# This is the entry point; this function is called by ycmd to produce flags for
# a file.
#'include_paths_relative_to_dir': DirectoryOfThisScript(),
def Settings( filename, **kwargs ):
  if not database:
      newfilename = filename
      root, extension = os.path.splitext(filename)
      if extension == '.ipp':
        newfilename = root + '.h' 

      return { 'flags': flags, 
              'include_paths_relative_to_dir': "/",
              'override_filename': newfilename
              }

  compilation_info = GetCompilationInfoForFile( filename )
  if not compilation_info:
    return None

    newfilename = filename
    root, extension = os.path.splitext(filename)
    if extension == '.ipp':
        newfilename = root + '.h' 

  # Bear in mind that compilation_info.compiler_flags_ does NOT return a
  # python list, but a "list-like" StringVec object.
  return {
    'flags': list( compilation_info.compiler_flags_ ),
    'include_paths_relative_to_dir': compilation_info.compiler_working_dir_,
    'override_filename': newfilename
  }

