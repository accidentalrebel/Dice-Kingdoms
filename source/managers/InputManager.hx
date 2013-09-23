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
			startTouchPos = new FlxPoint(FlxG.camera.scroll.x + FlxG.mouse.screenX, FlxG.camera.scroll.y + FlxG.mouse.screenY);
		}
		else if ( startTouchPos != null && FlxG.mouse.justReleased() )
		{
			var releasedPos = new FlxPoint(FlxG.mouse.screenX, FlxG.mouse.screenY);
			
			startTouchPos = null;
		}
		
		if ( startTouchPos != null && FlxMath.getDistance(startTouchPos, new FlxPoint(FlxG.mouse.screenX, FlxG.mouse.screenY)) > 5)
		{			
			FlxG.camera.scroll.x = (FlxG.camera.scroll.x + startTouchPos.x - FlxG.mouse.screenX) * 0.5;
			FlxG.camera.scroll.y = (FlxG.camera.scroll.y + startTouchPos.y - FlxG.mouse.screenY) * 0.5;
		}
	}
}