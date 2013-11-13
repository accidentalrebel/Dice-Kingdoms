package managers;
import flash.events.TouchEvent;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.system.input.mouse.FlxMouse;
import flixel.system.input.touch.FlxTouch;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 * ...
 * @author 
 */
class InputManager extends FlxBasic
{	
	var startTouchPos : FlxPoint = null;
	var screenDrag : Float = 0.5;
	var distanceToDrag : Float = 5;
	var isDragging:Bool = false;
	
	public function new() 
	{
		super();
	}
	
	override public function update():Void 
	{
		super.update();
		
		var distanceFromStartTouch : Float = 0;
		if ( startTouchPos != null )
			distanceFromStartTouch = FlxMath.getDistance(startTouchPos, new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
		
		if ( startTouchPos == null && FlxG.mouse.justPressed )
		{
			startTouchPos = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
		}
		else if ( startTouchPos != null && FlxG.mouse.justReleased )
		{
			if ( !isDragging && distanceFromStartTouch < distanceToDrag )			
				GameplayManager.onClick(FlxG.mouse.x, FlxG.mouse.y);			
				
			startTouchPos = null;
			isDragging = false;
		}
		
		if ( startTouchPos != null && distanceFromStartTouch > distanceToDrag)
		{			
			isDragging = true;
			FlxG.camera.scroll.x = (FlxG.camera.scroll.x + startTouchPos.x - FlxG.mouse.screenX) * screenDrag;
			FlxG.camera.scroll.y = (FlxG.camera.scroll.y + startTouchPos.y - FlxG.mouse.screenY) * screenDrag; 
		}
		
		if ( FlxG.keys.justPressed.Z )
			CameraManager.toggleZoom();
	}
}