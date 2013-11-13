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
	private static var isZoomedIn : Bool = false;
	
	public function new() 
	{
		
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
		FlxG.camera.zoom = normalZoomValue;
	}
	
	static private function zoomOut() 
	{
		isZoomedIn = false;
		FlxG.camera.zoom = magnifiedZoomValue;
	}
}