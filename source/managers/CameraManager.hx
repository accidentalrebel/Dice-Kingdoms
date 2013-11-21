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
		normalZoomValue = FlxG.camera.zoom;						// We set the normalZoom value according to the ratio when the game is initialized
		magnifiedZoomValue = normalZoomValue * 1.5;				// Whatever the normal zoom is, the magnified zoom is 150 percent of that value
		
		// The default camera is zoomed in
		zoomIn();				
	}
	
	/**
	 * Toggles between zoomed in and zoomed out mode.
	 */
	static public function toggleZoom() 
	{
		if ( isZoomedIn )
			zoomOut();
		else
			zoomIn();
	}
	
	/**
	 * Zooms-in the camera
	 */
	static public function zoomIn() 
	{
		if ( isZoomedIn )
			return;
		
		Registry.battleLayer.setAll("scale", new FlxPoint
			(CameraManager.normalZoomValue, CameraManager.normalZoomValue));	
			
		isZoomedIn = true;
		FlxG.camera.zoom = magnifiedZoomValue;
	}
	
	/**
	 * Zooms-out the camera
	 */
	static public function zoomOut() 
	{
		if ( !isZoomedIn )
			return;
		
		Registry.battleLayer.setAll("scale", new FlxPoint
			(CameraManager.magnifiedZoomValue, CameraManager.magnifiedZoomValue));
			
		isZoomedIn = false;
		FlxG.camera.zoom = normalZoomValue;
		
		// We then reset the camera position
		FlxG.camera.scroll = new FlxPoint();		
	}
	
	/**
	 * Focuses the camera on a particular territory
	 * @param	territoryNum		the territory number to focus on
	 */
	static public function focusOnTerritory(territoryNum:Int) 
	{
		var territory : Territory = Registry.territoryManager.getTerritory(territoryNum);
		FlxG.camera.scroll = new FlxPoint(territory.centerTile.x - FlxG.width / 2 / CameraManager.magnifiedZoomValue
			, territory.centerTile.y - FlxG.height / 2 / CameraManager.magnifiedZoomValue);
	}
	
	/**
	 * Focuses the camera on a random territory owned by a particular player
	 * @param	playerNumber	the player in which we would get the random territory from
	 */
	static public function focusOnRandomTerritory(playerNumber : Int) 
	{
		var territory : Territory = Registry.territoryManager.getRandomTerritory(playerNumber);
		CameraManager.focusOnTerritory(territory.territoryNumber);
	}
}