package managers;
import flash.Lib;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.util.FlxPoint;
import layers.PlayAreaLayer;
import objects.HexaTile;
import objects.Territory;

/**
 * ...
 * @author Karlo
 */
class CameraManager
{
	public static var magnifiedZoomValue : Float 	= 1.5;
	public static var normalZoomValue : Float 		= 1;
	static public var currentZoomValue : Float		= 1;
	public static var isZoomedIn : Bool = false;
	public static var mainCamera : FlxCamera;
	public static var topBarCamera : FlxCamera;
	
	static public function init() 
	{
		//TODO: Create a gameStage.width and height variables instead of relying on Lib.current.stage.stageWidth. This is because there is a possibility that the width and height values are interchanged/
		var topBarHeight : Int = 60;
		
		// First we get the mainCamera
		mainCamera = FlxG.camera;
		
		// We then create the topBarCamera
		topBarCamera = new FlxCamera(0, 0, Lib.current.stage.stageWidth, topBarHeight, 1);
		FlxG.cameras.add(topBarCamera);
		
		// Then we set up the mainCamera height and position
		mainCamera.height = Std.int(Lib.current.stage.stageHeight - topBarHeight) * 2;
		mainCamera.y = topBarCamera.height;
		
		// We then get the playAreaWidth and height
		var playAreaWidth : Float = ((PlayAreaLayer.playAreaCols - 2) / 2) * HexaTile.tileWidth
			+ ((PlayAreaLayer.playAreaCols + 2) / 2) * (HexaTile.tileWidth / 4);
		var playAreaHeight : Float = PlayAreaLayer.playAreaRows * HexaTile.tileWidth;
		var newScale : Float = mainCamera.zoom;
		var newScaleX : Float = 1;
		var newScaleY : Float = 1;
		
		// We then adjust the mainCamera zoom factor for the mainCamera so that the 
		// playArea would fit on the screen
		if ( playAreaWidth > Lib.current.stage.stageWidth )
		{
			newScale = (Lib.current.stage.stageWidth) / playAreaWidth;
		}
		else if ( playAreaHeight > (Lib.current.stage.stageHeight - topBarHeight) )
		{
			newScale = (Lib.current.stage.stageHeight - topBarHeight) / playAreaHeight;
		}
		else if ( playAreaWidth <= Lib.current.stage.stageWidth 
			&& playAreaHeight <= (Lib.current.stage.stageHeight - topBarHeight))
		{
			newScaleX = Lib.current.stage.stageWidth / playAreaWidth;	
			newScaleY = (Lib.current.stage.stageHeight - topBarHeight) / playAreaHeight;
			newScale = Math.min(newScaleX, newScaleY);
		}
		
		// We then apply and save the new scale
		mainCamera.zoom = newScale;
		normalZoomValue = FlxG.camera.zoom;						// We set the normalZoom value according to the ratio when the game is initialized
		magnifiedZoomValue = normalZoomValue * 1.5;				// Whatever the normal zoom is, the magnified zoom is 150 percent of that value	

		// We then adjust the mainCamera viewing area
		mainCamera.width = Std.int(Lib.current.stage.stageWidth / newScale);
		mainCamera.height = Std.int((Lib.current.stage.stageHeight - topBarHeight) / newScale);
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
			
		isZoomedIn = true;
		FlxG.camera.zoom = magnifiedZoomValue;
		currentZoomValue = FlxG.camera.zoom;
	}
	
	/**
	 * Zooms-out the camera
	 */
	static public function zoomOut() 
	{
		if ( !isZoomedIn )
			return;
			
		isZoomedIn = false;
		FlxG.camera.zoom = normalZoomValue;
		currentZoomValue = FlxG.camera.zoom;
		
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