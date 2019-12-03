#!/bin/bash

##the game over function displays a game over message and sends the 3 variables to the pyhton file to be stored on DB table
gameover() {
	echo "	game over." 
	echo "	you $name as a $className have collected a total of $playerGold gold" 
	echo "	but, it was ultimately pointless sorry to say."
	python3 lbviewer.py $name, $className, $playerGold
}

##this section of code opens the first page and asks for user name and class choice also holds an array of pages
cat pages/openningPage.txt
read -p "	enter your name: " name
read -p "	enter fighter, rogue, or wizard: " className
pages=("pages/page1.txt" "pages/page2.txt" "pages/page3.txt" "pages/page4.txt" "pages/page5.txt")

## using a regular expression we check if the class name is valid if not game ends
if [[ $className =~ "fighter"|"rogue"|"wizard" ]]
then
	# initializes the player gold to zero
	playerGold=0

	##this is a for loop that loops through the pages array
	for i in ${!pages[@]};
	do
		#this section displays the correct page throught the loop
		echo " "
		echo "	${pages[$i]}"
		cat ${pages[$i]}	
			
		#request for player option then has a conditional to check what happens
		echo "		1) search area"
		echo "		2) move along"
		echo "		3) runnaway"
		read -p  "	type your numerical choice : " response

		# conditional to decide what to do next based on the player response 
		if [[ $response -eq 1 ]] ## 1 searches the area and generates a random gold amount then adds it to player total gold. displays a little message about it
		then 
			goldfound=$(($RANDOM%100))
			playerGold=$(($playerGold+$goldfound))
			echo "	you found $goldfound gold now you have $playerGold gold total "

		elif [[ $response -eq 2 ]] ## 2 moves to next page without looking for gold
		then
			echo "	you continue your pointless journey"
			continue;
		else ##if the player chooses 3 or anything not a 1 or 2 the game over function is called and exits the program

			echo "	you leave because there is nothing to actually do with this"
			gameover
			exit
		fi
		
	done
	## once all the pages have been used the game calls the game over function
	gameover

else
	echo "you died before your became anybody its probably for the best"
fi

