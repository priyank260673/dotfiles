#!/bin/bash
while read -r line; do
	if [[ $line == *"8=FIX"* ]]; then
		if [[ $line =~ .*49\=$1.* ]]; then
			#echo "$line" | sed  's/^.*\(8=FIX.\)/\1/p' | ~/extra_git/mydotfiles/dotfiles/fixDecoder
			printf "OUT: "
			echo "$line" | sed  's/^.*\(8=FIX.\)/8=FIX./' | ~/extra_git/mydotfiles/dotfiles/fixDecoder
		else
			#echo "$line" | sed  's/^.*\(8=FIX.\)/\1/p' | ~/extra_git/mydotfiles/dotfiles/fixDecoder
			printf " IN: "
			echo "$line" | sed  's/^.*\(8=FIX.\)/8=FIX./' | ~/extra_git/mydotfiles/dotfiles/fixDecoder
		fi
	else
		echo "$line"
	fi
done 
