# setup pretty printing for STL containers
python
import sys
sys.path.insert(0, '/usr/share/gcc-7/python/libstdcxx/v6/')
from printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

# For debugging router
set follow-fork-mode child
set detach-on-fork off
set follow-exec-mode new
set logging on 
set logging file ~/gdb.txt
#set disassemble-next-line on
set history save on
set history size 1000
set history remove-duplicates 100
set history filename ~/.gdb_history
set data-directory /home/ppatel/bin/GDB/gdb-8.2.1/gdb/data-directory/
handle SIGINT pass
