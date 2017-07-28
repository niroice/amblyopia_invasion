// ===============================================================
// PauseMenu Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The PauseMenu class creates a PauseMenu object that contains a movieclip
// of a Pause Menu, a resume game button and sound on/off button. Functions will
// allow the object to be shown or hidden. All event listeners will be created by
// this class automatically.
//
// Constructor: PauseMenu(lv:Level)
// lv - pause menu requires a reference to a level object to handle event listerners
//
// Public Functions:
// createEventListiners(evt:Event)
// removeEvents()
// showPauseMenu()
// shidePauseMenu()
// 
// ===============================================================

package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import Level;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	public class PauseMenu extends MovieClip
	{
		var level:Level;
		
		public function PauseMenu(lv:Level) 
		{
			level = lv;
			
			// constructor code
			this.x = AmblyopicInvasion.getStageWidth() / 2;
			this.y = AmblyopicInvasion.getStageHeight() / 2;
			this.visible = false;
			
			// event checks to make sure stage is available before creating the key down listener
			// this avoids null error
			this.addEventListener(Event.ADDED_TO_STAGE, createEventListiners);
			
			// event listener for the resume button
			this.pauseResumeButton.addEventListener(MouseEvent.CLICK, level.resumeGame);
		}
		
		private function createEventListiners(evt:Event)
		{
			// tracks keyboard press, specificly deals with "p" for the pause menu to show
			stage.addEventListener(KeyboardEvent.KEY_DOWN, level.showPauseMenu); // triggers when a key is pressed
		}
		
		// removes all the event listeners for pause manu object - used so if set to null
		// the object will be removed from memory because there is no references left. Should be
		// used after each new level
		public function removeEvents()
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, level.showPauseMenu);
			this.pauseResumeButton.removeEventListener(MouseEvent.CLICK, level.resumeGame);
			this.removeEventListener(Event.ADDED_TO_STAGE, createEventListiners);
		}
		
		// will show the pause menu - called when the game is paused
		public function showPauseMenu()
		{
			this.visible = true;
		}
		
		// will hide the pause menu - called when game resumes
		public function hidePauseMenu()
		{
			this.visible = false;
		}

	}
	
}
