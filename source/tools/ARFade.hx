package tools;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * Fades a given sprite to a particular alpha value.
 * This is just a substitute to the FlxTween.multivar since it is currently not working. (11/28/2013)
 * @author Karlo
 */
class ARFade extends FlxSprite
{
	var spriteToFade:FlxSprite;
	var fadeStart : Bool = false;
	var fadeDuration:Float = 0;
	var fadeTo:Float = 1;
	var isFadingIn : Bool = true;
	
	public function new()
	{
		super();
		
		this.x = -100;
		this.y = -100;
	}
	
	public function init(SpriteToFade : FlxSprite, FadeTo : Float, FadeDuration : Float) 
	{	
		this.revive();
		this.visible = true;
		this.active = true;
		
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
		
		fadeStart = true;
	}
	
	override public function update():Void 
	{
		if ( !fadeStart )
			return;	
		
		super.update();
		
		fadeDuration -= FlxG.elapsed;	
		if ( fadeDuration <= 0 )
		{
			endFade();
			return;
		}
		
		if ( isFadingIn )
		{
			if ( spriteToFade.alpha < fadeTo )
			{
				spriteToFade.alpha += FlxG.elapsed / fadeDuration;
				return;
			}
		}
		else
		{
			if ( spriteToFade.alpha > fadeTo )
			{
				spriteToFade.alpha -= FlxG.elapsed / fadeDuration;
				return;
			}
		}
	}
	
	function endFade() 
	{
		fadeStart = false;
		this.kill();
		this.visible = false;
		this.active = false;
	}
}