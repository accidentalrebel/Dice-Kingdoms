package managers;
import flash.events.TouchEvent;
import org.flixel.FlxBasic;
import org.flixel.FlxG;
import org.flixel.system.input.FlxMouse;
import org.flixel.system.input.FlxTouch;
import org.flixel.util.FlxMath;
import org.flixel.util.FlxPoint;

/**
 * ...
 * @author 
 */
class InputManager extends FlxBasic
{	
	var startTouchPos : FlxPoint = null;
	
	public function new() 
	{
		super();
	}
	
	override public function update():Void 
	{
		super.update();
		
		//for (tTouch in FlxG.touchManager.touches)
		//{
			//var touch : FlxTouch = tTouch;
			//if (touch.pressed())
			//{
				//GameplayManager.onClick(touch.x, touch.y);
			//}
		//}
		
		if ( startTouchPos == null && FlxG.mouse.justPressed() )
		{
			startTouchPos = new FlxPoint(FlxG.mouse.screenX, FlxG.mouse.screenY);
		}
		else if ( startTouchPos != null && FlxG.mouse.justReleased() )
		{
			var releasedPos = new FlxPoint(FlxG.mouse.screenX, FlxG.mouse.screenY);
			
			if ( FlxMath.getDistance(startTouchPos, releasedPos) > 10 )
			{
				trace("Distance is over 10");
			}
			
			startTouchPos = null;
		}
		
		if ( startTouchPos != null )
		{			
			FlxG.camera.scroll.x = FlxG.mouse.screenX - startTouchPos.x;
			FlxG.camera.scroll.y = FlxG.mouse.screenY - startTouchPos.y;
		}
	}
}