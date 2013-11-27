package;

import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import states.MenuState;
	
class ProjectClass extends FlxGame
{	
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
		
		var ratioX:Float = stageWidth / 800;
		var ratioY:Float = stageHeight / 600;
		var ratio:Float = Math.max(ratioX, ratioY);
		
		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), MenuState, ratio, 60, 60);
		
		// We then save these values to our MainStage class
		// From now on, we weill be using this values to refer to the actual size of the mainStage
		MainStage.width = 0;
		MainStage.height = 0;
	}
}