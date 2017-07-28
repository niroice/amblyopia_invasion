// ===============================================================
// Enemy class
// Author: Bryce Lawson
// Last modified: 03-10-2016
//
// The Enemy Class is designed to be used as a base class that deals with enemy attributes and
// behaviours such its health, damage to player, distance from player, spawn
// position(randomly generated) and size. This class is best used with derived class.
// 
// Constructor: Enemy()
//
// Protected functions:
// setDamagePlayer(damage:uint)
// setHealth(health:uint)
// setIncreaseSize(number:Number)
// setEnemyType(nameEnemy:String)
// setStartSize(size:Number)
// setDeathPoints(score:int)
//
// public functions:
// increaseSize()
// getEnemyHitPlayerStatus():Boolean
// getEnemyDamagePlayer():uint
// getEnemyType():String
// enemyHit()
// stillAlive():Boolean
// getStartSize():Number
// getDeathPoints():int
// setMaxSize(size:Number)
// getPercentageMaxiumSize():Number
// 
// ===============================================================

package  
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.display.Shape;
    import flash.display.Sprite;
	
	public class Enemy extends MovieClip
	{
		private var xPosition:Number; // random start X position
		private var yPosition:Number; // random start Y position
		private var damageToPlayer:int; // damage enemy does to player
		private var currentHealth:Number; // current health of enemy
		private var enemyHitPlayer:Boolean = false;
		private var enemyType:String; // enemy type will be used for comparison
		private var enemyStartSize:Number; // stores enemy start size
		private var increaseSizeBy:Number; // used to multiple by last size
		private var deathScore:int; // the score the player gets for killing enemy
		private var hitFlag:Boolean = false;
		private var maxSize:Number;
		
		// maxium size of enemy - also means the player loses health when object reaches this size
		
		private const COCKPIT_SIZE:uint = 100;
		
		// min and maxium boundary positions for enemy spawning on x and y positions
		private const X_MIN:uint = enemyStartSize;
		private const X_MAX:uint = AmblyopicInvasion.getStageWidth();
		private const Y_MIN:uint = enemyStartSize;
		private const Y_MAX:uint = AmblyopicInvasion.getStageHeight(); // ensure enemy does spawn beind GUI
		
		// frame colour number for a blue enemy
		private const BLUE_COLOUR_FRAME:uint = 2;

		
		// constructor for enemy object
		public function Enemy() 
		{
			// set a random starting position
			setRandomSpawnPosition();
			
			// set the random colour for each object
			setRandomColour();

		}
		
		// sets a random generated starting position for the enemy object 
		private function setRandomSpawnPosition()
		{
			// x (width) starting position set
			xPosition = Math.floor(Math.random() * (X_MAX - X_MIN + 1) + X_MIN);
			
			// y (height) starting position set
			yPosition = Math.floor(Math.random() * (Y_MAX - (Y_MIN + COCKPIT_SIZE) + 1) + Y_MIN);
			
			this.x = xPosition;
			this.y = yPosition
		}
		
		// set the colour of the enemy red or blue randomly 50% chance
		private function setRandomColour()
		{
			var randomNumber:Number = Math.random();
			
			// if number is less then .5 (50% chance) display enemy as blue
			if (randomNumber < .5)
			{
				this.gotoAndStop(BLUE_COLOUR_FRAME);
			}
		}
		
		// set the enemies damage to the player
		protected function setDamagePlayer(damage:uint)
		{
			damageToPlayer =  damage;
		}
		
		// set the enemies health (number of hits before dying);
		protected function setHealth(health:uint)
		{
			currentHealth =  health;
		}
		

		// set what size the enemy will increase by in the inherited class
		protected function setIncreaseSize(number:Number)
		{
			increaseSizeBy = number;
		}
		
		
		// increase enemies size based on time passed - if the size reaches
		// past max allowed set enemyHitPlayer to true
		public function increaseSize()
		{
			// if enemy's height is less then max size allowed - increase size
			if (this.height < maxSize)
			{
				this.height = this.height * increaseSizeBy; // 1.02 * 40
				this.width = this.width * increaseSizeBy;
			}
			// if enemy size is above max allowed, set enemyHitPlayer to true
			else
			{
				enemyHitPlayer =  true;
			}
		}
		
		// returns the status of wether the enemy has reached its maxium size/hit
		// the player
		public function getEnemyHitPlayerStatus():Boolean
		{
			return enemyHitPlayer;
		}
		
		// returns enemies damage to player
		public function getEnemyDamagePlayer():uint
		{
			return damageToPlayer;
		}
		
		// takes health away from the enemy - when shot by the player
		public function enemyHit()
		{
			currentHealth -= 1; // minus off for every hit by the player
		}
		
		// returns true boolean if enemy still has health left and false if they dont
		public function stillAlive():Boolean
		{
			if (currentHealth < 1)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		// allows base class to set the enemy type
		protected function setEnemyType(nameEnemy:String)
		{
			enemyType = nameEnemy;
		}
		
		// returns the enemy type - used in the level class
		public function getEnemyType():String
		{
			return enemyType;
		}
		
		// sets teh starting size of the enemy - used be derived classes
		protected function setStartSize(size:Number)
		{
			enemyStartSize = size;
		}
		
		// returns starting size of the enemy
		public function getStartSize():Number
		{
			return enemyStartSize;
		}
		
		// sets the score the enemy is worth to the player
		protected function setDeathPoints(score:int)
		{
			deathScore = score;
		}
		
		// gets the score the enemy is worth to the player
		public function getDeathPoints():int
		{
			return deathScore;
		}
		
		// sets the maxium size allowed for the enemy
		public function setMaxSize(size:Number)
		{
			maxSize = size;
		}
		
		// returns the how close the enemy is from the player as decimal - with 1 being at the player and
		// .5 being halfway too the player
		public function getPercentageMaxiumSize():Number
		{
			return (this.width / maxSize);
		}
	}
	
}
