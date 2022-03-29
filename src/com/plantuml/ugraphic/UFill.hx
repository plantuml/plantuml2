package com.plantuml.ugraphic;

import com.plantuml.ugraphic.color.HColor;

class UFill implements UChange {
	final color:HColor;

	public function new(color:HColor) {
		this.color = color;
	}

	public function getColor():HColor {
		return color;
	}
}
