package com.plantuml.ugraphic;

class URectangle implements UShape {
	private final width:Float;
	private final height:Float;

	public function new(width:Float, height:Float) {
		this.width = width;
		this.height = height;
	}

	public function getWidth() {
		return width;
	}

	public function getHeight() {
		return height;
	}

	public function getDeltaShadow():Float {
		return 0;
	}

	public function getComment():String {
		return "";
	}

	public function getCodeLine():String {
		return "";
	}
}
