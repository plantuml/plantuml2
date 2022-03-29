package com.plantuml.ugraphic;

class USegment {
	private final coord:Array<Float>;
	private final pathType:USegmentType;

	public function new(coord:Array<Float>, pathType:USegmentType) {
		this.coord = coord;
		this.pathType = pathType;
	}

	public function getSegmentType():USegmentType {
		return pathType;
	}

	public function getCoord():Array<Float> {
		return coord;
	}
}
