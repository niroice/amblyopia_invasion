// ===============================================================
// Level class
// Author: Bryce Lawson
// Last modified: 05-10-2016
//
// The Level class creates deals with the interaction of objects that make
// make up the game's level. It deals with player controls,
// handling enemy behaviours and game pausing/resuming.
//
// Constructor: Level(NumberDiamonds:int, NumberTriangles:int, NumberCircle:int, 
// playerObj:Player, GameOver:GameOverMenu, recticle:AimingReticle)
// NumberDiamonds - is the number of diamond enemies that will spawn for this level.
// NumberTriangles - is the number of Triangle enemies that will spawn for this level.
// NumberCircle - is the number of Circle enemies that will spawn for this level.
// playerObj - requires a reference from a Player object - to handle scoring and the player's shield 
// GameOver - requires a reference from a GamerOverObject - to handle when player dies
// recticle - requires a reference from a Reticle object - this is for aiming with the mouse
//
// Public Methods:
// Level()
// showPauseMenu(MouseEvent)
// pauseReleaseTimers()
// resumeGame(MouseEvent)
// moveGameObjects()
// getChangeLevelStatus():Boolean
// clearLevel()
// 
// ===============================================================

package  {
	
	import AimingReticle;
	import DiamondEnemy;
	import TriangleEnemy;
	import CircleEnemy;
	import Player;
	import GameOverMenu;
	import PauseMenu;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Mouse;

	
	public class Level extends MovieClip {
		
		private const START_DELAY_SECONDS:uint = 10000; // number seonds delay between game starting for each level
		private const LEVEL_TIME:uint = 60000; // rough time frame enemies should be released in 
		private const P_KEYCODE:uint = 80; // id code for the keyboard key "p"
		
		private var enemyOnScreenArray:Array = new Array(); // enemies on the screen will be stored here
		private var enemyNotReleasedArray:Array = new Array();// enemies on on screen will be stored here
		private var releaseTimersArray:Array = new Array(); // store all the release timer events
		private var startDelay:Timer; // each level will have a short delay before starting this will control it
		private var enemyOnScreen: Sprite; // all enemies wil be stored here when placed on screen
		private var numberEnemy: int = 0; // will be used to determain how many times releaseEnemytimer must repeat
		private var player:Player; // player object will be passed in with the constructor
		private var aimingReticle:AimingReticle; // recticle follows mouse around the screen
		private var gameOverMenu:GameOverMenu; // game over movieclip will show when player dies
		private var explosion:Explosion; // plays soon as player dies for effect
		private var nextLevelBoolean: Boolean; // used to tell if next level should be loaded
		private var gamePausedBoolean:Boolean; // used to tell functions like move that game is paused
		private var pauseMenu:PauseMenu; // pause menu movieclip, displays when game is paused
		

		public function Level(NumberDiamonds:int, NumberTriangles:int, NumberCircle:int, playerObj:Player,
			GameOver:GameOverMenu, recticle:AimingReticle) 
		{
			player = playerObj;
			
			gameOverMenu = GameOver;
			
			//initalizing recticle to follow on the screen
			aimingReticle = recticle;
			
			// calculate number of enemies being requested in total - make sure no negative numbers
			// are being processed otherwise enemies will not appear randomly
			if (NumberDiamonds > 0)
			{
				numberEnemy += NumberDiamonds;
			}
			if (NumberTriangles > 0)
			{
				numberEnemy += NumberTriangles;
			}
			if (NumberCircle > 0)
			{
				numberEnemy += NumberCircle;
			}
			
			// load the required enemies into the array
			loadEnemyArray(NumberDiamonds, NumberTriangles, NumberCircle);
			
			// create delay timer before enemies can start appearing on screen
			startDelay = new Timer(START_DELAY_SECONDS,1);
			
			// set eventlistener that once delay finishes - start releasing enemies
			startDelay.addEventListener(TimerEvent.TIMER_COMPLETE, startEnemyRelease);
			startDelay.start();
			
			//setup up sprite, for enemies that will appear on the screen
			enemyOnScreen = new Sprite();
			addChild(enemyOnScreen);
			
			// mouse right click event - will check to see if current mouse position is over
			// enemy and remove it. It will only remove the enemy that is closest to sceen
			addEventListener(MouseEvent.CLICK, ShotEnemyCheck);
			
			// create pause menu object ***********check to remove
			pauseMenu = new PauseMenu(this);
			addChild(pauseMenu);
			

		}
		
		// stops all release timers - so enemies do not release to the screen
		private function pauseReleaseTimers()
		{
			// checking to make sure the release timer is not null, when pause menu activates
			if (releaseTimersArray != null)
			{
				for (var i:uint = 0; i < releaseTimersArray.length; i++)
				{
					releaseTimersArray[i].stop();
				}
			}
		}
		
		// resumes all release timers - so enemies will continue to be released
		private function resumeReleaseTimers()
		{
			// makes sure the releaseTimerArray is not null. Bug found when pause menu
			// de-activates and runs this function - if there is no more enemies to release
			// a null error apppears. This fixes that problem by checking before hand.
			if (releaseTimersArray != null)
			{
				for (var i:uint = 0; i < releaseTimersArray.length; i++)
				{
					releaseTimersArray[i].start();
				}
			}
		}
		
		// triggers when the "p" keyboard button is presed, shows pause menu and stops the game
		public function showPauseMenu(key:KeyboardEvent)
		{
			// if letter P was pressed  - set the pause variable too true AND
			// show the pause menu
			if (key.keyCode == P_KEYCODE)
			{
				// if the  pause menu object has been removed from the memory by the garbage collector
				// create a new one - bug found that it is randomly being removed
				if (pauseMenu == null)
				{
					//removeChild(pauseMenu);
					pauseMenu = new PauseMenu(this);
					addChild(pauseMenu);
				}
				pauseReleaseTimers(); // pause enemy release timers so they dont keep appearing
				gamePausedBoolean = true; // set game state to pause
				pauseMenu.showPauseMenu();
			}
		}
		
		// triggers when the "p" keyboard button is presed, creases a pause menu and stops the game
		public function resumeGame(evt:MouseEvent)
		{
			gamePausedBoolean = false; // set game state to not paused
			pauseMenu.hidePauseMenu(); // hide the pause menu
			resumeReleaseTimers(); // resume enemy releasing to screen
		}
		
		// creates the requested number of enemies type into enemyNotReleasedArray so they can be released later
		private function loadEnemyArray(numDiamonds:int, numTriangle:int, numCircle:int)
		{
			// use requested number of diamonds enemies - to create diamond enemy objects
			if (numDiamonds > 0) // check is to ensure no minus numbers are proccessed
			{
				for (var i:uint = 0; i < numDiamonds; i++)
				{
					var diamond:DiamondEnemy = new DiamondEnemy();
					enemyNotReleasedArray.push(diamond);
				}
			}
			
			// use requested number of triangle enemies - to create triangle enemy objects
			if (numTriangle > 0) // check is to ensure no minus numbers are proccessed
			{
				for (var j:uint = 0; j < numTriangle; j++)
				{
					var triangle:TriangleEnemy = new TriangleEnemy();
					enemyNotReleasedArray.push(triangle);
				}
			}
			
			// use requested number triangle enemies - to create triangle enemy objects
			if (numCircle > 0)
			{
				for (var k:uint = 0; k < numCircle; k++)
				{
					var circle:CircleEnemy = new CircleEnemy();
					enemyNotReleasedArray.push(circle);
				}
			}	
		}
		
		// releases all the enemies at different random times within 60 seconds
		private function startEnemyRelease(evt:TimerEvent)
		{
			// check to make sure game isnt paused before releasing enemies to the screen
			if (gamePausedBoolean == false)
			{
				// combines all the release times as the loop goes through array
				var lastReleaseTime:uint = 0;
				
				for(var i:uint = 0; i < enemyNotReleasedArray.length; i++)
				{
					// random time for enemies to be release based on time limit 60 seconds and number enemies
					var newReleaseTime:uint = Math.ceil(Math.random() * (LEVEL_TIME / numberEnemy));
					
					//combines last enemy release and new release time 
					lastReleaseTime += newReleaseTime;
					
					// new enemy release timer uses random time and triggers once
					var enemyReleaseDelay:Timer = new Timer(lastReleaseTime, 1);
					
					// store the timer in array so if game needs to be paused it can be accessed
					releaseTimersArray[i] = enemyReleaseDelay;
					
					// add event listener to timer
					enemyReleaseDelay.addEventListener(TimerEvent.TIMER_COMPLETE, releaseRandomEnemy);
					enemyReleaseDelay.start();
				}
			}
		}
		
		// selects a random enemy from enemyNotReleasedArray and resizes the array so enemy is no longer in it
		private function releaseRandomEnemy(evt:TimerEvent)
		{
			// check to make sure 
			if (enemyNotReleasedArray != null)
			{
				var arrayLength:uint = enemyNotReleasedArray.length;
				
				// check make sure array is not empty, if empy level is over
				if (arrayLength > 0)
				{
					var randomArrayIndex = Math.ceil(Math.random() * arrayLength) -1;
					
					// add enemy to on screen array - at the begining (index 0)
					enemyOnScreenArray.unshift(enemyNotReleasedArray[randomArrayIndex]);
					
					//add enemy to the screen - make sure new enemy is behind others by placing it
					// on index 0
					enemyOnScreen.addChildAt(enemyNotReleasedArray[randomArrayIndex], 0);

					//remove the enemy from array
					enemyNotReleasedArray.splice(randomArrayIndex, 1)
				}
				// keep the aiming reticle at the front (z-index) when a new enemy is creates
				addChild(aimingReticle);
			}
		}
		
		// stops all enemies moving on the screen - freezing them, loads game over object
		private function endGame()
		{
			// set pause game boolean to true - will enemy movement, spawning, shooting and 
			// hide mouse reticle
			gamePausedBoolean = true;
			
			// stop enemies from releasing
			pauseReleaseTimers();
			
			// set the game over menus player score
			gameOverMenu.setFinalScore(player.getScore());
			
			// show the game over menu
			gameOverMenu.showMenu();
			
			// show end explosion movieclip
			explosion = new Explosion();
			addChild(explosion);
			
			// hide the cockpit once explosion happens
			player.endGame();
			
		}
		
		// enemies types will move at different speeds - this function will will compare each enemy against one another
		// to determain who is closet to the player. If the comparing enemy is positioned behind the other enemy (lower z-index)
		// but is close to the player - this funciton will swap their z-index values, so that enemy is in front.
		private function checkPositionObjects()
		{
			// loop through all enemies on the screen
			for (var i:uint = 0; i < enemyOnScreenArray.length; i++)
			{
				// loop again through all enemies to compare against each other
				for (var j:uint = 0; j < enemyOnScreenArray.length; j++)
				{
					// if enemy type are the same do not check, as they will be moving at the same speed
					if (enemyOnScreenArray[i].getEnemyType() != enemyOnScreenArray[j].getEnemyType())
					{
						// make sure same enemy is not being compared AND the current enemies (i) z-index is less then the comparing z-index
						// otherwise there is no need to compare
						if ((enemyOnScreenArray[i] != enemyOnScreenArray[j]) && 
							(enemyOnScreen.getChildIndex(enemyOnScreenArray[i]) < enemyOnScreen.getChildIndex(enemyOnScreenArray[j])))
						{
							// this compares the current enemy's (i) percentage of maxium size (how close it is to player - 100% being at the 
							// player hitting them) against the other enemy (j) position from the player. If (i) is closer
							// switch the z-index positions so its at the front
							if (enemyOnScreenArray[i].getPercentageMaxiumSize() > enemyOnScreenArray[j].getPercentageMaxiumSize())
							{
								enemyOnScreen.swapChildren(enemyOnScreenArray[i], enemyOnScreenArray[j]); // swap z-index
							}
						}
					}
				}
			}
		}
		
		// move game objects around the screen - controlled by AmblyopiaClass
		public function moveGameObjects()
		{
			// check to make sure game isnt paused
			if (gamePausedBoolean == false)
			{
				moveEnemy(); // move every enemy - check for collision with player
				checkPositionObjects(); // check position of enemies (z-indexs)
				checkEnemyLeft(); // check if game has any more enemies - if set end game boolean to true
				aimingReticle.showReticle(); // keeps the aiming reticle on the screen
			}
			else // if game is paused hide aiming reticle and show mouse
			{
				aimingReticle.hideReticle();
			}
		}
		
		// checks to see if there is any more enemies left - if there is none
		// the level objects nextlevel boolean will be set to true
		private function checkEnemyLeft()
		{
			// if both enemy on screen and enemy not on screen arrays are empty change status to true
			// as this means there are no more enemies left
			if ((enemyOnScreenArray.length == 0) && (enemyNotReleasedArray.length == 0))
			{
				nextLevelBoolean = true;
			}
		}
		
		// returns nextLevelBoolean status - which indicates if the level should be changed
		public function getChangeLevelStatus():Boolean
		{
			return nextLevelBoolean;
		}
		
		private function moveEnemy()
		{
			for (var i:uint = 0; i < enemyOnScreenArray.length; i++)
			{
				// make sure enemy has not already been removed
				if (enemyOnScreenArray[i] != null)
				{
					//increase enemy size
					enemyOnScreenArray[i].increaseSize();
					
					// check to see if enemy has hit the player (reach passed maxium size allowed)
					// returns true if hit
					if (enemyOnScreenArray[i].getEnemyHitPlayerStatus())
					{
						// play banging sound
						GameSound.playPlayerHitSound();
						
						//take away players score for getting hit
						player.decreaseScore(enemyOnScreenArray[i].getDeathPoints());
						
						//take away players health based how much damage the enemy does AND
						// return true if player is still alive or false if dead
						player.reduceShield(enemyOnScreenArray[i].getEnemyDamagePlayer());
						
						// remove enemy from screen by removing from sprite
						enemyOnScreen.removeChild(enemyOnScreenArray[i]);
						
						// remove enemy from on screen array
						enemyOnScreenArray.splice(i,1);
					}
					// check see if player has life left, if no end end the game
					if (!player.getShieldLeftStatus())
					{
						endGame();
					}
				}
			}
		}
		
		// check see the current mouse position when mouse button clicked, has an enemy at that location.
		//  if there are two enemies in the one location, only the enemy closest too the player will be 
		// taken off the screen.
		private function ShotEnemyCheck(evt:MouseEvent)
		{
			// check to make sure the game isnt paused before running method
			if (!gamePausedBoolean)
			{
				var hitEnemyIndexArray:Array = new Array(); // stores index number of enemies shot
				var highestZindexIndexNumber:int; // stores index number of enemy to be removed from screen
				var enemyWasShotBoolean:Boolean = false;
				
				// default highest z-index will be -2, this way the first z-index will always be recorded
				var highestZindex:int = -2; 

				// play lazer blast sound
				GameSound.playLazerBlast();
				
				// loop through all enemies on the screen
				for (var i:uint = 0; i < enemyOnScreenArray.length; i++)
				{
					// if current mouse position is over the enemy - store its index number
					if (enemyOnScreenArray[i].hitTestPoint(mouseX,mouseY,true)) 
					{
						// add hit enemy's index number into the array
						hitEnemyIndexArray.push(i);
						
						// need to set true so enemy will be removed
						enemyWasShotBoolean =  true;
					}
				}
					
				// if an enemy was shot - continue
				if (enemyWasShotBoolean == true)
				{
					// loop through hit enemies and check for enemy with largest index number
					// and remove the enemy from the screen - as the closet enemy will be the one hit
					for (var j:uint = 0; j < hitEnemyIndexArray.length; j++)
					{
						// gets z-index number based on the index provided in hitEnemyArray
						var currentZindex = enemyOnScreen.getChildIndex(enemyOnScreenArray[hitEnemyIndexArray[j]]);
						
						//if current Z-index is higher than the last - stored the enemies z-index number and index number
						if (currentZindex > highestZindex)
						{
							highestZindex = currentZindex;
							
							highestZindexIndexNumber = hitEnemyIndexArray[j];
						}
					}
					// take away one health from enemy the shot enemy
					enemyOnScreenArray[highestZindexIndexNumber].enemyHit()
					
					// remove the enemy from the screen if enemy health is below zero/not alive
					if (enemyOnScreenArray[highestZindexIndexNumber].stillAlive() == false)
					{
						// updates player score for killing the enemy
						player.increaseScore(enemyOnScreenArray[highestZindexIndexNumber].getDeathPoints());
						
						enemyOnScreen.removeChildAt(highestZindex); // remove the enemy from screen
						enemyOnScreenArray.splice(highestZindexIndexNumber, 1); // remove enemy from on screen array
					}                                                                                  
				}
			}
		}
		
		// will remove all event listiners and object for the particular level - should run
		// when the level has finished due to death or complettion
		public function clearLevel()
		{
			// remove all eventlisteners
			pauseMenu.removeEvents();
			startDelay.removeEventListener(TimerEvent.TIMER_COMPLETE, startEnemyRelease);
			removeEventListener(MouseEvent.CLICK, ShotEnemyCheck);
			
			
			//remove objects from stage
			removeChild(enemyOnScreen);
			removeChild(pauseMenu);
			
			// null objects not needed
			startDelay = null;
			enemyNotReleasedArray = null;
			enemyOnScreen = null;
			pauseMenu = null;
			releaseTimersArray =  null;
		}
	}
	
}
