package objects;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import states.GameState;
import tools.ARTaskManager;

/**
 * ...
 * @author Karlo
 */
class LoadingBanner extends FlxSprite
{
	inline private static var FONT_SIZE : Float = 50;
	var loadingLabel : FlxText;
	var taskManager:ARTaskManager;
	
	public function new(xPos : Float, yPos : Float, parentLayer : FlxSpriteGroup) 
	{
		taskManager = new ARTaskManager();
		
		super(0, 0);
		makeGraphic(Std.int(MainStage.cameraWidth), Std.int(MainStage.cameraHeight), 0xFF000000);
		this.alpha = 0.85;
		
		loadingLabel = new FlxText(0, yPos - FONT_SIZE * 1.5, Std.int(MainStage.cameraWidth), "Loading...", FONT_SIZE);
		loadingLabel.font = GameState.DEFAULT_FONT;
		loadingLabel.alignment = "center";
		loadingLabel.setBorderStyle(FlxText.BORDER_OUTLINE_FAST, 0, 2, 1);
		
		parentLayer.add(this);
		parentLayer.add(loadingLabel);
	}
	
	public function show()
	{
		this.visible = true;
		this.loadingLabel.visible = true;
	}
	
	public function hide(delay : Float = 0)
	{
		function actualHide()
		{
			this.visible = false;
			this.loadingLabel.visible = false;
		}
		
		if ( delay > 0 )
		{
			taskManager.clear();
			taskManager.addPause(delay);
			taskManager.addInstantTask(this, actualHide);
		}
		else
			actualHide();
	}
}