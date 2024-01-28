# Unnamed game
* Gameplay ❌
* Setting: Futuristic Medieval (what the fuck)
* Themes ❌
* Characters ❌
* Items ❌
* Inventory system ❌
* Possible major features for the future ❌


##TODO:

### Programming things
We may need to assign each wall a value (height: default 1) for archers

### Gameplay
Player starts off buying a handgun, and a bunch of ammo jumps in his time travel machine, teleports to medieval village (villages/kingdoms will need names)
walks through the village, meets a friendly resident or whatever dumbass story this game has, villagers not happy with king for whatever reason, gives player a sword
Player storms the small castle, kills guards and then king.
Each kingdom has a description that explains how loyal the villagers are and whatever


Each kingdom has a difficulty rating, players can attempt them in any order but would massively struggle to beat later kingdoms without proper equipment. Something special thing happens for the final mission and the player must do it without modern technology.

You can sort of go down 2 routes with the game, Either buying heavy duty armor, machine guns and killing the waves of enemies. Buying snipers, daggers


For each kingdom the player must sneak into the castle, sneak past all interior guards, and kill the king.

A mission status begins on undetected and will change to detected if:
* A guard/Villager runs into the castle after detecting a player (exterior)
* A guard/Villager runs into the throne room after detecting a player (interior)

#### Enemies
* Villagers
	* Will run towards the castle if a player is detected
	* Each villager has a loyalty statistic ranging between 0-10, this can't be randomized really because it would make them too unpredictable. If a players leadership score is greater than the villagers loyalty, they will not report the player. If a player is not in a "restricted" zone they will not report the player.
* Standing guard
	* Stands scanning left and right 90 degrees, when player within visible range, will charge the player
	* Will not engage the player unless within 2 tiles, when player is spotted will sprint towards the kings room
	* Runs slower than a player unless said player is wearing armour
* Walking guard
	*  Walks in a straight line forward until reaches a wall, stands for 5 seconds and then returns
* The Blind guard
	* Walks with one arm on the wall, will charge the player if within 2 tiles and will run in a straight line to where a player last made a sound if the player was sprinting or shot
* Archer
	* Will spawn outside the castle, has an enormous range. 
	* Will not attack unless mission status is "detected"
	* If a player is standing within n tiles of a wall where the n ≤= wall height is and the wall is in the direction of the archer the archer will not shoot the player
	* Archer arrows are relatively inaccurate
* King
	* Once killed will drop a crown, the kingdom is now yours

> TODO add more interesting enemy types

#### Items
Starting sword
Starting pistol
Sniper rifle