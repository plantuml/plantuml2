package com.plantuml.style;

class ClockwiseTopRightBottomLeft {
	final top:Float;
	final right:Float;
	final bottom:Float;
	final left:Float;

	public function new(top:Float, right:Float, bottom:Float, left:Float) {
		this.top = top;
		this.right = right;
		this.bottom = bottom;
		this.left = left;
	}

	public static function same(value:Float):ClockwiseTopRightBottomLeft {
		return new ClockwiseTopRightBottomLeft(value, value, value, value);
	}

	public static function none():ClockwiseTopRightBottomLeft {
		return new ClockwiseTopRightBottomLeft(0, 0, 0, 0);
	}

	public function getTop() {
		return top;
	}

	public function getRight() {
		return right;
	}

	public function getBottom() {
		return bottom;
	}

	public function getLeft() {
		return left;
	}
}
