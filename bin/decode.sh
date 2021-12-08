#!/bin/bash
while read line; do
	if [[ $line == *"8=FIX"* ]]; then
		if [[ $line =~ .*49\=$2.* ]]; then
			#echo "$line" | sed  's/^.*\(8=FIX.\)/\1/p' | ~/extra_git/mydotfiles/dotfiles/fixDecoder
			printf "===> "
			echo "$line" | sed  's/^.*\(8=FIX.\)/8=FIX./' | ~/extra_git/mydotfiles/dotfiles/fixDecoder
		else
			#echo "$line" | sed  's/^.*\(8=FIX.\)/\1/p' | ~/extra_git/mydotfiles/dotfiles/fixDecoder
			printf "<=== "
			echo "$line" | sed  's/^.*\(8=FIX.\)/8=FIX./' | ~/extra_git/mydotfiles/dotfiles/fixDecoder
		fi
	else
		echo "$line"
	fi
done < $1
