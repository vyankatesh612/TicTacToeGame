#!/bin/bash -x
echo "WELCOME TO TIC_TAC_TOE GAME"
declare -a gameBoard
boardsize=9
moves=0
letter1="X"
letter2="O"

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
			else
				echo " position is already occupied ..choose another"
				chooseposition 
			fi
			moves=$(($moves + 1))
			displayboard
			checkwinner $player
			checktie $moves
			changeturn $player
		done
	}

function checkwinner()
	{
		input=$1
		combination=$input$input$input
		
		checkrowWin $combination
		checkcolumnWin $combination
		checkdigonalWin $combination
	}

function checkrowWin()
	{
		local combination=$1
		for ((row=0;row<$boardsize;row+=3))
		do
			rowcombination=${gameBoard[$row]}${gameBoard[$row+1]}${gameBoard[$row+2]}
			if [ $rowcombination == $combination ]
			then
				displaywin $player
			fi
		done
	}

function checkcolumnWin()
	{
		local combination=$1
		for ((column=0;column<3;column++))
		do
			columncombination=${gameBoard[$column]}${gameBoard[$colum+3]}${gameBoard[$row+6]}
			if [ $columncombination == $combination ]
			then
				displaywin $player
			fi
		done
	}

function checkdigonalWin()
	{
		local combination=$1
		digonalcombination1=${gameBoard[1]}${gameBoard[4]}${gameBoard[8]}
		digonalcombination2=${gameBoard[2]}${gameBoard[4]}${gameBoard[6]}
		if [[ $digonalcombination1 == $combination || $digonalcombination2 == $combination ]]
		then
			displaywin $player
		fi

	}

function changeturn()
	{
		if [ $player == $letter1 ]
		then
			player=$letter2
		else
			player=$letter1
		fi
	}

function checktie()
	{
		local moves=$1
		if [ $moves -gt 8 ]
		then
			exit
		fi
	}

function displaywin()
	{
		local player=$1
		echo "$player win"
		exit 
	}
chooseposition
