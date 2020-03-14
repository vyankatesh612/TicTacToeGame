#!/bin/bash -x
echo "WELCOME TO TIC_TAC_TOE GAME"
declare -a gameBoard
boardsize=9
moves=0

function resetGameboard()
	{
		for ((i=0;i<boardsize;i++))
		do
			gameBoard[$i]="_"
		done
	}
resetGameboard

function checktoss()
	{
		local letter1="X"
		local letter2="O"
		local toss=$((RANDOM%2))
		if [ $toss == 0 ]
		then 
			player=$letter1
		else
			player=$letter2
		fi
	}
checktoss

function displayboard()
	{
		for ((row=0;row<$boardsize;row+=3))
		do
			echo "${gameBoard[$row]}"" | ""${gameBoard[$row+1]}"" | ""${gameBoard[$row+2]}"
		done
		echo
	}
displayboard

function chooseposition()
	{
		while [ true ]
		do
			read -p "choose any position on board : " position
			if [[ ${gameBoard[$position-1]} == "_" ]] 
			then
				gameBoard[$position-1]=$player
			fi
			displayboard
			((moves=$moves+1))
			if [ $moves -gt 8 ]
			then
				exit
			fi
		done
	}
chooseposition
