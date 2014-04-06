package effects;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import objects.HexaTile;
import objects.Territory;
import states.GameState;

/**
 * ...
 * @author Karlo
 */
class BattleResult extends FlxSpriteGroup
{
	var battleLabel : FlxText;
	var battleSprite : FlxSprite;
	
	public function new(xPos, yPos) 
	{	
		super(xPos, yPos);
		
		battleSprite = new FlxSprite(0, 0);
		battleSprite.loadGraphic("assets/soldier.png", false, false);
		
		battleLabel = new FlxText(0, 0, 100, "88", 12);
		battleLabel.x = battleSprite.width / 2 - battleLabel.width / 2;
		battleLabel.y = battleSprite.height / 2 - battleLabel.height / 2;
		battleLabel.alignment = "center";
		
		this.add(battleSprite);
		this.add(battleLabel);
	}
	
	public function changeLabelText(labelText : String )
	{
		this.battleLabel.text = labelText;
	}
	
	public function hideLabel()
	{
		this.battleLabel.visible = false;
	}
	
	public function showLabel()
	{
		this.battleLabel.visible = true;
	}
	
	/**
	 * Attaches this battle result to the specified territory.
	 * Handles the positioning.
	 * @param	territoryNumber		The territory number to attach to
	 */
	public function attachToTerritory(territoryNumber : Int)
	{
		var territoryToAttachTo : Territory = GameState.territoryManager.getTerritory(territoryNumber);
		this.setPosition(territoryToAttachTo.centerTile.x + HexaTile.TILE_WIDTH / 2 - battleSprite.width / 2, territoryToAttachTo.centerTile.y - 40);
	}
	
	public function setAsWinner() 
	{
		changeLabelText("WINNER");
	}
	
	public function setAsLoser() 
	{
		changeLabelText("LOSER");
	}
}