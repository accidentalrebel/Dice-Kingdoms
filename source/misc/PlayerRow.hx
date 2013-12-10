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
	private var positionLabel 		: FlxText;
	private var nameLabel 			: FlxText;
	private var aiLabel 			: FlxText;
	private var territoryCountLabel	: FlxText;
	private var parent				: FlxSpriteGroup;

	public function new(tParent : FlxSpriteGroup, xPos : Float, yPos : Float, position : String, playerName : String, aiType : String, territoryCount : String) 
	{		
		parent = tParent;
		
		positionLabel = new FlxText(xPos, yPos, 20, position, 14);
		positionLabel.alignment = "center";
		
		nameLabel = new FlxText(xPos + positionLabel.width, yPos, 100, playerName, 14);
		nameLabel.alignment = "center";
		
		aiLabel = new FlxText(xPos + nameLabel.width + positionLabel.width, yPos, 150, aiType, 14);
		aiLabel.alignment = "center";
		
		territoryCountLabel = new FlxText(xPos + nameLabel.width + positionLabel.width + aiLabel.width, yPos, 50, territoryCount, 14);
		aiLabel.alignment = "center";
		
		parent.add(positionLabel);
		parent.add(nameLabel);
		parent.add(aiLabel);
		parent.add(territoryCountLabel);
	}
	
}