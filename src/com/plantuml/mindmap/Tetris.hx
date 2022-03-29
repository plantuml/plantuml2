package com.plantuml.mindmap;

import com.plantuml.awt.geom.Line2D;

class Tetris {
	public static final MAX_VALUE:Float = 999999999.0;

	private final frontier:StripeFrontier = new StripeFrontier();
	private final elements:Array<SymetricalTeePositioned> = [];
	private var minY = MAX_VALUE;
	private var maxY = -MAX_VALUE;
	private final name:String;

	public function new(name:String) {
		this.name = name;
	}

	public function add(tee:SymetricalTee) {
		if (frontier.isEmpty()) {
			final p1:SymetricalTeePositioned = SymetricalTeePositioned.create(tee);
			addInternal(p1);
			return;
		}

		final c1:Float = frontier.getContact(0, tee.getElongation1());
		final c2:Float = frontier.getContact(tee.getElongation1(), tee.getElongation1() + tee.getElongation2());

		// System.err.println("c1=" + c1 + " c2=" + c2);

		final p1:SymetricalTeePositioned = SymetricalTeePositioned.create(tee);
		p1.moveSoThatSegmentA1isOn(c1);

		final p2:SymetricalTeePositioned = SymetricalTeePositioned.create(tee);
		p2.moveSoThatSegmentA2isOn(c2);

		final result:SymetricalTeePositioned = p1.getMax(p2);

		// // System.err.println("p1=" + p1.getY() + " p2=" + p2.getY());
		// // System.err.println("result=" + result.getY());
		addInternal(result);
	}

	public function getHeight():Float {
		if (elements.length == 0)
			return 0;

		return maxY - minY;
	}

	public function balance() {
		if (elements.length == 0)
			return;

		if (minY != Tetris.MAX_VALUE)
			throw new haxe.exceptions.NotImplementedException();

		for (element in elements) {
			minY = Math.min(minY, element.getMinY());
			maxY = Math.max(maxY, element.getMaxY());
		}
		final mean = (minY + maxY) / 2;
		for (stp in elements)
			stp.move(-mean);
	}

	private function addInternal(result:SymetricalTeePositioned) {
		this.elements.push(result);
		final b1:Line2D = result.getSegmentB1();
		frontier.addSegment(b1.getX1(), b1.getX2(), b1.getY1());
		// assert b1.getY1() == b1.getY2();

		final b2:Line2D = result.getSegmentB2();
		if (b2.getX1() != b2.getX2())
			frontier.addSegment(b2.getX1(), b2.getX2(), b2.getY1());

		// assert b2.getY1() == b2.getY2();
	}

	public function getElements():Array<SymetricalTeePositioned> {
		return elements;
	}

	public function getWidth():Float {
		var result:Float = 0;
		for (tee in elements)
			result = Math.max(result, tee.getMaxX());

		return result;
	}
}
