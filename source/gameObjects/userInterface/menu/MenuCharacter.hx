package gameObjects.userInterface.menu;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class MenuCharacter extends FlxSprite {
	public var character:String = '';
	var curCharacterMap:Map<String, Array<Dynamic>> = [
		// format: name of character => id in atlas, fps, loop, scale, offsetX, offsetY
		'bf' => ["BF idle dance white", 24, true, 0.9, 100, 100],
		'bfConfirm' => ['BF HEY!!', 24, false, 0.9, 100, 100],
		'gf' => ["GF Dancing Beat WHITE", 24, true, 1, 100, 100],
		'dad' => ["Dad idle dance BLACK LINE", 24, true, 1 * 0.5, 0, 0],
		'spooky' => ["spooky dance idle BLACK LINES", 24, true, 1 * 0.5, 0, 90],
		'pico' => ["Pico Idle Dance", 24, true, 1 * 0.5, 0, 100],
		'mom' => ["Mom Idle BLACK LINES", 24, true, 1 * 0.5, 0, -20],
		'parents-christmas' => ["Parent Christmas Idle", 24, true, 0.8, -100, 50],
		'senpai' => ["SENPAI idle Black Lines", 24, true, 1.4 * 0.5, -50, 100],
	];

	var baseX:Float = 0;
	var baseY:Float = 0;
	public function new(x:Float, newCharacter:String = 'bf') {
		super(x);
		y += 70;
		baseX = x;
		baseY = y;
		createCharacter(newCharacter);
		updateHitbox();
	}

	public function createCharacter(newCharacter:String, canChange:Bool = false) {
		frames = Paths.getSparrowAtlas('menus/base/storymenu/campaign_menu_UI_characters');
		var assortedValues = curCharacterMap.get(newCharacter);
		if (assortedValues != null) {
			if (!visible)
				visible = true;
			animation.addByPrefix(newCharacter, assortedValues[0], assortedValues[1], assortedValues[2]);
			animation.play(newCharacter);
			if (canChange) {
				setGraphicSize(Std.int(width * assortedValues[3]));
				updateHitbox();
				setPosition(baseX + assortedValues[4], baseY + assortedValues[5]);
				if (newCharacter == 'pico')
					flipX = true;
				else
					flipX = false;
			}
		}
		else
			visible = false;
		character = newCharacter;
	}
}