// ===============================================================
// TriangleEnemy Derived Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The TriangleEnemy class is a derived class that requires Enemy class
// to function. The TriangleEnemy class is pre-set attributes that that will create
// a fully functional enemy object when initialized. No functions are available for this class.
//
// Constructor: TriangleEnemy()
// 
// ===============================================================

package  {
	
	import flash.display.MovieClip;
	import Enemy;
	
	
	public class TriangleEnemy extends Enemy
	{
		
		// dimond enemy type presets
		private const TRIANGLE_DAMAGE_PLAYER:int =  20; // amount of damage given to player when shape hits them
		private const TRIANGLE_STARTING_HEALTH:Number =  2; // amount hits the enemy can take
		private const TRIANGLE_SIZE_INCREASE:Number = 1.015; // rate the size increase every frame (multiplied)
		private const TRIANGLE_START_SIZE:Number =  20; // shapes starting size when spawning
		private const TRIANGLE_SCORE:int =  10; // score player gets for killing triangle
		private const TRIANGLE_MAX_SIZE:int =  250; 
		public const ENEMY_TYPE:String = "triangle";
		
		public function TriangleEnemy()
		{
			// set the TRIANGLE start size
			this.width = TRIANGLE_START_SIZE;
			this.height = TRIANGLE_START_SIZE;
			
			// setup the enemies unqiue characteristics for the ENEMY class
			setDamagePlayer(TRIANGLE_DAMAGE_PLAYER); // setting the enemy class's damage to player 
			setHealth(TRIANGLE_STARTING_HEALTH) // set the TRIANGLEs health
			setEnemyType(ENEMY_TYPE);
			setStartSize(TRIANGLE_START_SIZE);
			setIncreaseSize(TRIANGLE_SIZE_INCREASE);
			setDeathPoints(TRIANGLE_SCORE);
			setMaxSize(TRIANGLE_MAX_SIZE);
			
		}
	}
	
}
