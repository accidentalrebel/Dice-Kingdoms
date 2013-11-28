package states;

import layers.MenuLayer;
import managers.MainMenuManager;
import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import flixel.FlxG;
import flixel.util.FlxPath;
import flixel.ui.FlxButton;
import flixel.util.FlxSave;
import flixel.FlxSprite;
import flixel.FlxState;

class MenuState extends FlxState
{	
	public static var mainMenuManager:MainMenuManager;
	public static var menuLayer : MenuLayer;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff131c1b;
		
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		super.create();
		
		mainMenuManager = new MainMenuManager();
		menuLayer = new MenuLayer();
		
		this.add(menuLayer);
		MenuState.mainMenuManager.startGame();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}