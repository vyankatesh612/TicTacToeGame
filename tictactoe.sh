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

function assignletter()
	{
		local letter1="X"
		local letter2="O"
		local random=$((RANDOM%2))
		if [ $random == 0 ]
		then 
			player=$letter1
		else
			player=$letter2
		fi
	}
assignletter
