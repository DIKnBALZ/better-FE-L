package gameObjects.userInterface.menu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class MenuItem extends FlxSpriteGroup {
	public var targetY:Float = 0;
	public var week:FlxSprite;
	public var flashingInt:Int = 0;

	public function new(x:Float, y:Float, weekNum:Int = 0) {
		super(x, y);
		week = new FlxSprite().loadGraphic(Paths.image('menus/base/storymenu/weeks/week' + weekNum));
		add(week);
	}

	private var isFlashing:Bool = false;
	public function startFlashing():Void {
		isFlashing = true;
	}

	// FAKE FRAMERARTE GRAHHHH
	var fakeFramerate:Int = Math.round((1 / FlxG.elapsed) / 10);
	override function update(elapsed:Float) {
		super.update(elapsed);
		var lerpVal = Main.framerateAdjust(0.17);
		y = FlxMath.lerp(y, (targetY * 120) + 480, lerpVal);
		if (isFlashing)
			flashingInt += 1;
		if (flashingInt % fakeFramerate >= Math.floor(fakeFramerate / 2))
			week.color = 0xFF33ffff;
		else
			week.color = FlxColor.WHITE;
	}
}