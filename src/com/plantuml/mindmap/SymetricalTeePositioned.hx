package com.plantuml.mindmap;

import com.plantuml.awt.geom.Line2D;

class SymetricalTeePositioned {
	private final tee:SymetricalTee;
	private var y:Float;

	private function new(tee:SymetricalTee, y:Float) {
		this.tee = tee;
		this.y = y;
	}

	public static function create(tee:SymetricalTee):SymetricalTeePositioned {
		return new SymetricalTeePositioned(tee, 0);
	}

	public function getSegmentA1():Line2D {
		return new Line2D(0, y - tee.getThickness1() / 2, tee.getElongation1(), y - tee.getThickness1() / 2);
	}

	public function getSegmentB1():Line2D {
		return new Line2D(0, y + tee.getThickness1() / 2, tee.getElongation1(), y + tee.getThickness1() / 2);
	}

	public function getSegmentA2():Line2D {
		return new Line2D(tee.getElongation1(), y
			- tee.getThickness2() / 2, tee.getElongation1()
			+ tee.getElongation2(), y
			- tee.getThickness2() / 2);
	}

	public function getSegmentB2():Line2D {
		return new Line2D(tee.getElongation1(), y
			+ tee.getThickness2() / 2, tee.getElongation1()
			+ tee.getElongation2(), y
			+ tee.getThickness2() / 2);
	}

	public function moveSoThatSegmentA1isOn(newY:Float) {
		final current = getSegmentA1().getY1();
		y += newY - current;
	}

	public function moveSoThatSegmentA2isOn(newY:Float) {
		final current = getSegmentA2().getY1();
		y += newY - current;
	}

	public function getMax(other:SymetricalTeePositioned):SymetricalTeePositioned {
		if (this.tee != other.tee)
			throw new haxe.exceptions.NotImplementedException();

		if (other.y > this.y)
			return other;

		return this;
	}

	public function getMaxY():Float {
		return y + Math.max(tee.getThickness1() / 2, tee.getThickness2() / 2);
	}

	public function getMinY():Float {
		return y - Math.max(tee.getThickness1() / 2, tee.getThickness2() / 2);
	}

	public function getY():Float {
		return y;
	}

	public function move(delta:Float) {
		y += delta;
	}

	public function getMaxX():Float {
		return tee.getElongation1() + tee.getElongation2();
	}
}
