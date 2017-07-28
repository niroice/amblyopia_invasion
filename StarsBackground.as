// ===============================================================
// StarsBackground Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The StarsBackground class creates a movielip image of a space-background
// with stars. The object will automatically be centred to the stage when intialized.
//
// Constructor: StarsBackground()
// 
// ===============================================================

package  {
	
	import flash.display.MovieClip;
	
	public class StarsBackground extends MovieClip {
		
		
		public function StarsBackground() 
		{
			// setup cockput - position, width
			this.width = AmblyopicInvasion.getStageWidth(); // should take up the whole stage size
			this.height = AmblyopicInvasion.getStageHeight(); // should take up the whole stage size
			this.x = AmblyopicInvasion.getStageWidth() / 2; // position in the middle of stage
			this.y = AmblyopicInvasion.getStageHeight() / 2; // position in the middle of stage
		}
	}
	
}

