// ===============================================================
// AmblyopicInvasion Class
// Author: Bryce Lawson
// Last modified: 03-10-2016
//
// The AmblyopicInvasion Class is the main game class, it deals with the game's levels, menus,
// sound, player and game timing. 
//
// Constructor: AmblyopicInvasion()
//
// public functions:
// getStageWidth():uint
// getStageHeight():uintr
// 
// ===============================================================

package  {
	
	import GameSound;
	import MenuNavigation;
	import Enemy;
	import Player;
	import Level;
	import StarsBackground;
	import MenuNavigation;
	import GameSound;
	import GameOverMenu;
	import AimingReticle;
	import PauseMenu;
	import WarningMessage;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.sampler.Sample;
	

	
	public class AmblyopicInvasion extends MovieClip 
	{
		private static const STAGE_HEIGHT:uint = 500;
		private static const STAGE_WIDTH:uint = 700;
		
		// new game these will be the starting numbers for each enemy,
		// minus means they will not spawn for that level
		private const START_DIAMOND:int = 6; 
		private const START_TRIANGLE:int = -2;
		private const START_CIRCLE:int = -5; 
		private const INCREASE_ENEMY_BY =  1; // every new level enemies will increase by
		private const WARNING_MESSAGE_START_FRAME = 50; // when game starts warning message needs skip first 50 frames
		
		// used to record the current number of enemies required for that level
		// will increase as the game goes on
		private var levelDiamondNumber:int = START_DIAMOND;
		private var levelTriangleNumber:int = START_TRIANGLE;
		private var levelCircleNumber:int = START_CIRCLE;
		
		private var player:Player;
		private var newLevel:Level;
		private var background:StarsBackground;
		private var menuNavigation:MenuNavigation;
		private var gameOverMenu:GameOverMenu;
		private var aimReticle:AimingReticle;
		private var pauseMenu:PauseMenu;
		private var warningMessage:WarningMessage;
		
		private var gameContainer:Sprite;


		// document class contructor - loads when the flash file starts
		public function AmblyopicInvasion() 
		{
			//when game loads stop the timeline from moving
			stop();

			//create menu navigation object - creates eventlisners for pages and
			// controls navigation between pages
			menuNavigation = new MenuNavigation(this);
			addChild(menuNavigation);
			menuNavigation.startNavigation();
			
			// start the game sound - static class
			GameSound.playSound();
		}
		
		// starts a new game by creating relivant objects - called from the menu navigation 
		// object, when the game screem is loaded
		public function startNewGame()
		{ 
			// if game is restarting the level object will not be null
			// so clear call the eventlistiners and objects
			if (newLevel != null)
			{
				newLevel.clearLevel();
			}
			
			gameContainer = new Sprite();
			
			// event listiner checks for game changes like end of level
			addEventListener(Event.ENTER_FRAME, gameFrameHandler);
			
			// create background image
			background = new StarsBackground();
			gameContainer.addChildAt(background, 0);
			
			// create player - ship cockpit, player feedback health, level and score 
			player = new Player();
			gameContainer.addChild(player);
			
			// create game over menu - for when player dies
			gameOverMenu = new GameOverMenu();
			gameContainer.addChild(gameOverMenu);
			
			warningMessage = new WarningMessage();
			warningMessage.gotoAndPlay(WARNING_MESSAGE_START_FRAME);
			gameContainer.addChild(warningMessage);
			
			// create aim reticle
			aimReticle = new AimingReticle();
			gameContainer.addChild(aimReticle);
			
			// run levels - generate enemies, moves enemy and crosshair, check for hits
			newLevel = new Level(START_DIAMOND,START_TRIANGLE,START_CIRCLE, player, gameOverMenu, aimReticle);
			gameContainer.addChildAt(newLevel, 1);
			
			addChild(gameContainer);
		}
		
		// starts the player on the next level when called
		public function startNextLevel()
		{
			// clear previous level event listiners and objects
			newLevel.clearLevel();
			
			// increase the enemy count
			levelDiamondNumber += INCREASE_ENEMY_BY;
			levelTriangleNumber += INCREASE_ENEMY_BY;
			levelCircleNumber += INCREASE_ENEMY_BY;
			
			// set the player up for next level - show cockpit, increase health, increase level
			player.nextLevel();
			
			// hide the game over menu
			gameOverMenu.hideMenu()
			
			// run levels - generate enemies, moves enemy and crosshair, check for hits
			newLevel = new Level(levelDiamondNumber,levelTriangleNumber,levelCircleNumber, player, gameOverMenu, aimReticle);
			gameContainer.addChildAt(newLevel, 1);
			
			warningMessage.gotoAndPlay(1);
			warningMessage.visible = true;
		}
		
		private function gameFrameHandler(evt:Event)
		{
			// if level has been finished, start the nextlevel
			if (newLevel.getChangeLevelStatus() == true)
			{
				startNextLevel();
			}
			
			// if gamer over movielip -> try again button was click start a new game
			if (gameOverMenu.tryAgainStatus() == true)
			{
				//gameOverMenu = null
				startNewGame();
			}
			
			// check to make sure the level object exists before checking
			if (newLevel != null)
			{
				// calls method from level object relating to movement of enemies
				newLevel.moveGameObjects();
			}
		}
		
		// returns the width of the stage - used in level, enemy classes
		public static function getStageWidth():uint
		{
			return STAGE_WIDTH;
		}
		
		// returns the height of the stage - used in level, enemy classes
		public static function getStageHeight():uint
		{
			return STAGE_HEIGHT;
		}
	}
	
}

