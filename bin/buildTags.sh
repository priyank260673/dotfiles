# Build CPP tags ===============================================================================================
rm -rf ~/tags/*
#find /usr/include/c++/7/ -print | ctags --c++-kinds=+p  --language-force=C++ --tag-relative=yes  --totals --recurse --extra="+qf" --fields="+iaS" -L - -o ~/tags/cppTags

echo " Building C++ tags" 
mkdir -p ~/.vim/cpp_src/
cp -R /usr/local/Cellar/gcc/8.2.0/include ~/.vim/cpp_src/
# it is not necessary to rename headers without an extension
# replace the "namespace std _GLIBCXX_VISIBILITY(default)" with "namespace std"
find ~/.vim/cpp_src -type f | xargs sed -i '' 's/namespace std _GLIBCXX_VISIBILITY(default)/namespace std/'
ctags -f ~/tags/allTags -R --tag-relative=yes  --totals --recurse --c++-kinds=+p --fields=+iaS --extra="+qf" --language-force=C++ -I _GLIBCXX_NOEXCEPT ~/.vim/cpp_src

echo " Building boost tags" 
# Build boost tags
#find /usr/include/boost -type f -print | ctags --c++-kinds=+p  --language-force=C++ --tag-relative=yes  --totals --recurse --extra="+qf" --fields="+iaS" -L - -o ~/tags/boostTags

echo " Building CSCOPE files..." 
find ~/.vim/cpp_src -type f >> ~/tags/cscope.files
#find /usr/include/boost  -type f >> ~/tags/cscope.files
cscope -b -q -i ~/tags/cscope.files -f ~/tags/cscope.out
echo " Doien building CSCOPE files..."
