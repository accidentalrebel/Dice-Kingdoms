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
	private var nameLabel 	: FlxText;
	private var aiLabel 	: FlxText;
	private var territoryCountLabel	: FlxText;
	private var parent:FlxSpriteGroup;

	public function new(tParent : FlxSpriteGroup, xPos : Float, yPos : Float) 
	{		
		parent = tParent;
		nameLabel = new FlxText(xPos, yPos, 150, "Player Label", 14);
		nameLabel.alignment = "center";
		
		aiLabel = new FlxText(xPos + 150, yPos, 100, "AI Label", 14);
		aiLabel.alignment = "center";
		
		territoryCountLabel = new FlxText(xPos + 150 + 100, yPos, 150, "Territory Label", 14);
		aiLabel.alignment = "center";
		
		parent.add(nameLabel);
		parent.add(aiLabel);
		parent.add(territoryCountLabel);
	}
	
}