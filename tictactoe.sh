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
		local player="opponent"
		while [ true ]
		do
			read -p "choose any position on board : " position
			if [[ ${gameBoard[$position-1]} == "_" ]] 
			then
				gameBoard[$position-1]=$opponentletter
			else
				echo " position is already occupied ..choose another"
				opponentposition 
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
		local player="computer"
		while [ true ]
		do
			if [[ $(computermoveforrowwin $computerletter) == 1 ]]
			then
				displaywin $player
			elif [[ $(computermoveforcolumnwin $computerletter) == 1 ]]
			then
				displaywin $player
			elif [[ $(computermovefordigonalwin $computerletter) == 1 ]]
			then
				displaywin $player
			else
				blockopponent
				takecornerwithcenter
			fi
			moves=$(($moves + 1))
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

function computermoveforrowwin()
	{
		local flag=0
		local input=$1
		for ((i=0;i<9;i=$i+3))
		do
			if [[ ${gameBoard[$i]} == $input && ${gameBoard[$i+1]} == $input && ${gameBoard[$i+2]} == "_" ]]
			then
				flag=1
				gameBoard[$((i+2))]=$computerletter
				displayboard
			elif [[ ${gameBoard[$i]} == $input && ${gameBoard[$i+1]} == "_" && ${gameBoard[$i+2]} == $input ]]
			then
				flag=1
				gameBoard[$((i+1))]=$computerletter
				displayboard
			elif [[ ${gameBoard[$i]} == "_" && ${gameBoard[$i+1]} == $input && ${gameBoard[$i+2]} == $input ]]
			then
				flag=1
				gameBoard[$i]=$computerletter
				displayboard
			fi
		done
		echo $flag
	}

function computermoveforcolumnwin()
	{
		local flag=0
		local input=$1
		for ((i=0;i<3;i++))
		do
			if [[ ${gameBoard[$i]} == $input && ${gameBoard[$i+3]} == $input && ${gameBoard[$i+6]} == "_" ]]
			then
				flag=1
				gameBoard[$((i+6))]=$computerletter
				displayboard
			elif [[ ${gameBoard[$i]} == $input && ${gameBoard[$i+3]} == "_" && ${gameBoard[$i+6]} == $input ]]
			then
				flag=1
				gameBoard[$((i+3))]=$computerletter
				displayboard
			elif [[ ${gameBoard[$i]} == "_" && ${gameBoard[$i+1]} == $input && ${gameBoard[$i+2]} == $input ]]
			then
				flag=1
				gameBoard[$i]=$computerletter
				displayboard
			fi
		done
		echo $flag
	}

function computermovefordigonalwin()
	{
		local flag=0
		local input=$1
		if [[ ${gameBoard[0]} == $input && ${gameBoard[4]} == $input && ${gameBoard[8]} == "_" ]]
		then
			flag=1
			gameBoard[8]=$computerletter
			displayboard
		elif [[ ${gameBoard[0]} == $input && ${gameBoard[4]} == "_" && ${gameBoard[8]} == $input ]]
		then
			flag=1
			gameBoard[4]=$computerletter
			displayboard
		elif [[ ${gameBoard[0]} == "_" && ${gameBoard[4]} == $input && ${gameBoard[8]} == $input ]]
		then
			flag=1
			gameBoard[0]=$computerletter
			displayboard
		elif [[ ${gameBoard[2]} == $input && ${gameBoard[4]} == $input && ${gameBoard[6]} == "_" ]]
		then
			flag=1
			gameBoard[6]=$computerletter
			displayboard
		elif [[ ${gameBoard[2]} == $input && ${gameBoard[4]} == "_" && ${gameBoard[6]} == $input ]]
		then
			flag=1
			gameBoard[4]=$computerletter
			displayboard
		elif [[ ${gameBoard[2]} == "_" && ${gameBoard[4]} == $input && ${gameBoard[6]} == $input ]]
		then
			flag=1
			gameBoard[2]=$computerletter
			displayboard
		fi
		echo $flag
	}

function blockopponent()
	{
		if [[ $(computermoveforrowwin $opponentletter) == 1 ]]
		then
			opponentposition
		elif [[ $(computermoveforcolumnwin $opponentletter) == 1 ]]
		then
			opponentposition
		elif [[ $(computermovefordigonalwin $opponentletter) == 1 ]]
		then
			opponentposition
		fi
	}

function takecornerwithcenter()
	{
		for ((i=0;i<9;i+=2))
		do
			if [[ ${gameBoard[$i]} == "_" ]]
			then
				gameBoard[$i]=$computerletter
				displayboard
				opponentposition
			fi
		done
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
