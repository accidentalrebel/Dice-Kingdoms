package ui;
import flixel.addons.ui.FlxButtonPlus;
import flixel.text.FlxText;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class CustomButton extends FlxButtonPlus
{
	private var BUTTON_FONT_SIZE : Float = 22;
	
	public function new(X:Int, Y:Int, Callback:Dynamic, ?Params:Array<Dynamic>, ?Label:String, Width:Int = 100, Height:Int = 20)
	{
		super(X, Y, Callback, Params, Label, Width, Height);
		
		this.textNormal.font 	= this.textHighlight.font 	= GameState.DEFAULT_FONT;
		this.textNormal.size 	= this.textHighlight.size 	= BUTTON_FONT_SIZE;
		this.textNormal.y 		= this.textHighlight.y 		+= (this.height / 2 - BUTTON_FONT_SIZE + 2);
		
		this.buttonNormal.loadGraphic("assets/buttons/large_button.png", false, false, Width, Height);
		this.buttonHighlight.loadGraphic("assets/buttons/large_button.png", false, false, Width, Height);
		
		this.textNormal.setBorderStyle(FlxText.BORDER_OUTLINE_FAST, 0, 1, 1);
		this.textHighlight.setBorderStyle(FlxText.BORDER_OUTLINE_FAST, 0, 1, 1);
		
		this.pauseProof = true;
	}	
}