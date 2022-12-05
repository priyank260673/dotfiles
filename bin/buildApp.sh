cd /home/ppatel/git/example/sapphire/
export E7_BOARD_TYPE=BoardV9P_exanic
#export E7_BUILD_TYPE=Sanitize; 
export E7_BUILD_TYPE=Debug; 
/opt/eagleseven/build/scripts/e7_icecc_cmake.sh
#/opt/eagleseven/build/scripts/e7_icecc_make.sh -j24 VERBOSE=1 $*
/opt/eagleseven/build/scripts/e7_icecc_make.sh -j24 VERBOSE=1 $*
