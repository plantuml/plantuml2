package com.plantuml.awt.geom;

class Dimension2D {
	public final width:Float;
	public final height:Float;

	public function new(width:Float, height:Float) {
		this.width = width;
		this.height = height;
	}

	public function getHeight():Float {
		return height;
	}

	public function getWidth():Float {
		return width;
	}

	public function toString():String {
		return '$width x $height';
	}

	public function delta(deltaWidth:Float, deltaHeight:Float):Dimension2D {
		return new Dimension2D(width + deltaWidth, height + deltaHeight);
	}
}
