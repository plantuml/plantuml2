package com.plantuml.awt.geom;

class Line2D {
	final x1:Float;
	final y1:Float;
	final x2:Float;
	final y2:Float;

	public function new(x1:Float, y1:Float, x2:Float, y2:Float) {
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
	}

	public function getX1():Float {
		return x1;
	}

	public function getY1():Float {
		return y1;
	}

	public function getX2():Float {
		return x2;
	}

	public function getY2():Float {
		return y2;
	}
}
