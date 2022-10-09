package gameObjects;

import flixel.FlxG;
import flixel.addons.util.FlxSimplex;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import gameObjects.userInterface.HealthIcon;
import meta.*;
import meta.data.*;
import meta.data.Script.HScript;
import meta.data.dependency.FNFSprite;
import meta.state.PlayState;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;
typedef CharacterData = {
	var offsetX:Float;
	var offsetY:Float;
	var camOffsetX:Float;
	var camOffsetY:Float;
	var quickDancer:Bool;
	var danceType:String;
}

class Character extends FNFSprite {
	var script:HScript;
	
	public var curCharacter:String = 'bf';
	public var characterData:CharacterData;
	
	public var isPlayer:Bool = false; // these shits are used in other places so
	public var holdTimer:Float = 0;
	public var adjustPos:Bool = true; // may remove soon (it seems to be useless!)

	public function new(?isPlayer:Bool = false) {
		super(x, y);
		this.isPlayer = isPlayer;
	}

	public function setCharacter(x:Float, y:Float, character:String):Character {
		curCharacter = character;
		
		var tex:FlxAtlasFrames;
		antialiasing = true;
		characterData = {
			offsetY: 0,
			offsetX: 0,
			camOffsetY: 0,
			camOffsetX: 0,
			quickDancer: false,
			danceType: "normal"
		};

		switch (curCharacter) {
			case 'unknown':
				// can we hardcode this thanks
			default:
				script = new HScript('characters/$curCharacter/Character');
				if (sys.FileSystem.exists(Paths.file('characters/$curCharacter/spritesheet.xml')))
					frames = Paths.getCharacterSparrow(curCharacter);
				else if (sys.FileSystem.exists(Paths.file('characters/$curCharacter/spritesheet.txt')))
					frames = Paths.coolerGetPackerAtlas('characters/$curCharacter/spritesheet');
				else
					loadGraphic(Paths.coolerReturnGraphic('characters/$curCharacter/spritesheet'));
				script.setVariable("character", this);
				script.setVariable("characterData", characterData);
				script.setVariable("Paths", Paths);
				script.create();
		}
		dance();

		if (isPlayer) {
			flipX = !flipX;
			if (!curCharacter.startsWith('bf'))
				flipLeftRight();
		} else if (curCharacter.startsWith('bf'))
			flipLeftRight();

		if (adjustPos) {
			x += characterData.offsetX;
			y += (characterData.offsetY - (frameHeight * scale.y));
		}

		this.x = x;
		this.y = y;
		return this;
	}

	function flipLeftRight():Void {
		var oldRight = animation.getByName('singRIGHT').frames;
		animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
		animation.getByName('singLEFT').frames = oldRight;
		if (animation.getByName('singRIGHTmiss') != null) {
			var oldMiss = animation.getByName('singRIGHTmiss').frames;
			animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
			animation.getByName('singLEFTmiss').frames = oldMiss;
		}
	}

	override function update(elapsed:Float) {
		if (!isPlayer) {
			if (animation.curAnim.name.startsWith('sing')) holdTimer += elapsed;

			var dadVar:Float = 4;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001) {
				dance();
				holdTimer = 0;
			}
		}

		var curCharSimplified:String = simplifyCharacter();
		switch (curCharSimplified) {
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished) playAnim('danceRight');
				if ((animation.curAnim.name.startsWith('sad')) && (animation.curAnim.finished)) playAnim('danceLeft');
		}

		if (animation.curAnim.finished && animation.getByName('${animation.curAnim.name}Post') != null) animation.play('idlePost', true, false, 0);
		super.update(elapsed);
	}

	var danceScript:HScript = new HScript('other/dance');
	public function dance(?forced:Bool = false) {
		danceScript.setVariable("character", this);
		danceScript.setVariable("characterData", characterData);
		danceScript.setVariable("StringTools", StringTools);
		danceScript.create();
		danceScript.callFunction("dance", [forced]);
	}
	
	public var danced:Bool = false;
	override public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void {
		if (animation.getByName(AnimName) != null) super.playAnim(AnimName, Force, Reversed, Frame);
		if (curCharacter == 'gf') {
			if (AnimName == 'singLEFT') danced = true;
			else if (AnimName == 'singRIGHT') danced = false;
			if (AnimName == 'singUP' || AnimName == 'singDOWN') danced = !danced;
		}
	}

	public function simplifyCharacter():String {
		var base = curCharacter;
		if (base.contains('-')) base = base.substring(0, base.indexOf('-'));
		return base;
	}
}