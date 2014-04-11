package objects;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class LoadingBanner extends FlxSprite
{
	inline private static var FONT_SIZE : Float = 100;
	var loadingLabel : FlxText;
	
	public function new(xPos : Float, yPos : Float, parentLayer : FlxSpriteGroup) 
	{
		super(0, 0);
		makeGraphic(Std.int(MainStage.cameraWidth), Std.int(MainStage.cameraHeight), 0xFF000000);
		this.alpha = 0.8;
		
		loadingLabel = new FlxText(0, yPos - FONT_SIZE, Std.int(MainStage.cameraWidth), "Loading...", FONT_SIZE);
		loadingLabel.font = GameState.DEFAULT_FONT;
		loadingLabel.alignment = "center";
		loadingLabel.setBorderStyle(FlxText.BORDER_OUTLINE_FAST, 0, 2, 1);
		
		parentLayer.add(this);
		parentLayer.add(loadingLabel);
	}
}