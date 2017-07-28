// ===============================================================
// GameSound Static Class
// Author: Bryce Lawson
// Last modified: 04-10-2016
//
// The GameSound class controls all the music and sounds in the game. It is a 
// static class that does not need to be intialised to be used. Sounds can be played 
// such as a lazer blast, an explosion and retro background music that will keep 
// playing indefinitly.
//
// Constructor: No constructor
//
// Public Functions:
// soundCheck(evt:MouseEvent)
// playSound()
// setVolume(vol:int)
// playLazerBlast()
// playPlayerHitSound()
// 
// ===============================================================


package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import LazerBlast;
	
	// static class - handles all the music in the game example play and pause all music
	// class works with SoundButton Class instances
	public class GameSound extends MovieClip
	{
		private static var mainMusicOn:Boolean =  true; // state of the sound button, default it is on
		
		// creating new background music object
		private static var backgroundMusic:BackgroundMusic = new BackgroundMusic();
		
		//private var mainMusic:MainBackgroundMusic = new MainBackgroundMusic(); // main menu soundobject created
		private static var mainMusicChannel:SoundChannel;
		
		private static var lazerBlast:LazerBlast = new LazerBlast();
		
		private static var playerHitBang:PlayerHitSound = new PlayerHitSound();
		

		public function GameSound()
		{
			// static class dont need anything for constructor
		}
		
		public static function soundCheck(evt:MouseEvent)
		{
			// if music is not on, then turn it on
			if (mainMusicOn == false)
			{
				// change volume of sound too full volume
				setVolume(1);
				
				// change button image
				evt.currentTarget.mainSoundIcon.gotoAndStop(1);
				
				mainMusicOn = true; // set the music state to on
			}
			// if music is on, then turn it off
			else if (mainMusicOn == true)
			{
				// change volume of sound to mute (zero)
				setVolume(0);
				
				// change button image
				evt.currentTarget.mainSoundIcon.gotoAndStop(2);
				
				mainMusicOn = false;
			}
		}
		
		// plays the main background music, repeats 99999 times
		public static function playSound()
		{
			mainMusicChannel = backgroundMusic.play(0, 99999);
		}
		
		// use to change volume of the music/mute all the sounds in the game
		public static function setVolume(vol:int)
		{
			var sTransform:SoundTransform = new SoundTransform(1,0);
			sTransform.volume = vol;
			SoundMixer.soundTransform = sTransform;
		}
		
		// plays a lazer blast sound - used when shooting
		public static function playLazerBlast()
		{
			lazerBlast.play();
		}
		
		// plays a metal banging sound - used when player gets hit
		public static function playPlayerHitSound()
		{
			playerHitBang.play();
		}
		
	}
	
}
