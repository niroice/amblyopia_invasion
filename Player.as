package  {
	//import flash.text.TextField;
	import Cockpit;
	import flash.display.MovieClip;
	import flash.text.*;
	import Level;

	
	public class Player extends MovieClip {
		
		private var score:uint = 0; // holds the players score through out the game
		private var level:uint = 1; // records what level the player is up too
		private var currentShield:int = 100; // records the shield level; 0-100%
		private var cockpit:Cockpit; // cock pit image used for game
		private var scoreText:TextField; // used to display the heading "score"
		private var scoreNumber:TextField; // displays the score number
		private var levelText:TextField; // displays the heading for "level"
		private var levelNumber:TextField; // displays the level number 
		private var shieldText:TextField; // display the heading for "shield"
		private var shieldNumber:TextField; // displays the current shield left

		public function Player() 
		{
			setupCockpit();
			createShieldDisplay();
			createLevelDisplay();
			createScoreDisplay();
		}
		
		// returns the player score - used by the game over screen
		public function getScore():uint
		{
			return score;
		}
		
		// create the shield text fields (heading and shield left) - used to display in
		// the space stations cockpit
		private function createShieldDisplay()
		{
			// shield heading displays in middle moniter 
			shieldText = new TextField();
			shieldText.width = 101;
			shieldText.x = 298;
			shieldText.y = 435;
			shieldText.selectable = false;
			
			// shield heading displays in middle moniter 
			shieldNumber = new TextField();
			shieldNumber.width = 106;
			shieldNumber.x = 298;
			shieldNumber.y = 460;
			shieldNumber.selectable = false;
			
			// default font
			var dameron:Font = new _DameronEmbdedd();
			
			// setting up font properties
			var shieldFormat = new TextFormat(dameron.fontName);
			shieldFormat.color = 0xFFFFFF;
			shieldFormat.align = TextFormatAlign.CENTER;
			shieldFormat.size = "18";
			
			// assigning font properties to text field object
			shieldText.defaultTextFormat = shieldFormat;
			shieldNumber.defaultTextFormat = shieldFormat;
			
			shieldText.text = "shield"
			shieldNumber.text = currentShield +"%"
			
			
			addChild(shieldText);
			addChild(shieldNumber);
		}
		
		// create the level text fields(heading and current level number) - used to display in
		// the space stations cockpit
		private function createLevelDisplay()
		{
			// level heading displays in middle moniter 
			levelText = new TextField();
			levelText.width = 101;
			levelText.x = 457;
			levelText.y = 452;
			levelText.selectable = false;
			
			// level heading displays in middle moniter 
			levelNumber = new TextField();
			levelNumber.width = 97;
			levelNumber.x = 462;
			levelNumber.y = 472;
			levelNumber.selectable = false;
			
			// default font
			var dameron:Font = new _DameronEmbdedd();
			
			// setting up font properties
			var levelFormat = new TextFormat(dameron.fontName);
			levelFormat.color = 0xFFFFFF;
			levelFormat.align = TextFormatAlign.CENTER;
			levelFormat.size = "18";
			
			// assigning font properties to text field object
			levelText.defaultTextFormat = levelFormat;
			levelNumber.defaultTextFormat = levelFormat;
			
			levelText.text = "level"
			levelNumber.text = level.toString();
			
			
			addChild(levelText);
			addChild(levelNumber);
		}
		
		// create the score text fields(heading and current score number) - used to display in
		// the space stations cockpit
		private function createScoreDisplay()
		{
			// level heading displays in middle moniter 
			scoreText = new TextField();
			scoreText.width = 102;
			scoreText.x = 143;
			scoreText.y = 454;
			scoreText.selectable = false;
			
			// score heading displays in middle moniter 
			scoreNumber = new TextField();
			scoreNumber.width = 97;
			scoreNumber.x = 148;
			scoreNumber.y = 472;
			scoreNumber.selectable = false;
			
			// default font
			var dameron:Font = new _DameronEmbdedd();
			
			// setting up font properties
			var scoreFormat = new TextFormat(dameron.fontName);
			scoreFormat.color = 0xFFFFFF;
			scoreFormat.align = TextFormatAlign.CENTER;
			scoreFormat.size = "18";
			
			// assigning font properties to text field object
			scoreText.defaultTextFormat = scoreFormat;
			scoreNumber.defaultTextFormat = scoreFormat;
			
			scoreText.text = "score"
			scoreNumber.text = score.toString();
			
			
			addChild(scoreText);
			addChild(scoreNumber);
		}
		
		// create and setup the position of the cockpit movieclip
		private function setupCockpit()
		{
			// setup cockput - position and width
			cockpit = new Cockpit;
			cockpit.width = AmblyopicInvasion.getStageWidth(); // should take up the whole stage size
			cockpit.x = 0; // position at the very left of the screen
			cockpit.y = AmblyopicInvasion.getStageHeight(); // position at the bottom of the screen
			cockpit.mouseChildren = false;
			cockpit.mouseEnabled = false;
			
			addChild(cockpit); // make sure that background is set to the back
		}
		
		// hides the cockpit and display text fields from screen - used when player dies
		public function endGame()
		{
			cockpit.visible = false;
			scoreText.visible = false;
			scoreNumber.visible = false;
			
			levelText.visible = false;
			levelNumber.visible = false;
			
			shieldText.visible = false;
			shieldNumber.visible = false;
		}
		
		// increases the level by 1 and resets shield to 100&
		public function nextLevel()
		{
			// increase level number
			level += 1;
			
			// update the level text box
			levelNumber.text = level.toString();
			
			// set default shield to 100% for each new level
			currentShield = 100;
			shieldNumber.text = currentShield +"%"
		}
		
		// reduces the players shield  - returns boolean; false means no shield left,
		// true means shield left
		public function reduceShield(damageAmount:int)
		{
			// takes away damage from shield
			currentShield -= damageAmount;

			//update shield text box with latest shield health
			shieldNumber.text = currentShield.toString() +"%";
			
			//play animation for cockpit to flash lights
			cockpit.gotoAndPlay(2);
		}
		
		// checks to see if the player has anymore shield left - returns true if they do and
		// false if they dont
		public function getShieldLeftStatus():Boolean
		{
			if (currentShield < 1)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		// updates the players score - used when a player kills enemy
		public function increaseScore(amount:int)
		{
			score += amount;
			
			// update socre text field
			scoreNumber.text = score.toString();	
		}
		
		// descrease the players score - used when a player gets hit
		public function decreaseScore(amount:int)
		{
			score -= amount;

			// if player score is less then 1 reset it back to zero
			// as player can not have a minus score
			if (score < 1)
			{
				score = 0;
			}
			// update socre text field
			scoreNumber.text = score.toString();	
		}
	}
	
}
