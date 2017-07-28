// ===============================================================
// GameOverMenu Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The GameOverMenu class contains a game over menu movieclip as well as functions to 
// show the player's score on the menu, show/hide the menu and button functionailty to restart
// the game and or exist the game.
//
// Constructor: GameOverMenu()
//
// Public Functions:
// setFinalScore(scoreNumber:uint)
// showMenu()
// hideMenu()
// tryAgainStatus():Boolean
// 
// ===============================================================

package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class GameOverMenu extends MovieClip 
	{
		private var tryAgainClicked:Boolean;
		private const SCORE_HEADING:String = "Your Score: ";
		
		public function GameOverMenu() 
		{
			// when creating game over menu hide
			this.visible = false;
			
			// position the game over menu in the middle of the stage
			this.x = AmblyopicInvasion.getStageWidth() / 2;
			this.y =  AmblyopicInvasion.getStageHeight() / 2;
			
			//event listners for game over buttons
			this.tryAgainButton.addEventListener(MouseEvent.CLICK, loadScreen);
			this.quitButton.addEventListener(MouseEvent.CLICK, loadScreen);
			
		}
		
		private function loadScreen(evt:MouseEvent)
		{
			switch(evt.target.name)
			{
				case "tryAgainButton":
					// used to determin in try again button, a class can request the status of the button
					tryAgainClicked = true; 
				break;
				
				case "quitButton":
					MovieClip(root).gotoAndStop("mainMenu");
				
					//event listners for main menu screen buttons
					MovieClip(root).mainMenuPlayButton.addEventListener(MouseEvent.CLICK, loadScreen);
					MovieClip(root).creditsButton.addEventListener(MouseEvent.CLICK, loadScreen);
				break;
			}
		}
		
		// set the score heading for the game over menu
		public function setFinalScore(scoreNumber:uint)
		{
			this.playScoreGameOver.text = SCORE_HEADING + scoreNumber.toString();
		}
		
		// shows the game over menu
		public function showMenu()
		{
			this.visible = true;
		}
		
		// hides the game over menu
		public function hideMenu()
		{
			this.visible = false;
		}
		
		// returns the status of the try again button - if click it will return true
		public function tryAgainStatus():Boolean
		{
			return tryAgainClicked;
		}
	}
	
}
