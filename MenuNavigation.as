package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.utils.*;
	import AmblyopicInvasion;
	
	public class MenuNavigation extends MovieClip 
	{
		private var game:AmblyopicInvasion;

		public function MenuNavigation(Game:AmblyopicInvasion)
		{
			// getting reference  to game object (AmblyopicInvasion) - to
			// start the game when the game screen loads
			game = Game;
		}
		
		public function startNavigation()
		{
			//event listners for main menu screen buttons
			MovieClip(root).mainMenuPlayButton.addEventListener(MouseEvent.CLICK, loadScreen);
			MovieClip(root).creditsButton.addEventListener(MouseEvent.CLICK, loadScreen);
		}

		// function deals with button navigation handling between frames, loads event listiners
		// for buttons when the page loads
		private function loadScreen(evt:MouseEvent)
		{
			switch(evt.target.name)
			{
				case "mainMenuPlayButton":
					MovieClip(root).gotoAndStop("aboutGame");
				
					//event listners for about game screen buttons
					MovieClip(root).aboutNextButton.addEventListener(MouseEvent.CLICK, loadScreen);
					MovieClip(root).aboutBackButton.addEventListener(MouseEvent.CLICK, loadScreen);
				break;
				
				case "creditsButton":
					MovieClip(root).gotoAndStop("credits");
				
					//event listners for credits page button
					MovieClip(root).creditsBackButton.addEventListener(MouseEvent.CLICK, loadScreen);
				break;
				
				case "aboutNextButton":
					MovieClip(root).gotoAndStop("instructions");
				
					//event listners for instructions screen button
					MovieClip(root).instructionsPlayButton.addEventListener(MouseEvent.CLICK, loadScreen);
					MovieClip(root).instructionsBackButton.addEventListener(MouseEvent.CLICK, loadScreen);
				break;
				
				case "aboutBackButton":
					MovieClip(root).gotoAndStop("mainMenu");
				
					//event listners for main menu screen buttons
					MovieClip(root).mainMenuPlayButton.addEventListener(MouseEvent.CLICK, loadScreen);
					MovieClip(root).creditsButton.addEventListener(MouseEvent.CLICK, loadScreen);
				break;
				
				case "instructionsBackButton":
					MovieClip(root).gotoAndStop("aboutGame");
				
					//event listners for about game screen buttons
					MovieClip(root).aboutNextButton.addEventListener(MouseEvent.CLICK, loadScreen);
					MovieClip(root).aboutBackButton.addEventListener(MouseEvent.CLICK, loadScreen);
				break;
				
				case "instructionsPlayButton":
					MovieClip(root).gotoAndStop("game");
					
					// start the game
					game.startNewGame();
				break;
				
				case "creditsBackButton":
					MovieClip(root).gotoAndStop("mainMenu");
				
					//event listners for main menu screen buttons
					MovieClip(root).mainMenuPlayButton.addEventListener(MouseEvent.CLICK, loadScreen);
					MovieClip(root).creditsButton.addEventListener(MouseEvent.CLICK, loadScreen);
				break;
				
				case "tryAgainButton":
					MovieClip(root).gotoAndStop("game");
				break;
				
				case "quitButton":
					MovieClip(root).gotoAndStop("mainMenu");
				
					//event listners for main menu screen buttons
					MovieClip(root).mainMenuPlayButton.addEventListener(MouseEvent.CLICK, loadScreen);
					MovieClip(root).creditsButton.addEventListener(MouseEvent.CLICK, loadScreen);
				break;
			}
		}
	}
}
