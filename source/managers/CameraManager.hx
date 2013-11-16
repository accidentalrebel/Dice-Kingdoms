package managers;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Karlo
 */
class CameraManager
{
	private static var magnifiedZoomValue : Float 	= 1.5;
	private static var normalZoomValue : Float 	= 1;
	private static var isZoomedIn : Bool = false;
	public static var guiCamera : FlxCamera;
	
	public function new() 
	{
		
	}
	
	public static function init()
	{
		// We create a guiCamera
		guiCamera = new FlxCamera(0, 0, FlxG.camera.width, FlxG.camera.height, 1);
		FlxG.cameras.add(guiCamera);
	}
	
	static public function toggleZoom() 
	{
		if ( isZoomedIn )
			zoomOut();
		else
			zoomIn();
	}
	
	static private function zoomIn() 
	{
		isZoomedIn = true;
		FlxG.camera.zoom = magnifiedZoomValue;
	}
	
	static private function zoomOut() 
	{
		isZoomedIn = false;
		FlxG.camera.zoom = normalZoomValue;
		
		// We then reset the camera position
		FlxG.camera.scroll = new FlxPoint();		
	}
}