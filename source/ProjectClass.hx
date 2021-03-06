package;

import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import states.GameState;
import states.MainMenuState;
	
class ProjectClass extends FlxGame
{	
	private static var DESIGN_WIDTH : Float = 800;
	private static var DESIGN_HEIGHT : Float = 600;
	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		// The code below is a fail safe just in case the width and height
		// values are interchanged due to some loading problems
		if ( stageHeight > stageWidth )
		{
			var temp : Int = stageWidth;
			stageWidth = stageHeight;
			stageHeight = temp;
		}
		
		var ratioX:Float = stageWidth / DESIGN_WIDTH;
		var ratioY:Float = stageHeight / DESIGN_HEIGHT;
		var ratio:Float = Math.min(ratioX, ratioY);
		
		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), GameState, ratio, 30, 30);
		
		// We then save these values to our MainStage class
		// From now on, we weill be using this values to refer to the actual size of the mainStage
		MainStage.setup(stageWidth, stageHeight, DESIGN_WIDTH, ratio);
	}
}