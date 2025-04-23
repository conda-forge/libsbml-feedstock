echo on

xcopy LICENSE.txt %PREFIX%\

cmake -G"Ninja" -S . -B build ^
    %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DCMAKE_CXX_STANDARD_LIBRARIES=-lxml2 ^
    -DLIBXML_LIBRARY="%PREFIX%"/Library/lib/libxml2.lib ^
    -DLIBXML_INCLUDE_DIR="%PREFIX%"/Library/include/libxml2 ^
    -DWITH_SWIG=OFF ^
    -DWITH_STABLE_PACKAGES=ON ^
    -DWITH_CPP_NAMESPACE=ON

cmake --build build --parallel %CPU_COUNT% --config Release
cmake --build build --target install

del /q %PREFIX%\Library\share\cmake\Modules\FindLIBXML.cmake
del /q %PREFIX%\Library\share\cmake\Modules\FindBZ2.cmake
del /q %PREFIX%\Library\share\cmake\Modules\FindZLIB.cmake

mkdir %PREFIX%\Library\share\libsbml\
move /y %PREFIX%\Library\COPYING.txt %PREFIX%\Library\share\libsbml\COPYING.txt
move /y %PREFIX%\Library\FUNDING.txt %PREFIX%\Library\share\libsbml\FUNDING.txt
move /y %PREFIX%\Library\LICENSE.txt %PREFIX%\Library\share\libsbml\LICENSE.txt
move /y %PREFIX%\Library\NEWS.txt %PREFIX%\Library\share\libsbml\NEWS.txt
move /y %PREFIX%\Library\README.md %PREFIX%\Library\share\libsbml\README.md
move /y %PREFIX%\Library\VERSION.txt %PREFIX%\Library\share\libsbml\VERSION.txt
