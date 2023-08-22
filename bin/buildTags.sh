# Build CPP tags ===============================================================================================
rm -rf ~/tags/*

## ----------------------------------------------- ##
#echo " Building C++ tags..." 
#/home/ppatel/extra_git/ctags/ctags -f ~/tags/cppTags -R --sort=yes --tag-relative=yes  --totals --recurse --c++-kinds=+pl --fields=+ilasKS --extras="+qf" --language-force=C++ /usr/include/c++/10/
find /usr/include/c++/10/  /usr/include/openssl -print |xargs /home/ppatel/extra_git/ctags/ctags -f ~/tags/cppTags -R --sort=yes --tag-relative=yes  --totals --recurse --c++-kinds=+pl --fields=+ilasKS --extras="+qf" --language-force=C++

## ----------------------------------------------- ##
echo "Building main example tags and CSCOPE files..."
find /home/ppatel/git/example/sapphire  /home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/_deps/condor_api-src -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print | grep -v onetick | grep  -v "hawk/hawk/book" | grep -v "strategy/strategy/"|  grep -v "hawk/hawk/io/compression/brotli" | /home/ppatel/extra_git/ctags/ctags -R --sort=yes --tag-relative=yes --totals --recurse  --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --extras="+qf" --language-force=C++ --fields=+ilasKS -L - --append -o ~/tags/allTags

find /home/ppatel/git/example/sapphire/  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep -v onetick | grep  -v "hawk/hawk/book" | grep -v "strategy/strategy/" |  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/cscope.files
find /home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/_deps/condor_api-src -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep -v onetick | grep  -v "hawk/hawk/book"| grep -v "strategy/strategy/" |  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/cscope.files
cscope -Rb -q -i ~/tags/cscope.files -f ~/tags/cscope.out
## -------------------------------------- ## 

## ----------------------------------------------- ##
echo "Building release/nrc tags and CSCOPE files..."
find /home/ppatel/git/release_nrc_repo/example/sapphire /home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/_deps/condor_api-src  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print | grep -v onetick | grep  -v "hawk/hawk/book" | grep -v "strategy/strategy/"|  grep -v "hawk/hawk/io/compression/brotli" | /home/ppatel/extra_git/ctags/ctags -R --sort=yes --tag-relative=yes --totals --recurse  --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --extras="+qf" --language-force=C++ --fields=+ilasKS -L - --append -o ~/tags/relNrcTags
find /home/ppatel/git/release_nrc_repo/example/sapphire  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep -v onetick | grep  -v "hawk/hawk/book" | grep -v "strategy/strategy/"|  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/relnrc_cscope.files
find /home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/_deps/condor_api-src -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep -v onetick | grep  -v "hawk/hawk/book"| grep -v "strategy/strategy/" |  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/relnrc_cscope.files
cscope -Rb -q -i ~/tags/relnrc_cscope.files -f ~/tags/relnrc_cscope.out
## -------------------------------------- ## 

## ----------------------------------------------- ##
echo "Building master repo tags and CSCOPE files..."
find /home/ppatel/git/master_repo/example/sapphire  /home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/_deps/condor_api-src -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print | grep -v onetick | grep  -v "hawk/hawk/book" | grep -v "strategy/strategy/"|  grep -v "hawk/hawk/io/compression/brotli" | /home/ppatel/extra_git/ctags/ctags -R --sort=yes --tag-relative=yes --totals --recurse  --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --extras="+qf" --language-force=C++ --fields=+ilasKS -L - --append -o ~/tags/masterTags
find /home/ppatel/git/master_repo/example/sapphire  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep -v onetick | grep  -v "hawk/hawk/book" | grep -v "strategy/strategy/"|  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/master_cscope.files
find /home/ppatel/git/example/sapphire/build/Debug-g++-10-haswell/_deps/condor_api-src -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep -v onetick | grep  -v "hawk/hawk/book"| grep -v "strategy/strategy/" |  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/master_cscope.files
cscope -Rb -q -i ~/tags/master_cscope.files -f ~/tags/master_cscope.out
## -------------------------------------- ## 

## ----------------------------------------------- ##
#echo "Building onetick tags and CSCOPE files..."
#find /home/ppatel/git/example/onetick-collectors -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print | grep  -v "hawk/hawk/book" | grep -v "strategy/strategy/"|  grep -v "hawk/hawk/io/compression/brotli" | /home/ppatel/extra_git/ctags/ctags -R --sort=yes --tag-relative=yes --totals --recurse  --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --extras="+qf" --language-force=C++ --fields=+ilasKS -L - --append -o ~/tags/oneTickTags
#
#find /home/ppatel/git/example/onetick-collectors/  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep  -v "hawk/hawk/book" | grep -v "strategy/strategy/" |  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/onetick_cscope.files
#find /usr/local/share/drop/condor/condor_exa-5.1.19/include/condor_exa/  -regex ".*\.\(c\|h\|hpp\|cc\|cpp\|ipp\)" -print  | grep  -v "hawk/hawk/book"| grep -v "strategy/strategy/" |  grep -v "hawk/hawk/io/compression/brotli" >> ~/tags/onetick_cscope.files
#cscope -Rb -q -i ~/tags/onetick_cscope.files -f ~/tags/onetick_cscope.out
## -------------------------------------- ## 

