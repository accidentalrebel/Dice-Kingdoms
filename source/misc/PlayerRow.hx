package misc;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Karlo
 */
class PlayerRow
{
	public static inline var FONT_SIZE : Int = 18;
	
	public var positionLabel 		: FlxText;
	private var nameLabel 			: FlxText;
	private var aiLabel 			: FlxText;
	private var territoryCountLabel	: FlxText;
	private var parent				: FlxSpriteGroup;

	public function new(tParent : FlxSpriteGroup, xPos : Float, yPos : Float, position : String, playerColor : Int, playerType : String, territoryCount : String) 
	{		
		parent = tParent;
		
		positionLabel = new FlxText(xPos, yPos, 20, position, FONT_SIZE);
		positionLabel.alignment = "center";

		var colorString : String = PlayerColor.getColorAsString(playerColor);
		nameLabel = new FlxText(xPos + positionLabel.width, yPos, 120, colorString, FONT_SIZE);
		nameLabel.color = playerColor;
		nameLabel.alignment = "center";
		
		aiLabel = new FlxText(xPos + nameLabel.width + positionLabel.width, yPos, 150, playerType, FONT_SIZE);
		aiLabel.alignment = "center";
		
		territoryCountLabel = new FlxText(xPos + nameLabel.width + positionLabel.width + aiLabel.width, yPos, 40, territoryCount, FONT_SIZE);
		territoryCountLabel.alignment = "center";
		
		parent.add(positionLabel);
		parent.add(nameLabel);
		parent.add(aiLabel);
		parent.add(territoryCountLabel);
	}
	
	public function setTerritoryCountTo(newTerritoryCount : String) 
	{
		territoryCountLabel.text = newTerritoryCount;
	}
}