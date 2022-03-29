package com.plantuml.ugraphic;

import com.plantuml.awt.geom.Point2D;

class UPath implements UShape {
	private final segments:Array<USegment> = [];

	public function new() {}

	public function getSegments():Array<USegment> {
		return segments;
	}

	public function moveToPoint(p1:Point2D) {
		final x = p1.getX();
		final y = p1.getY();
		add([x, y], USegmentType.SEG_MOVETO);
	}

	public function lineToPoint(p1:Point2D) {
		final x = p1.getX();
		final y = p1.getY();
		lineTo(x, y);
	}

	public function lineTo(x:Float, y:Float) {
		add([x, y], USegmentType.SEG_LINETO);
	}

	public function cubicTo(ctrlx1:Float, ctrly1:Float, ctrlx2:Float, ctrly2:Float, x2:Float, y2:Float) {
		add([ctrlx1, ctrly1, ctrlx2, ctrly2, x2, y2], USegmentType.SEG_CUBICTO);
	}

	private function addInternal(segment:USegment):Void {
		segments.push(segment);
	}

	public function add(coord:Array<Float>, pathType:USegmentType):Void {
		addInternal(new USegment(coord, pathType));
	}

	public function getDeltaShadow():Float {
		return 0;
	}
}
