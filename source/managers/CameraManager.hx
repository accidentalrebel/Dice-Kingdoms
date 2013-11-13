package managers;
import flixel.FlxG;

/**
 * ...
 * @author Karlo
 */
class CameraManager
{
	private static var magnifiedZoomValue : Float 	= 1.5;
	private static var normalZoomValue : Float 	= 1;

	public function new() 
	{
		
	}
	
	static public function toggleZoom() 
	{
		if ( FlxG.camera.zoom == normalZoomValue )
			FlxG.camera.zoom = magnifiedZoomValue;
		else
			FlxG.camera.zoom = normalZoomValue;
	}
	
	
	
}