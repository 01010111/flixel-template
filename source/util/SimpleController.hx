package util;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID as PadButton;
import zero.flixel.input.Controller;

/**
 * A Simple controller class to get you started
 * Mimics a famicom controller in scope.
 */
class SimpleController {

	static var key_bindings:Array<Map<Button, Array<FlxKey>>> = [
		// PLAYER ONE
		[
			UP => [FlxKey.UP, FlxKey.W],
			DOWN => [FlxKey.DOWN, FlxKey.S],
			LEFT => [FlxKey.LEFT, FlxKey.A],
			RIGHT => [FlxKey.RIGHT, FlxKey.D],
			A => [FlxKey.X],
			B => [FlxKey.Z, FlxKey.C],
			START => [FlxKey.ENTER],
			BACK => [FlxKey.ESCAPE],
		],
		// PLAYER TWO
		[
			UP => [FlxKey.I],
			DOWN => [FlxKey.K],
			LEFT => [FlxKey.J],
			RIGHT => [FlxKey.L],
			A => [FlxKey.PERIOD],
			B => [FlxKey.SLASH],
		],
	];

	static var pad_bindings:Map<Button, Array<PadButton>> = [
		UP => [DPAD_UP],
		DOWN => [DPAD_DOWN],
		LEFT => [DPAD_LEFT],
		RIGHT => [DPAD_RIGHT],
		A => [A, Y],
		B => [B, X],
		START => [START],
		BACK => [BACK],
	];

	public static function pressed(button:Button, player:Int = 0) {
		return pressed_key(button, player) || pressed_pad(button, player);
	}

	static function pressed_key(button:Button, player:Int) {
		return FlxG.keys.anyPressed(key_bindings[player][button]);
	}

	static function pressed_pad(button:Button, player:Int) {
		var gamepads = FlxG.gamepads.getActiveGamepads();
		if (gamepads.length < player || gamepads[player] == null) return false;
		return gamepads[player].anyPressed(pad_bindings[button]);
	}

	public static function just_pressed(button:Button, player:Int = 0) {
		return just_pressed_key(button, player) || just_pressed_pad(button, player);
	}

	static function just_pressed_key(button:Button, player:Int) {
		return FlxG.keys.anyJustPressed(key_bindings[player][button]);
	}

	static function just_pressed_pad(button:Button, player:Int) {
		var gamepads = FlxG.gamepads.getActiveGamepads();
		if (gamepads.length < player || gamepads[player] == null) return false;
		return gamepads[player].anyJustPressed(pad_bindings[button]);
	}

	public static function just_released(button:Button, player:Int = 0) {
		return just_released_key(button, player) || just_released_pad(button, player);
	}

	static function just_released_key(button:Button, player:Int) {
		return FlxG.keys.anyJustReleased(key_bindings[player][button]);
	}

	static function just_released_pad(button:Button, player:Int) {
		var gamepads = FlxG.gamepads.getActiveGamepads();
		if (gamepads.length < player || gamepads[player] == null) return false;
		return gamepads[player].anyJustReleased(pad_bindings[button]);
	}

}

// If you're using anything in zerolib that requires a `zero.flixel.input.Controller` feel free to use this!
class SimpleECController extends Controller {

	override function pressed(button:ControllerButton):Bool return SimpleController.pressed(translate(button));
	override function just_pressed(button:ControllerButton):Bool return SimpleController.just_pressed(translate(button));
	override function just_released(button:ControllerButton):Bool return SimpleController.just_released(translate(button));

	static function translate(button:ControllerButton):Button {
		return switch button {
			case FACE_A:A;
			case FACE_B:B;
			case DPAD_UP:UP;
			case DPAD_DOWN:DOWN;
			case DPAD_LEFT:LEFT;
			case DPAD_RIGHT:RIGHT;
			case UTIL_START:START;
			case UTIL_SELECT:BACK;
			case LEFT_ANALOG_UP:UP;
			case LEFT_ANALOG_DOWN:DOWN;
			case LEFT_ANALOG_LEFT:LEFT;
			case LEFT_ANALOG_RIGHT:RIGHT;
			default: START;
		}
	}
	
}

enum Button {
	UP;
	DOWN;
	LEFT;
	RIGHT;
	A;
	B;
	START;
	BACK;
}

enum ButtonState {
	JUST_PRESSED;
	PRESSED;
	JUST_RELEASED;
}