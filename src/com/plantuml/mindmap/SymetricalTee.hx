package com.plantuml.mindmap;

class SymetricalTee {
	private final thickness1:Float;
	private final elongation1:Float;
	private final thickness2:Float;
	private final elongation2:Float;

	public function new(thickness1:Float, elongation1:Float, thickness2:Float, elongation2:Float) {
		this.thickness1 = thickness1;
		this.elongation1 = elongation1;
		this.thickness2 = thickness2;
		this.elongation2 = elongation2;
	}

	public function getThickness1():Float {
		return thickness1;
	}

	public function getElongation1():Float {
		return elongation1;
	}

	public function getThickness2():Float {
		return thickness2;
	}

	public function getElongation2():Float {
		return elongation2;
	}

	public function getFullElongation():Float {
		return elongation1 + elongation2;
	}

	public function getFullThickness():Float {
		return Math.max(thickness1, thickness2);
	}
}
