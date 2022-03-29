package com.plantuml.awt.geom;

import com.plantuml.ugraphic.UTranslate;
import com.plantuml.ugraphic.UChange;

class Point2D {
	final x:Float;
	final y:Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}

	public function getX():Float {
		return x;
	}

	public function getY():Float {
		return y;
	}

	public function asTranslate():UTranslate {
		return new UTranslate(x, y);
	}
}
