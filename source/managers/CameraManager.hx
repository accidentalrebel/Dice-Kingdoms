package managers;
import flash.Lib;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.util.FlxPoint;
import layers.PlayAreaLayer;
import objects.HexaTile;
import objects.Territory;
import states.PlayState;

/**
 * ...
 * @author Karlo
 */
class CameraManager
{
	public var magnifiedZoomValue : Float 	= 1.5;
	public var normalZoomValue : Float 		= 1;
	public var currentZoomValue : Float		= 1;
	public var isZoomedIn : Bool = false;
	public var mainCamera : FlxCamera;
	public var topBarCamera : FlxCamera;
	
	public function new() 
	{
		//TODO: Add a pinch zoom feature
		var topBarHeight : Int = 60;
		
		// First we get the mainCamera
		mainCamera = FlxG.camera;
		
		// We then create the topBarCamera
		topBarCamera = new FlxCamera(0, 0, Lib.current.stage.stageWidth, topBarHeight, 1);
		FlxG.cameras.add(topBarCamera);
		
		// Then we set up the mainCamera height and position
		mainCamera.height = Std.int(Lib.current.stage.stageHeight - topBarHeight) * 2;
		mainCamera.y = topBarCamera.height;
		
		// We then get the PlayAreaLayer.areaWidth and height
		var newScale : Float = mainCamera.zoom;
		var newScaleX : Float = 1;
		var newScaleY : Float = 1;
		
		// We then adjust the mainCamera zoom factor for the mainCamera so that the 
		// playArea would fit on the screen
		if ( PlayAreaLayer.areaWidth > Lib.current.stage.stageWidth )
		{
			newScale = (Lib.current.stage.stageWidth) / PlayAreaLayer.areaWidth;
		}
		else if ( PlayAreaLayer.areaHeight > (Lib.current.stage.stageHeight - topBarHeight) )
		{
			newScale = (Lib.current.stage.stageHeight - topBarHeight) / PlayAreaLayer.areaHeight;
		}
		else if ( PlayAreaLayer.areaWidth <= Lib.current.stage.stageWidth 
			&& PlayAreaLayer.areaHeight <= (Lib.current.stage.stageHeight - topBarHeight))
		{
			newScaleX = Lib.current.stage.stageWidth / PlayAreaLayer.areaWidth;	
			newScaleY = (Lib.current.stage.stageHeight - topBarHeight) / PlayAreaLayer.areaHeight;
			newScale = Math.min(newScaleX, newScaleY);
		}
		
		// We then apply and save the new scale
		mainCamera.zoom = newScale;
		normalZoomValue = newScale;								// We set the normalZoom value according to the ratio when the game is initialized
		currentZoomValue = newScale;
		magnifiedZoomValue = normalZoomValue * 1.5;				// Whatever the normal zoom is, the magnified zoom is 150 percent of that value	

		// We then adjust the mainCamera viewing area
		mainCamera.width = Std.int(Math.round(Lib.current.stage.stageWidth / newScale));
		mainCamera.height = Std.int(Math.round((Lib.current.stage.stageHeight - topBarHeight) / newScale));
		
		centerCamera();
	}
	
	/**
	 * Toggles between zoomed in and zoomed out mode.
	 */
	public function toggleZoom() 
	{
		if ( isZoomedIn )
			zoomOut();
		else
			zoomIn();
	}
	
	/**
	 * Zooms-in the camera
	 */
	public function zoomIn() 
	{
		if ( isZoomedIn )
			return;
			
		isZoomedIn = true;
		FlxG.camera.zoom = magnifiedZoomValue;
		currentZoomValue = FlxG.camera.zoom;
	}
	
	/**
	 * Zooms-out the camera
	 */
	public function zoomOut() 
	{
		if ( !isZoomedIn )
			return;
			
		isZoomedIn = false;
		FlxG.camera.zoom = normalZoomValue;
		currentZoomValue = FlxG.camera.zoom;
		
		// We then reset the camera position
		//FlxG.camera.scroll = new FlxPoint();
		centerCamera();
	}
	
	/**
	 * Focuses the camera on a particular territory
	 * @param	territoryNum		the territory number to focus on
	 */
	public function focusOnTerritory(territoryNum:Int) 
	{
		var territory : Territory = PlayState.territoryManager.getTerritory(territoryNum);
		FlxG.camera.scroll = new FlxPoint(territory.centerTile.x - FlxG.width / 2 / PlayState.cameraManager.magnifiedZoomValue
			, territory.centerTile.y - FlxG.height / 2 / PlayState.cameraManager.magnifiedZoomValue);
	}
	
	/**
	 * Focuses the camera on a random territory owned by a particular player
	 * @param	playerNumber	the player in which we would get the random territory from
	 */
	public function focusOnRandomTerritory(playerNumber : Int) 
	{
		var territory : Territory = PlayState.territoryManager.getRandomTerritory(playerNumber);
		PlayState.cameraManager.focusOnTerritory(territory.territoryNumber);
	}
	
	/**
	 * Centers the camera
	 */
	public function centerCamera()
	{
		trace(FlxG.width + " " + mainCamera.width + " " + FlxG.stage.stageWidth + " " + Lib.current.stage.stageWidth + " " + PlayAreaLayer.areaWidth);
		FlxG.camera.scroll = new FlxPoint(-((FlxG.width - PlayAreaLayer.areaWidth)/ 2)
			, -((FlxG.height - PlayAreaLayer.areaHeight + topBarCamera.height) / 2));
	}
}