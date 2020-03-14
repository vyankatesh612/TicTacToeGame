#!/bin/bash -x
echo "WELCOME TO TIC_TAC_TOE GAME"
declare -a gameBoard
boardsize=9

function resetGameboard()
	{
		for ((i=0;i<boardsize;i++))
		do
			gameBoard[$i]="_"
		done
	}
resetGameboard
