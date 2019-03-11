# Build CPP tags ===============================================================================================
rm -rf ~/tags/*
## ----------------------------------------------- ##
echo " Building C++ tags..." 
/home/ppatel/bin/CTAGS/LATEST/ctags/ctags -f ~/tags/allTags -R --sort=yes --tag-relative=yes  --totals --recurse --c++-kinds=+pl --fields=+ilasKS --extras="+qf" --language-force=C++ /usr/include/c++/7/
## ----------------------------------------------- ##
#echo "Building onload tags..."
#find /usr/local/share/drop/openonload/openonload-201710-u1/include  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print | /home/ppatel/bin/CTAGS/LATEST/ctags/ctags -R --sort=yes --tag-relative=yes  --totals --recurse --extras="+qf"  --language-force=C++ --c++-kinds=+pl --fields=+iasKS  -L - --append -o ~/tags/allTags
## ----------------------------------------------- ##
echo "Building connectivity tags..."
find /home/ppatel/git/example/sapphire  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print | grep -v unit-test | grep -v onetick | grep -v feeder | grep -v "sapphire/strategy" | grep  -v "hawk/hawk/book" |  grep -v "hawk/hawk/io/compression/brotli" | /home/ppatel/bin/CTAGS/LATEST/ctags/ctags -R --sort=yes --tag-relative=yes --totals --recurse  --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --extras="+qf" --language-force=C++ --fields=+ilasKS -L - --append -o ~/tags/allTags
## ----------------------------------------------- ##
echo "Building connectivity tags..."
find /home/ppatel/git/example/sapphire  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print | grep -v unit-test | grep -v onetick | grep -v feeder | grep -v "sapphire/strategy" | grep  -v "hawk/hawk/book" |  grep -v "hawk/hawk/io/compression/brotli" | /home/ppatel/bin/CTAGS/LATEST/ctags/ctags -R --sort=yes --tag-relative=yes --totals --recurse  --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --extras="+qf" --language-force=C++ --fields=+ilasKS -L - --append -o ~/tags/allTags1
## ----------------------------------------------- ##
echo " Building CSCOPE files..." 
#find /usr/include/c++/7/ -type f >> ~/tags/cscope.files
find /home/ppatel/git/example/sapphire/  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep -v unit-test | grep -v onetick | grep -v feeder  | grep -v "sapphire/strategy" | grep  -v "hawk/hawk/book" |  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/cscope.files
#find /usr/include/boost  -type f >> ~/tags/cscope.files
cscope -Rb -q -i ~/tags/cscope.files -f ~/tags/cscope.out
echo " Done building CSCOPE files..."
## -------------------------------------- ## 
#echo " Building boost tags" 
# Build boost tags
#find /usr/include/boost -type f -print | ctags --c++-kinds=+p  --language-force=C++ --tag-relative=yes  --totals --recurse --extra="+qf" --fields="+iaS" -L - -o ~/tags/boostTags
#find ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f cpp cpp_src
#echo "Building linux core utils tags .... " 
#find /home/users/ppatel/TOOLS/LINUX/CORE_UTILS/coreutils-7.4/  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\)" -print | grep -v Debug_el6_gcc48 | grep -v xerces-c-3.1.1 | grep -v ApolloUtilities | grep -v 3rdParty | ctags --tag-relative=yes  --totals --recurse --extra="+qf" --fields="+iaS" -L - -o ~/tags/linuxCoreUtils

## -------------------------------------- ## 
#echo "Building linux kernel tags .... " 
#find /home/users/ppatel/TOOLS/LINUX/KERNEL/linux-3.14.4/ -regex ".*\.\(c\|h\|hpp\|cc\|cpp\)" -print | grep -v Debug_el6_gcc48 | grep -v xerces-c-3.1.1 | grep -v ApolloUtilities | grep -v 3rdParty | ctags --tag-relative=yes  --totals --recurse --extra="+qf" --fields="+iaS" -L - -o ~/tags/linuxKernel
#ctags -L - -I __attribute__,__attribute_deprecated__,__attribute_format_arg__,__attribute_format_strfmon__,__attribute_malloc__,__attribute_noinline__,__attribute_pure__,__attribute_used__,__attribute_warn_unused_result__,__wur,__THROW,__nonnull+ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+liaS --extra=+q

## -------------OLD WAY OF BUILDING C++ TAGS-------------------------- ##
#rm -rf ~/.vim/cpp_src/
#mkdir -p ~/.vim/cpp_src/
#cp -R /usr/include/c++/7/  ~/.vim/cpp_src/
#find ~/.vim/cpp_src -type f | xargs sed -i 's/namespace std _GLIBCXX_VISIBILITY(default)/namespace std/'
#/home/ppatel/bin/CTAGS/LATEST/ctags/ctags -f ~/tags/allTags -R --sort=yes --tag-relative=yes  --totals --recurse --c++-kinds=+pl --fields=+liafmnS --extras="+qf" --language-force=C++ -I _GLIBCXX_NOEXCEPT ~/.vim/cpp_src
#/home/ppatel/bin/CTAGS/LATEST/ctags/ctags --append -f ~/tags/allTags -R --sort=yes --tag-relative=yes  --totals --recurse --c++-kinds=+pl --fields=+iasKS --extras="+qf" --language-force=C++ /usr/local/share/drop/gtest-1.8/
#/home/ppatel/bin/CTAGS/LATEST/ctags/ctags --append -f ~/tags/allTags -R --sort=yes --tag-relative=yes  --totals --recurse --c++-kinds=+pl --fields=+liafmnS --extras="+qf" --language-force=C++ /usr/include/boost/
## ----------------------------------------------- ##
