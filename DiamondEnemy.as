// ===============================================================
// DiamondEnemy Derived Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The DiamondEnemy class is a derived class that requires Enemy class
// to function. The Diamond class is pre-set attributes that that will create
// a fully functional enemy object when initialized. No functions are available for this class.
//
// Constructor: DiamondEnemy()
// 
// ===============================================================

package  {
	
	import flash.display.MovieClip;
	import Enemy;
	
	
	public class DiamondEnemy extends Enemy 
	{
		
		// dimond enemy type presets
		private const DIAMOND_DAMAGE_PLAYER:int =  20; // amount of damage given to player when shape hits them
		private const DIAMOND_STARTING_HEALTH:Number =  1; // amount hits the enemy can take
		private const DIAMOND_SIZE_INCREASE:Number = 1.02; // rate the size increase every frame (multiplied)
		private const DIAMOND_START_SIZE:Number =  20; // shapes starting size when spawning
		private const DIAMOND_MAX_SIZE:Number =  280;
		private const DIAMOND_SCORE:int =  5;
		public const ENEMY_TYPE:String = "diamond";
		
		public function DiamondEnemy()
		{
			// set the diamond start size
			this.width = DIAMOND_START_SIZE;
			this.height = DIAMOND_START_SIZE;
			
			// setup the enemies unqiue characteristics for the ENEMY class
			setDamagePlayer(DIAMOND_DAMAGE_PLAYER); // setting the enemy class's damage to player 
			setHealth(DIAMOND_STARTING_HEALTH) // set the diamonds health
			setEnemyType(ENEMY_TYPE);
			setStartSize(DIAMOND_START_SIZE);
			setIncreaseSize(DIAMOND_SIZE_INCREASE);
			setDeathPoints(DIAMOND_SCORE);
			setMaxSize(DIAMOND_MAX_SIZE);
		}
	}
	
}
