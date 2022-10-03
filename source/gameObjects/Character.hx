package gameObjects;

import flixel.FlxG;
import flixel.addons.util.FlxSimplex;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import gameObjects.userInterface.HealthIcon;
import meta.*;
import meta.data.*;
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
			// case 'mom':
			// 	tex = Paths.getSparrowAtlas('characters/Mom_Assets');
			// 	frames = tex;

			// 	animation.addByPrefix('idle', "Mom Idle", 24, false);
			// 	animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
			// 	animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
			// 	animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
			// 	animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

			// 	playAnim('idle');

			// 	characterData.camOffsetY = 100;
			// case 'mom-car':
			// 	tex = Paths.getSparrowAtlas('characters/momCar');
			// 	frames = tex;

			// 	animation.addByPrefix('idle', "Mom Idle", 24, false);
			// 	animation.addByIndices('idlePost', 'Mom Idle', [10, 11, 12, 13], "", 24, true);
			// 	animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
			// 	animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
			// 	animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
			// 	// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
			// 	// CUZ DAVE IS DUMB!
			// 	animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

			// 	playAnim('idle');
			// case 'monster':
			// 	tex = Paths.getSparrowAtlas('characters/Monster_Assets');
			// 	frames = tex;
			// 	animation.addByPrefix('idle', 'monster idle', 24, false);
			// 	animation.addByPrefix('singUP', 'monster up note', 24, false);
			// 	animation.addByPrefix('singDOWN', 'monster down', 24, false);
			// 	animation.addByPrefix('singLEFT', 'Monster Right note', 24, false);
			// 	animation.addByPrefix('singRIGHT', 'Monster left note', 24, false);

			// 	playAnim('idle');

			// case 'monster-christmas':
			// 	tex = Paths.getSparrowAtlas('characters/monsterChristmas');
			// 	frames = tex;
			// 	animation.addByPrefix('idle', 'monster idle', 24, false);
			// 	animation.addByPrefix('singUP', 'monster up note', 24, false);
			// 	animation.addByPrefix('singDOWN', 'monster down', 24, false);
			// 	animation.addByPrefix('singRIGHT', 'Monster left note', 24, false);
			// 	animation.addByPrefix('singLEFT', 'Monster Right note', 24, false);

			// 	playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24, false);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				playAnim('idle');

				flipX = true;
			case 'bf-dead':
				frames = Paths.getSparrowAtlas('characters/BF_DEATH');

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				playAnim('firstDeath');

				flipX = true;

			case 'bf-holding-gf':
				frames = Paths.getSparrowAtlas('characters/bfAndGF');

				animation.addByPrefix('idle', 'BF idle dance w gf', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				playAnim('idle');

				flipX = true;

			case 'bf-holding-gf-dead':
				frames = Paths.getSparrowAtlas('characters/bfHoldingGF-DEAD');

				animation.addByPrefix('firstDeath', "BF Dies with GF", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead with GF Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY confirm holding gf", 24, false);

				playAnim('firstDeath');

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

				characterData.offsetY = 180;

			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

				characterData.camOffsetY = -330;
				characterData.camOffsetX = -200;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

				characterData.camOffsetY = -330;
				characterData.camOffsetX = -200;
			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;
				characterData.quickDancer = true;

				characterData.camOffsetY = 50;
				characterData.camOffsetX = 100;

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				playAnim('idle');
			default:
				script = new HScript('characters/$curCharacter/Character');
				frames = Paths.getCharacterSparrow(curCharacter);
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
			trace('character ${curCharacter} scale ${scale.y}');
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
			if (animation.curAnim.name.startsWith('sing'))
				holdTimer += elapsed;

			var dadVar:Float = 4;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001) {
				dance();
				holdTimer = 0;
			}
		}

		var curCharSimplified:String = simplifyCharacter();
		switch (curCharSimplified) {
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
				if ((animation.curAnim.name.startsWith('sad')) && (animation.curAnim.finished))
					playAnim('danceLeft');
		}

		if (animation.curAnim.finished && animation.getByName('${animation.curAnim.name}Post') != null)
			animation.play('idlePost', true, false, 0);

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
		if (animation.getByName(AnimName) != null)
			super.playAnim(AnimName, Force, Reversed, Frame);
		
		if (curCharacter == 'gf') {
			if (AnimName == 'singLEFT')
				danced = true;
			else if (AnimName == 'singRIGHT')
				danced = false;

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
				danced = !danced;
		}
	}

	public function simplifyCharacter():String {
		var base = curCharacter;
		if (base.contains('-'))
			base = base.substring(0, base.indexOf('-'));
		return base;
	}
}