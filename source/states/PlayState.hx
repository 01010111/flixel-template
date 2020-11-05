package states;

import zero.flixel.states.State;

class PlayState extends State {

	public static var current:PlayState;

	override function create() {
		current = this;
	}

	override function update(e:Float) {
		super.update(e);
	}

}