# This file is NOT licensed under the GPLv3, which is the license for the rest
# of YouCompleteMe.
#
# Here's the license text for this file:
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

import os
import ycm_core

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-Wc++98-compat',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-fopenmp'
    # QT libraries
    '-I/usr/include/ImageMagick/',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/Enginio',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DCore',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DInput',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DQuick',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DQuickRenderer',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DRenderer',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtBluetooth',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtCLucene',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtConcurrent',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtCore',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtDBus',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtDeclarative',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtDesigner',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtDesignerComponents',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtGui',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtHelp',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtLocation',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimedia',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimediaQuick_p',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimediaWidgets',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtNetwork',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtNfc',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtOpenGL',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtOpenGLExtensions',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtPlatformHeaders',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtPlatformSupport',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtPositioning',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtPrintSupport',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQml',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQmlDevTools',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQuick',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickParticles',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickTest',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickWidgets',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtScript',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtScriptTools',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtSensors',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtSerialPort',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtSql',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtSvg',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtTest',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtUiPlugin',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtUiTools',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebChannel',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebEngine',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebEngineWidgets',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebKit',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebKitWidgets',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebSockets',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebView',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWidgets',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtX11Extras',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtXml',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtXmlPatterns',
    '-I/opt/Qt5.5.0/5.5/gcc_64/include/QtZlib',
    # ffmpeg libraries
    '-I/opt/ffmpeg/include/',
    '-I/opt/ffmpeg/include/libavcodec',
    '-I/opt/ffmpeg/include/libavdevice',
    '-I/opt/ffmpeg/include/libavfilter',
    '-I/opt/ffmpeg/include/libavformat',
    '-I/opt/ffmpeg/include/libavresample',
    '-I/opt/ffmpeg/include/libavutil',
    '-I/opt/ffmpeg/include/libpostproc',
    '-I/opt/ffmpeg/include/libswresample',
    '-I/opt/ffmpeg/include/libswscale',
    # GNUstep libraries
    '-I/usr/include/GNUstep/',
    '-I/usr/include/GNUstep/AppKit',
    '-I/usr/include/GNUstep/Cocoa',
    '-I/usr/include/GNUstep/Cynthiune',
    '-I/usr/include/GNUstep/DBKit',
    '-I/usr/include/GNUstep/Foundation',
    '-I/usr/include/GNUstep/Frameworks',
    '-I/usr/include/GNUstep/FSNode',
    '-I/usr/include/GNUstep/GNUMail',
    '-I/usr/include/GNUstep/gnustep',
    '-I/usr/include/GNUstep/GNUstepBase',
    '-I/usr/include/GNUstep/GNUstepGUI',
    '-I/usr/include/GNUstep/GormCore',
    '-I/usr/include/GNUstep/GormObjCHeaderParser',
    '-I/usr/include/GNUstep/GormPrefs',
    '-I/usr/include/GNUstep/Inspector',
    '-I/usr/include/GNUstep/InterfaceBuilder',
    '-I/usr/include/GNUstep/Operation',
    '-I/usr/include/GNUstep/PreferencePanes',
    '-I/usr/include/GNUstep/ProjectCenter',
    '-I/usr/include/GNUstep/Renaissance',
    '-I/usr/include/GNUstep/TalkSoupBundles',
    # X11 lib
    '-I/usr/include/X11/',
    '-I.',
    '-I..',
    '-I include',
    '-I../include',
    # THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
    # language to use when compiling headers. So it will guess. Badly. So C++
    # headers will be compiled as C headers. You don't want that so ALWAYS specify
    # a "-std=<something>".
    # For a C project, you would set this to something like 'c99' instead of
    # 'c++11'.
    '-std=c++11',
    # ...and the same thing goes for the magic -x option which specifies the
    # language that the files to be compiled are written in. This is mostly
    # relevant for c++ headers.
    # For a C project, you would set this to 'c' instead of 'c++'.
    '-x',
    'c++',
    #'-isystem',
    #'../BoostParts',
    #'-isystem',
    #'isystem', '/usr/local/include/',
    #'isystem', '/usr/lib/gcc/x86_64-linux-gnu/4.8.4/include/',
    #'isystem', '/usr/include/',
]

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# You can get CMake to generate this file for you by adding:
#   set( CMAKE_EXPORT_COMPILE_COMMANDS 1 )
# to your CMakeLists.txt file.
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''

if os.path.exists(compilation_database_folder):
    database = ycm_core.CompilationDatabase(compilation_database_folder)
else:
    database = None

SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']

def DirectoryOfThisScript():
    return os.path.dirname(os.path.abspath(__file__))


def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = ['-isystem', '-I', '-iquote', '--sysroot=']
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[len(path_flag):]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)
    return new_flags


def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in ['.h', '.hxx', '.hpp', '.hh']


def GetCompilationInfoForFile(filename):
    # The compilation_commands.json file generated by CMake does not have entries
    # for header files. So we do our best by asking the db for flags for a
    # corresponding source file, if any. If one exists, the flags for that file
    # should be good enough.
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                compilation_info = database.GetCompilationInfoForFile(replacement_file)
            if compilation_info.compiler_flags_:
                return compilation_info
        return None
    return database.GetCompilationInfoForFile(filename)


def FlagsForFile(filename, **kwargs):
    if database:
        # Bear in mind that compilation_info.compiler_flags_ does NOT return a
        # python list, but a "list-like" StringVec object
        compilation_info = GetCompilationInfoForFile(filename)
        if not compilation_info:
            return None

        final_flags = MakeRelativePathsInFlagsAbsolute(
            compilation_info.compiler_flags_,
            compilation_info.compiler_working_dir_)

        # NOTE: This is just for YouCompleteMe; it's highly likely that your project
        # does NOT need to remove the stdlib flag. DO NOT USE THIS IN YOUR
        # ycm_extra_conf IF YOU'RE NOT 100% SURE YOU NEED IT.
        try:
            final_flags.remove('-stdlib=libc++')
        except ValueError:
            pass
    else:
        relative_to = DirectoryOfThisScript()
        final_flags = MakeRelativePathsInFlagsAbsolute(flags, relative_to)

    return {
        'flags': final_flags,
        'do_cache': True
    }
