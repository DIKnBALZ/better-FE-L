package gameObjects;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import gameObjects.background.*;
import meta.CoolUtil;
import meta.data.Conductor;
import meta.data.HScript;
import meta.data.dependency.FNFSprite;
import meta.state.PlayState;

using StringTools;

/**
	This is the stage class. It sets up everything you need for stages in a more organised and clean manner than the
	base game. It's not too bad, just very crowded. I'll be adding stages as a separate
	thing to the weeks, making them not hardcoded to the songs.
**/
class Stage extends FlxTypedGroup<FlxBasic>
{
	var script:HScript;
	var gfVersion:String = 'gf';

	var halloweenBG:FNFSprite;
	var phillyCityLights:FlxTypedGroup<FNFSprite>;
	var phillyTrain:FNFSprite;
	var trainSound:FlxSound;

	public var limo:FNFSprite;

	public var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;

	var fastCar:FNFSprite;

	var upperBoppers:FNFSprite;
	var bottomBoppers:FNFSprite;
	var santa:FNFSprite;

	public var curStage:String;

	public var foreground:FlxTypedGroup<FlxBasic>;

	var tankWatchtower:FNFSprite;
	var tankGround:FNFSprite;
	var tankmanRun:FlxTypedGroup<TankmenBG>;

	public function new(curStage)
	{
		super();
		this.curStage = curStage;

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

		//
		switch (this.curStage)
		{
			case 'spooky':
				this.curStage = 'spooky';
				// halloweenLevel = true;

				var hallowTex = Paths.getSparrowAtlas('backgrounds/' + this.curStage + '/halloween_bg');

				halloweenBG = new FNFSprite(-200, -100);
				halloweenBG.frames = hallowTex;
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = true;
				add(halloweenBG);

			// isHalloween = true;
			case 'philly':
				this.curStage = 'philly';

				var bg:FNFSprite = new FNFSprite(-100).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/sky'));
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);

				var city:FNFSprite = new FNFSprite(-10).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/city'));
				city.scrollFactor.set(0.3, 0.3);
				city.setGraphicSize(Std.int(city.width * 0.85));
				city.updateHitbox();
				add(city);

				phillyCityLights = new FlxTypedGroup<FNFSprite>();
				add(phillyCityLights);

				for (i in 0...5)
				{
					var light:FNFSprite = new FNFSprite(city.x).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/win' + i));
					light.scrollFactor.set(0.3, 0.3);
					light.visible = false;
					light.setGraphicSize(Std.int(light.width * 0.85));
					light.updateHitbox();
					light.antialiasing = true;
					phillyCityLights.add(light);
				}

				var streetBehind:FNFSprite = new FNFSprite(-40, 50).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/behindTrain'));
				add(streetBehind);

				phillyTrain = new FNFSprite(2000, 360).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/train'));
				add(phillyTrain);

				trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
				FlxG.sound.list.add(trainSound);

				// var cityLights:FNFSprite = new FNFSprite().loadGraphic(AssetPaths.win0.png);

				var street:FNFSprite = new FNFSprite(-40, streetBehind.y).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/street'));
				add(street);
			case 'highway':
				this.curStage = 'highway';
				PlayState.defaultCamZoom = 0.90;

				var skyBG:FNFSprite = new FNFSprite(-120, -50).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/limoSunset'));
				skyBG.scrollFactor.set(0.1, 0.1);
				add(skyBG);

				var bgLimo:FNFSprite = new FNFSprite(-200, 480);
				bgLimo.frames = Paths.getSparrowAtlas('backgrounds/' + this.curStage + '/bgLimo');
				bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
				bgLimo.animation.play('drive');
				bgLimo.scrollFactor.set(0.4, 0.4);
				add(bgLimo);

				grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
				add(grpLimoDancers);

				for (i in 0...5)
				{
					var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
					dancer.scrollFactor.set(0.4, 0.4);
					grpLimoDancers.add(dancer);
				}

				var overlayShit:FNFSprite = new FNFSprite(-500, -600).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/limoOverlay'));
				overlayShit.alpha = 0.5;
				// add(overlayShit);

				// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

				// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

				// overlayShit.shader = shaderBullshit;

				var limoTex = Paths.getSparrowAtlas('backgrounds/' + this.curStage + '/limoDrive');

				limo = new FNFSprite(-120, 550);
				limo.frames = limoTex;
				limo.animation.addByPrefix('drive', "Limo stage", 24);
				limo.animation.play('drive');
				limo.antialiasing = true;

				fastCar = new FNFSprite(-300, 160).loadGraphic(Paths.image('backgrounds/' + this.curStage + '/fastCarLol'));
			// loadArray.add(limo);

			// case 'tank':
			// 	// PlayState.defaultCamZoom = 0.9;
			// 	PlayState.defaultCamZoom = 0.5;
				
			// 	var sky:FNFSprite = new FNFSprite(-400, -400).loadGraphic(Paths.image('backgrounds/' + curStage + '/tankSky'));
			// 	sky.scrollFactor.set(0, 0);
			// 	add(sky);

			// 	var clouds:FNFSprite = new FNFSprite(FlxG.random.int(-700, -100), FlxG.random.int(-20, 20)).loadGraphic(Paths.image('backgrounds/' + curStage + '/tankClouds'));
			// 	clouds.scrollFactor.set(0.1, 0.1);
			// 	clouds.active = true;
			// 	clouds.velocity.x = FlxG.random.float(5, 15);
			// 	add(clouds);

			// 	var mountains:FNFSprite = new FNFSprite(-300, -20).loadGraphic(Paths.image('backgrounds/' + curStage + '/tankMountains'));
			// 	mountains.scrollFactor.set(0.2, 0.2);
			// 	mountains.setGraphicSize(Std.int(mountains.width * 1.2));
			// 	mountains.updateHitbox();
			// 	add(mountains);

			// 	var buildings:FNFSprite = new FNFSprite(-200, 0).loadGraphic(Paths.image('backgrounds/' + curStage + '/tankBuildings'));
			// 	buildings.scrollFactor.set(0.3, 0.3);
			// 	buildings.setGraphicSize(Std.int(buildings.width * 1.1));
			// 	buildings.updateHitbox();
			// 	add(buildings);

			// 	var ruins:FNFSprite = new FNFSprite(-200, 0).loadGraphic(Paths.image('backgrounds/' + curStage + '/tankRuins'));
			// 	ruins.scrollFactor.set(0.35, 0.35);
			// 	ruins.setGraphicSize(Std.int(ruins.width * 1.1));
			// 	ruins.updateHitbox();
			// 	add(ruins);
				
			// 	var smokeL:FNFSprite = new FNFSprite(-200, -100);
			// 	smokeL.scrollFactor.set(0.4, 0.4);
			// 	smokeL.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/tankRuins');
			// 	smokeL.animation.addByPrefix('SmokeBlurLeft', 'SmokeBlurLeft', 24, true);
			// 	smokeL.animation.play('SmokeBlurLeft');
			// 	add(smokeL);

			// 	var smokeR:FNFSprite = new FNFSprite(1100, -100);
			// 	smokeR.scrollFactor.set(0.4, 0.4);
			// 	smokeR.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/smokeRight');
			// 	smokeR.animation.addByPrefix('SmokeRight', 'SmokeRight', 24, true);
			// 	smokeR.animation.play('SmokeRight');
			// 	add(smokeR);

			// 	tankWatchtower = new FNFSprite('tankWatchtower', 100, 50, 0.5, 0.5, ['watchtower gradient color']);
			// 	add(tankWatchtower);

			// 	tankGround = new FNFSprite('tankRolling', 300, 300, 0.5, 0.5, ['BG tank w lighting'], true);
			// 	add(tankGround);

			// 	tankmanRun = new FlxTypedGroup<TankmenBG>();
			// 	foreground.add(tankmanRun);

			// 	var ground:FNFSprite = new FNFSprite('tankGround', -420, -150);
			// 	ground.setGraphicSize(Std.int(ground.width * 1.15));
			// 	ground.updateHitbox();
			// 	add(ground);
			// 	moveTank();

			// 	var tankdude0:FNFSprite = new FNFSprite('tank0', -500, 650, 1.7, 1.5, ['fg']);
			// 	foregroundSprites.add(tankdude0);

			// 	var tankdude1:FNFSprite = new FNFSprite('tank1', -300, 750, 2, 0.2, ['fg']);
			// 	foregroundSprites.add(tankdude1);

			// 	var tankdude2:FNFSprite = new FNFSprite('tank2', 450, 940, 1.5, 1.5, ['foreground']);
			// 	foregroundSprites.add(tankdude2);

			// 	var tankdude4:FNFSprite = new FNFSprite('tank4', 1300, 900, 1.5, 1.5, ['fg']);
			// 	foregroundSprites.add(tankdude4);

			// 	var tankdude5:FNFSprite = new FNFSprite('tank5', 1620, 700, 1.5, 1.5, ['fg']);
			// 	foregroundSprites.add(tankdude5);

			// 	var tankdude3:FNFSprite = new FNFSprite('tank3', 1300, 1200, 3.5, 2.5, ['fg']);
			// 	foregroundSprites.add(tankdude3);

			default:
				script = new HScript('stages/${this.curStage}');
				script.setVariable("FNFSprite", FNFSprite);
				script.setVariable("BackgroundGirls", BackgroundGirls);
				script.setVariable("BackgroundDancer", BackgroundDancer);
				script.setVariable("PlayState", PlayState);
				script.setVariable("Paths", Paths);
				script.setVariable("Std", Std);
				script.setVariable("curStage", this.curStage);
				script.setVariable("gfVersion", gfVersion);
				script.setVariable("foreground", foreground);
				script.setVariable("add", function(obj:FlxBasic) {add(obj);});
				script.create();
		}
	}

	public function returnGFtype(curStage)
	{
		script.callFunction("returnGFtype");
		switch (curStage)
		{
			case 'highway':
				gfVersion = 'gf-car';
			default:
				gfVersion = script.getVariable("gfVersion");
			// case 'tank':
			// 	gfVersion = 'gf-tankmen';
		}

		return gfVersion;
	}

	// get the dad's position
	public function dadPosition(curStage, boyfriend:Character, dad:Character, gf:Character, camPos:FlxPoint):Void
	{
		var characterArray:Array<Character> = [dad, boyfriend];
		for (char in characterArray)
		{
			switch (char.curCharacter)
			{
				case 'gf':
					char.setPosition(gf.x, gf.y);
					gf.visible = false;
					/*
						if (isStoryMode)
						{
							camPos.x += 600;
							tweenCamIn();
					}*/
					/*
						case 'spirit':
							var evilTrail = new FlxTrail(char, null, 4, 24, 0.3, 0.069);
							evilTrail.changeValuesEnabled(false, false, false, false);
							add(evilTrail);
					 */
			}
		}
	}

	public function repositionPlayers(curStage, boyfriend:Character, dad:Character, gf:Character):Void
	{
		script.callFunction("repositionPlayers", [boyfriend, dad, gf]);

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'highway':
				boyfriend.y -= 220;
				boyfriend.x += 260;
				
			case 'tank':
				gf.y += 10;
				gf.x -= 30;
				boyfriend.x += 40;
				boyfriend.y += 0;
				dad.y += 60;
				dad.x -= 80;
				// if (gfVersion != 'pico-speaker')
				// {
				// 	gf.x -= 170;
				// 	gf.y -= 75;
				// }
		}
	}

	var curLight:Int = 0;
	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;
	var startedMoving:Bool = false;

	public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		script.callFunction("stageUpdate", [curBeat, boyfriend, gf, dadOpponent]);

		// trace('update backgrounds');
		switch (PlayState.curStage)
		{
			case 'highway':
				// trace('highway update');
				grpLimoDancers.forEach(function(dancer:BackgroundDancer)
				{
					dancer.dance();
				});

			case 'philly':
				if (!trainMoving)
					trainCooldown += 1;

				if (curBeat % 4 == 0)
				{
					var lastLight:FlxSprite = phillyCityLights.members[0];

					phillyCityLights.forEach(function(light:FNFSprite)
					{
						// Take note of the previous light
						if (light.visible == true)
							lastLight = light;

						light.visible = false;
					});

					// To prevent duplicate lights, iterate until you get a matching light
					while (lastLight == phillyCityLights.members[curLight])
					{
						curLight = FlxG.random.int(0, phillyCityLights.length - 1);
					}

					phillyCityLights.members[curLight].visible = true;
					phillyCityLights.members[curLight].alpha = 1;

					FlxTween.tween(phillyCityLights.members[curLight], {alpha: 0}, Conductor.stepCrochet * .016);
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					trainCooldown = FlxG.random.int(-4, 0);
					trainStart();
				}
			// case 'tank':
			// 	tankWatchtower.dance();
		}
	}

	public function stageUpdateConstant(elapsed:Float, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		script.callFunction("stageUpdateConstant", [elapsed, boyfriend, gf, dadOpponent]);

		switch (PlayState.curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos(gf);
						trainFrameTiming = 0;
					}
				}
			// case 'tank':
			// 	moveTank();

		}
	}

	// PHILLY STUFFS!
	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	function updateTrainPos(gf:Character):Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset(gf);
		}
	}

	function trainReset(gf:Character):Void
	{
		gf.playAnim('hairFall');
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}

	override function add(Object:FlxBasic):FlxBasic
	{
		if (Init.trueSettings.get('Disable Antialiasing') && Std.isOfType(Object, FlxSprite))
			cast(Object, FlxSprite).antialiasing = false;
		return super.add(Object);
	}

	// function moveTank():Void
	// {
	// 	// if (!inCutscene)
	// 	// {
	// 		tankAngle += tankSpeed * FlxG.elapsed;
	// 		tankGround.angle = (tankAngle - 90 + 15);
	// 		tankGround.x = tankX + 1500 * Math.cos(Math.PI / 180 * (1 * tankAngle + 180));
	// 		tankGround.y = 1300 + 1100 * Math.sin(Math.PI / 180 * (1 * tankAngle + 180));
	// 	// }
	// }
}
