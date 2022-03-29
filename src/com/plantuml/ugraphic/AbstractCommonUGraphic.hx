package com.plantuml.ugraphic;

import com.plantuml.ugraphic.color.*;
import com.plantuml.ugraphic.color.ColorMapper;

abstract class AbstractCommonUGraphic<T> implements UGraphic {
	var translate:UTranslate = new UTranslate(0, 0);

	var backColor:HColor = null;
	var color:HColor = null;

	final drivers:Map<String, UDriver<T>> = [];

	function getTranslateX():Float {
		return translate.getDx();
	}

	function getTranslateY():Float {
		return translate.getDy();
	}

	public function apply(change:UChange):UGraphic {
		var copy = copyUGraphic();
		if (change is UTranslate) {
			final translate = cast(change, UTranslate);
			copy.translate = copy.translate.compose(translate);
		} else if (change is HColor) {
			copy.color = cast(change, HColor);
		} else if (change is UFill) {
			copy.backColor = cast(change, UFill).getColor();
		} else {
			trace('Unknow change $change');
			throw new haxe.exceptions.NotImplementedException();
		}
		return copy;
	}

	public function getParam():UParam {
		return new UParamInternal(color, backColor);
	}

	abstract function copyUGraphic():AbstractCommonUGraphic<T>;

	public function getColorMapper():ColorMapper {
		return new ColorMapper();
	}
}

class UParamInternal implements UParam {
	final backColor:HColor = null;
	final color:HColor = null;

	public function new(color, backColor) {
		this.color = color;
		this.backColor = backColor;
	}

	public function getColor():HColor {
		return color;
	}

	public function getBackcolor():HColor {
		return backColor;
	}

	public function toString() {
		return 'color=$color backColor=$backColor';
	}
}
