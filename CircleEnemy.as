// ===============================================================
// CircleEnemy Derived Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The CircleEnemy class is a derived class that requires Enemy class
// to function. The CircleEnemy class is pre-set attributes that that will create
// a fully functional enemy object when initialized. No functions are available for this class.
//
// Constructor: CircleEnemy()
// 
// ===============================================================


package  {
	
	import flash.display.MovieClip;
	import Enemy;
	
	
	public class CircleEnemy extends Enemy {
		
		// dimond enemy type presets
		private const CIRCLE_DAMAGE_PLAYER:int =  50; // amount of damage given to player when shape hits them
		private const CIRCLE_STARTING_HEALTH:Number =  5; // amount hits the enemy can take
		private const CIRCLE_SIZE_INCREASE:Number = 1.01; // rate its size will increase every frame (multiplied)
		private const CIRCLE_START_SIZE:Number =  20; // shapes starting size when spawning
		private const CIRCLE_MAX_SIZE:Number =  300;
		private const CIRCLE_SCORE:int =  20;
		public const ENEMY_TYPE:String = "circle";
		
		public function CircleEnemy() 
		{
			// set the CIRCLE start size
			this.width = CIRCLE_START_SIZE;
			this.height = CIRCLE_START_SIZE;
			
			// setup the enemies unqiue characteristics for the ENEMY class
			setDamagePlayer(CIRCLE_DAMAGE_PLAYER); // setting the enemy class's damage to player 
			setHealth(CIRCLE_STARTING_HEALTH) // set the CIRCLEs health
			setEnemyType(ENEMY_TYPE);
			setStartSize(CIRCLE_START_SIZE);
			setIncreaseSize(CIRCLE_SIZE_INCREASE);
			setDeathPoints(CIRCLE_SCORE);
			setMaxSize(CIRCLE_MAX_SIZE);
		}
	}
	
}
