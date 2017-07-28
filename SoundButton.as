// ===============================================================
// SoundButton  Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The SoundButton class creates a sound button, that works in conjuction
// with the GameSound Class to control the music in the game. When intialised
// this button will automatically add event listerner using the GameSound classes
// functionality. Clicking the button will ethier turn the music on or off.
//
// Constructor: SoundButton()
// 
// ===============================================================

package  {
	
	import flash.display.MovieClip;
	import GameSound;
	import flash.events.MouseEvent;
	import flash.display.*;
	import flash.events.*;

	
	// class creates a sound button instance that uses the GameSound class to control all the sound in the game
	public class SoundButton extends MovieClip {
		
		
		public function SoundButton() {
			// constructor code
			
			//Event Listeners - turns sound ethier on or off - runs methods in the GameSound Class
			this.addEventListener(MouseEvent.CLICK, GameSound.soundCheck); //turns sound on/off
		}
		

	}
	
}
