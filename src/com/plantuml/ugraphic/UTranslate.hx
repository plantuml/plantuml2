package com.plantuml.ugraphic;

import com.plantuml.awt.geom.Dimension2D;
import com.plantuml.ugraphic.UChange;

class UTranslate implements UChange {
	private final deltaX:Float;
	private final deltaY:Float;

	public function new(deltaX:Float, deltaY:Float) {
		this.deltaX = deltaX;
		this.deltaY = deltaY;
	}

	public static function dx(x:Float):UChange {
		return new UTranslate(x, 0);
	}

	public static function dy(y:Float):UChange {
		return new UTranslate(0, y);
	}

	public function getDx():Float {
		return deltaX;
	}

	public function getDy():Float {
		return deltaY;
	}

	public function copy():UTranslate {
		return new UTranslate(deltaX, deltaY);
	}

	public function compose(other:UTranslate):UTranslate {
		return new UTranslate(this.deltaX + other.deltaX, this.deltaY + other.deltaY);
	}
}
