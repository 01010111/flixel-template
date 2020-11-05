package;

import flixel.FlxState;
import openfl.display.Sprite;
import flixel.FlxGame;
import zero.utilities.ECS;
import zero.utilities.SyncedSin;
import zero.utilities.Timer;
import zero.utilities.Tween;

#if PIXEL_PERFECT
import flixel.FlxG;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import flixel.system.FlxAssets.FlxShader;
#end

class Main extends Sprite {

	// ~~~~~~~~~~~~~~~~~~~ FOCUS ON THESE ~~~~~~~~~~~~~~~~~~~ //

	static var WIDTH:Int =				0;
	static var HEIGHT:Int =				0;
	static var STATE:Class<FlxState> =	states.PlayState;
	static var SKIP_SPLASH:Bool =		true;

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

	public function new()
	{
		super();

		addChild(new FlxGame(WIDTH, HEIGHT, STATE, SKIP_SPLASH));

		((?dt) -> {
			ECS.tick(dt);
			Timer.update(dt);
			Tween.update(dt);
			SyncedSin.update(dt);
		}).listen('preupdate');

		#if PIXEL_PERFECT
		FlxG.game.setFilters([new ShaderFilter(new FlxShader())]);
		FlxG.game.stage.quality = StageQuality.LOW;
		FlxG.resizeWindow(FlxG.stage.stageWidth, FlxG.stage.stageHeight);
		#end
	}
	
}