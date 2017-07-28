// ===============================================================
// AimingRecticle Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The AimingRecticle class creates a movielip image of a aiming-reticle
// that will replace the mouse cursor with the aiming-reticle. Functions allow
// the aiming-reticle to be shown and hidden as required.
//
// Constructor: AimingReticle()
//
// Public Functions:
// showReticle()
// hideReticle()
// 
// ===============================================================

package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class AimingReticle extends MovieClip
	{
		
		public function AimingReticle()
		{
			// constructor code
			
		}
		
		// disables mouse icon and sets the reticle to show/follow mouse
		public function showReticle()//evt:Event)
		{
				Mouse.hide();
				this.startDrag(true);
				this.visible = true;
		}
		
		// enable mouse icon and stop recticle following mouse
		public function hideReticle()//evt:Event)
		{
			Mouse.show();
			this.stopDrag();
			this.visible = false;
		}
	}
	
}
