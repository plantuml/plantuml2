package com.plantuml.ugraphic.color;

import haxe.exceptions.NotImplementedException;

class HColor implements UChange {
	final color:Color;
	final monochrome:Bool;

	private function new(color:Color, monochrome:Bool) {
		if (color == null)
			throw new NotImplementedException();

		this.color = color;
		this.monochrome = monochrome;
	}

	public function toString() {
		return color.toString();
	}

	public static function plain(s:String):HColor {
		if (s == null)
			throw new NotImplementedException();

		final theColor:Color = s;
		return new HColor(theColor, false);
	}

	public function fill() {
		return new UFill(this);
	}

	public function getColor() {
		return color;
	}
}
