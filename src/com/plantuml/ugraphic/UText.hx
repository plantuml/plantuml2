package com.plantuml.ugraphic;

import com.plantuml.graphic.FontConfiguration;

class UText implements UShape {
	final text:String;
	final fontConfiguration:FontConfiguration;

	public function new(text:String, fontConfiguration:FontConfiguration) {
		this.text = text;
		this.fontConfiguration = fontConfiguration;
	}

	public function getText():String {
		return text;
	}

	public function getFontConfiguration() {
		return fontConfiguration;
	}
}
