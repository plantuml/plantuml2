package com.plantuml;

import haxe.exceptions.NotImplementedException;

enum Direction {
	RIGHT;
	LEFT;
	DOWN;
	UP;
}

class DirectionUtils {
	public static function valueOf(s:String):Direction {
		if (s == "RIGHT")
			return RIGHT;
		if (s == "LEFT")
			return LEFT;
		if (s == "DOWN")
			return DOWN;
		if (s == "UP")
			return UP;

		throw new NotImplementedException();
	}
}
