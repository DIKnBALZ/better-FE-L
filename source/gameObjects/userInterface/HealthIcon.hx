package gameObjects.userInterface;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import sys.FileSystem;

using StringTools;
class HealthIcon extends FlxSprite {
	public var sprTracker:FlxSprite;
	public var initialWidth:Float = 0;
	public var initialHeight:Float = 0;

	public function new(char:String = 'bf', isPlayer:Bool = false) {
		super();
		updateIcon(char, isPlayer);
	}

	public function updateIcon(char:String = 'bf', isPlayer:Bool = false) {
		var iconGraphic:FlxGraphic = Paths.coolerReturnGraphic('characters/$char/icons');
		if (iconGraphic == null)
			iconGraphic = Paths.coolerReturnGraphic('characters/bf/icons');
		loadGraphic(iconGraphic, true, Std.int(iconGraphic.width / 2), iconGraphic.height);
		antialiasing = true;
		
		initialWidth = width;
		initialHeight = height;
		animation.add('icon', [0, 1], 0, false, isPlayer);
		animation.play('icon');
		scrollFactor.set();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}