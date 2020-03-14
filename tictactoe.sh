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
			opponentletter=$letter1
			computerletter=$letter2
			opponentposition
		else
			computerletter=$letter1
			opponentletter=$letter2
			computerposition
		fi
	}

function displayboard()
	{
		for ((row=0;row<$boardsize;row+=3))
		do
			echo "${gameBoard[$row]}"" | ""${gameBoard[$row+1]}"" | ""${gameBoard[$row+2]}"
		done
		echo
	}
displayboard

function opponentposition()
	{
		local win="opponent"
		while [ true ]
		do
			read -p "choose any position on board : " position
			if [[ ${gameBoard[$position-1]} == "_" ]] 
			then
				gameBoard[$position-1]=$opponentletter
			else
				echo " position is already occupied ..choose another"
				chooseposition 
			fi
			moves=$(($moves + 1))
			displayboard
			checkwinner $opponentletter
			checktie $moves
			computerposition
		done
	}

function computerposition()
	{
		local win="computer"
		while [ true ]
		do
			position=$((RANDOM%9 + 1))
			if [[ ${gameBoard[$position-1]} == "_" ]] 
			then
				gameBoard[$position-1]=$computerletter
			else
				computerposition 
			fi
			moves=$(($moves + 1))
			displayboard
			checkwinner $computerletter
			checktie $moves
			opponentposition
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
				displaywin $win
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
				displaywin $win
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
			displaywin $win
		fi

	}

function checktie()
	{
		local moves=$1
		if [ $moves -gt 8 ]
		then
			echo "Tie"
			exit
		fi
	}

function displaywin()
	{
		local player=$1
		echo "$player win"
		exit 
	}
checktoss
