package tools;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

/**
 * Fades a given sprite to a particular alpha value.
 * This is just a substitute to the FlxTween.multivar since it is currently not working. (11/28/2013)
 * @author Karlo
 */
class ARFade extends FlxBasic
{
	var spriteToFade:FlxSprite;
	var fadeStart : Bool = false;
	var fadeDuration:Float = 0;
	var fadeTo:Float = 1;
	var isFadingIn : Bool = true;

	public function new()
	{
		super();
	}
	
	public function init(SpriteToFade : FlxSprite, FadeTo : Float, FadeDuration : Float) 
	{	
		spriteToFade = SpriteToFade;
		fadeDuration = FadeDuration;
		fadeTo = FadeTo;
		
		if ( spriteToFade.alpha == fadeTo )
		{
			endFade();
			return;
		}
		else if ( spriteToFade.alpha > fadeTo )
			isFadingIn = false;
		
		fadeStart = true;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if ( !fadeStart )
			return;	
		
		trace(fadeDuration);
		fadeDuration -= FlxG.elapsed;	
		trace("@" + fadeDuration);
		if ( fadeDuration <= 0 )
		{
			trace("Fade duration done");
			endFade();
			return;
		}
		
		if ( isFadingIn )
		{
			if ( spriteToFade.alpha >= fadeTo )
			{
				trace("END");
				endFade();
				return;
			}
			
			trace("alphaong");
			spriteToFade.alpha += FlxG.elapsed;
		}
		else
		{
			fadeDuration -= FlxG.elapsed;
			
			if ( spriteToFade.alpha <= fadeTo )
			{
				trace("END2");
				endFade();
				return;
			}
			
			trace("alphaing");
			spriteToFade.alpha -= FlxG.elapsed;
		}
	}
	
	function endFade() 
	{
		fadeStart = false;
		this.kill();
	}
}