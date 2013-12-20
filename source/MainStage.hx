package ;

/**
 * ...
 * @author Karlo
 */
class MainStage
{	
	//TODO: Include instructions on how and where to use these variables with examples
	static public var adjustedWidth:Float = 0;
	static public var adjustedHeight:Float = 0;
	static public var cameraHeight:Float = 0;
	static public var cameraWidth:Float = 0;
	
	static public function setup(stageWidth:Int, stageHeight:Int, designWidth:Float, ratio:Float) 
	{
		if ( stageWidth < designWidth )
			MainStage.adjustedWidth = MainStage.cameraWidth = Math.round(stageWidth / ratio);
		else
		{
			MainStage.adjustedWidth = stageWidth;
			MainStage.cameraWidth = Math.round(stageWidth / ratio);
		}
			
		if ( stageHeight < designWidth )
			MainStage.adjustedHeight = MainStage.cameraHeight = Math.round(stageHeight / ratio);
		else
		{
			MainStage.adjustedHeight = stageHeight;
			MainStage.cameraHeight = Math.round(stageHeight / ratio);
		}
	}
}