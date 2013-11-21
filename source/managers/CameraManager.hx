package managers;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.util.FlxPoint;
import objects.Territory;

/**
 * ...
 * @author Karlo
 */
class CameraManager
{
	public static var magnifiedZoomValue : Float 	= 1.5;
	public static var normalZoomValue : Float 		= 1;
	private static var isZoomedIn : Bool = false;
	
	static public function init() 
	{
		zoomIn();
	}
	
	static public function toggleZoom() 
	{
		if ( isZoomedIn )
			zoomOut();
		else
			zoomIn();
	}
	
	static public function focusOnTerritory(territoryNum:Int) 
	{
		var territory : Territory = Registry.territoryManager.getTerritory(territoryNum);
		FlxG.camera.scroll = new FlxPoint(territory.centerTile.x - FlxG.width / 2 / CameraManager.magnifiedZoomValue
			, territory.centerTile.y - FlxG.height / 2 / CameraManager.magnifiedZoomValue);
	}
	
	static public function zoomIn() 
	{
		if ( isZoomedIn )
			return;
		
		Registry.battleLayer.setAll("scale", new FlxPoint(CameraManager.normalZoomValue, CameraManager.normalZoomValue));	
			
		isZoomedIn = true;
		FlxG.camera.zoom = magnifiedZoomValue;
	}
	
	static public function zoomOut() 
	{
		if ( !isZoomedIn )
			return;
		
		Registry.battleLayer.setAll("scale", new FlxPoint(CameraManager.magnifiedZoomValue, CameraManager.magnifiedZoomValue));
			
		isZoomedIn = false;
		FlxG.camera.zoom = normalZoomValue;
		
		// We then reset the camera position
		FlxG.camera.scroll = new FlxPoint();		
	}
}