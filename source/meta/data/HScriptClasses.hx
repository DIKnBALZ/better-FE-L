package meta.data;

import flixel.util.FlxColor;
import openfl.display.BlendMode;

class HScriptClasses
{
	public static function getBlendModeClass()
	{
		return {
			"ADD": BlendMode.ADD,
			"ALPHA": BlendMode.ALPHA,
			"DARKEN": BlendMode.DARKEN,
			"DIFFERENCE": BlendMode.DIFFERENCE,
			"ERASE": BlendMode.ERASE,
			"HARDLIGHT": BlendMode.HARDLIGHT,
			"INVERT": BlendMode.INVERT,
			"LAYER": BlendMode.LAYER,
			"LIGHTEN": BlendMode.LIGHTEN,
			"MULTIPLY": BlendMode.MULTIPLY,
			"NORMAL": BlendMode.NORMAL,
			"OVERLAY": BlendMode.OVERLAY,
			"SCREEN": BlendMode.SCREEN,
			"SHADER": BlendMode.SHADER,
			"SUBTRACT": BlendMode.SUBTRACT
		}
	}

	public static function getFlxColorClass()
	{
		return {
			// color lore
			"BLACK": FlxColor.BLACK,
			"BLUE": FlxColor.BLUE,
			"BROWN": FlxColor.BROWN,
			"CYAN": FlxColor.CYAN,
			"GRAY": FlxColor.GRAY,
			"GREEN": FlxColor.GREEN,
			"LIME": FlxColor.LIME,
			"MAGENTA": FlxColor.MAGENTA,
			"ORANGE": FlxColor.ORANGE,
			"PINK": FlxColor.PINK,
			"PURPLE": FlxColor.PURPLE,
			"RED": FlxColor.RED,
			"TRANSPARENT": FlxColor.TRANSPARENT,
			"WHITE": FlxColor.WHITE,
			"YELLOW": FlxColor.YELLOW,

			// functions
			"add": FlxColor.add,
			"fromCMYK": FlxColor.fromCMYK,
			"fromHSB": FlxColor.fromHSB,
			"fromHSL": FlxColor.fromHSL,
			"fromInt": FlxColor.fromInt,
			"fromRGB": FlxColor.fromRGB,
			"fromRGBFloat": FlxColor.fromRGBFloat,
			"fromString": FlxColor.fromString,
			"interpolate": FlxColor.interpolate,
		};
	}
}
