package gameObjects.background;

import flixel.FlxSprite;
import gameObjects.background.WizSprite;

typedef WizardGamerData =
{
	@:optional var x:Float;
	@:optional var y:Float;
	@:optional var scrollX:Float;
	@:optional var scrollY:Float;
};

class WizSprite extends FlxSprite
{
	public function new(data:WizardGamerData)
	{
		super(data.x, data.y);
		// x == null ? 0 : x;

		// @:optional var x:Float;
		var x:Float = data.scrollX == null ? 1 : data.scrollX;
		var y:Float = data.scrollY == null ? 1 : data.scrollY;
		scrollFactor.set(x, y);
	}
}

/*
class TestState extends MusicBeatState // EXAMPLE GRAHHHH
{
	override function create()
	{
		super.create();

		var gay = new WizardIsGamer({
			x: 100,
			y: 100,
			scrollX: 1.5,
			scrollY: 1.5
		});
		add(gay);
	}
}

	var bg:WizSprite = new WizSprite({
        x: 0,
        y: 0,
        scrollX: 0,
        scrollY: 0
    }).loadGraphic(Paths.image('backgrounds/' + curStage + '/stageback'));
*/


// man i wish this shit worked :(