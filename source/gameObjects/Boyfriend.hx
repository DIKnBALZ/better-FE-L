package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;

using StringTools;
class Boyfriend extends Character {
	public function new()
		super(true);

	override function update(elapsed:Float) {
		if (animation.curAnim.name.startsWith('sing')) holdTimer += elapsed; else holdTimer = 0;
		if (animation.curAnim.name.endsWith('miss') && animation.curAnim.finished) playAnim('idle', true, false, 10);
		if (animation.curAnim.name == 'firstDeath' && animation.curAnim.finished) playAnim('deathLoop');
		super.update(elapsed);
	}
}
