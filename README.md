# Zelda Lite Assignment

<img src="ScreenCaptures/TitleScreen.png" width="70%">

## Description
The task of the assignment was to add random generation of ceramic pots, that are able to be picked up, thrown and shatter upon impact on gameobjects. These thrown pots should
have the ability to damage and defeat enemies in the game. Another task of the assignment was letting defeated enemies drop hearts for the user to heal from. The game is a dungeon crawling game where each room is procedurally generated, putting a random amount of enemies and ceramic pots where the player has to trigger a floor button to open the doors to proceed to the next dungeon room.

### Challenges Faced
- Creating new different game object types to work withs the existing code and how I should implement it with the existing source code.
- Creating multiple game states for the player character to enable the throwing of the ceramic pots
- Focusing on data driven design. A consequence of this would be extracting the correct portion of the sprite sheet to animate the player character.

### Screenshots
<img src="ScreenCaptures/HeartSpawn.png" width="70%">

- After killing a character there is a chance that a heart will spawn, healing the player one heart.
<br><br/>

<img src="ScreenCaptures/CarryAround.png" width="70%">

- When you press enter to pick up a pot, it changes the character state, preventing the user from swinging the sword. But it will let you throw pots in your hand if you were to press enter again.
<br><br/>

<img src="ScreenCaptures/CollissionTypes.png" width="70%">

- After pots collide with game object they will break preventing the player from picking up the pot again
- Throwing pots and when they collide with enemies killing them
- After a certain distance the pot will "fall" to the ground and break
- The pot will break when colliding with the wall of the dungeon
<br><br/>

<img src="ScreenCaptures/DebugMode.png" width="70%">

- Although the assignment came with the ability to debug, by letting hitboxes render they did not provide a debug mode.
- Created a debug mode, with additional hitboxes (eg.Pickup pot hitbox) or other player stats.


### Credit
This project was created following the Havard cs50 Game Design course. Here is a [link](https://youtu.be/GfwpRU0cT10) to their first lecture where more information could be found.
