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
	var fadeAmountPerUpdate : Float = 0;
	
	public function new()
	{
		super();
	}
	
	public function init(SpriteToFade : FlxSprite, FadeTo : Float, FadeDuration : Float) 
	{	
		this.revive();
		
		fadeStart = false;
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
		else
			isFadingIn = true;
		
		fadeAmountPerUpdate = Math.abs(spriteToFade.alpha - fadeTo) / fadeDuration;
		fadeStart = true;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if ( !fadeStart )
			return;	
		
		fadeDuration -= FlxG.elapsed;	
		if ( fadeDuration <= 0 )
		{
			endFade();
			return;
		}
		
		if ( isFadingIn )
		{
			if ( spriteToFade.alpha > fadeTo )
			{
				endFade();
				return;
			}
			
			spriteToFade.alpha += fadeAmountPerUpdate * FlxG.elapsed;
		}
		else
		{
			fadeDuration -= FlxG.elapsed;
			
			if ( spriteToFade.alpha < fadeTo )
			{
				endFade();
				return;
			}
			
			spriteToFade.alpha -= fadeAmountPerUpdate * FlxG.elapsed;
		}
	}
	
	function endFade() 
	{
		trace("KILLED");
		fadeStart = false;
		this.kill();
	}
}