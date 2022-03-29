package com.plantuml;

class APoint {
	var x:Float;
	var y:Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}

	public function name() {
		return x * x + y * y;
	}

	public function getX():Float {
		return x;
	}

	public function getY():Float {
		return y;
	}

	public function toString():String {
		return "Point(" + x + "," + y + ")";
	}
}
