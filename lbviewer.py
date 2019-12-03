#!/bin/python
#space between end game and python file start
print(' ')
print('python file start point')
print(' ')

## these imports make it poosible to get the variable 
import sys
import os

# makes list of the varibles passed from the main.sh file
args = sys.argv[1:]

#makeing the passed vaiables into local variables for readability
name = args[0]
classN = args[1]
gold = args[2]

#makes sure we got the correct variables just a test
if args:
    print(" we have variables")
    print(' player name = ' + name + 'class name = ' + classN +'player gold = ' + gold)
else:
    print("something is wrong")    

## push the varables into the sql table in leaderboards.db
print('leaderboards table(unordered)')
import sqlite3

## creates or connects to leaderboards.db then creates a cursor called c
conn = sqlite3.connect('leaderboards.db')
c = conn.cursor()

##function to show table results at the end of the page
def results():
    results = c.fetchall()
    for i in results:
        print(i)


## these are sql commands to create update and selects
sqlcreation = """ CREATE TABLE IF NOT EXISTS leaderboard (
    pname VARCHAR(20),
    pclass VARCHAR(10),
    pgold INT); """    
sqlinsert = """INSERT INTO leaderboard (pname, pclass, pgold) VALUES (? , ? , ?)""" 
sqlselect = """SELECT * FROM leaderboard""" 


## everything else is the sql commands actually being used
c.execute(sqlcreation)
c.execute(sqlinsert, (name , classN , gold))
conn.commit()
c.execute(sqlselect)
results()
conn.close()