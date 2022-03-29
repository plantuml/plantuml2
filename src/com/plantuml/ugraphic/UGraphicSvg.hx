package com.plantuml.ugraphic;

import com.plantuml.ugraphic.color.Color;
import com.plantuml.svg.*;

using hx.strings.Strings;
using com.plantuml.svg.SvgSizeUtils;

import com.plantuml.awt.geom.Dimension2D;
import com.plantuml.graphic.StringBounder;

class StringBounderSvg implements StringBounder {
	public function new() {}

	public function calculateDimension(font:UFont, text:String):Dimension2D {
		final height = 16.0;
		var width = 0.0;
		for (c in new haxe.iterators.StringIteratorUnicode(text)) {
			// trace("" + c.toChar());
			width += c.singleSize() / 100.0;
		}
		return new Dimension2D(width, height);
	}


}

class UGraphicSvg extends AbstractCommonUGraphic<SvgGraphics> implements UGraphic {
	private final core:SvgGraphics;

	private function new(core:SvgGraphics) {
		this.core = core;
		this.drivers.set(Type.getClassName(UText), new DriverTextSvg(new StringBounderSvg()));
		this.drivers.set(Type.getClassName(URectangle), new DriverRectangleSvg());
		this.drivers.set(Type.getClassName(UPath), new DriverPathSvg());
	}

	public override function apply(change:UChange):UGraphicSvg {
		var tmp1 = super.apply(change);
		return cast(tmp1, UGraphicSvg);
	}

	public function applySetting(setting:USetting):Void {
		switch (setting) {
			case GeneralBackground(color):
				core.setGeneralBackground(color);
		}
	}

	public static function create():UGraphicSvg {
		return new UGraphicSvg(new SvgGraphics());
	}

	public function getStringBounder():StringBounder {
		return new StringBounderSvg();
	}

	public function draw(shape:UShape) {
		var cl = Type.getClass(shape);
		var driver = drivers.get(Type.getClassName(cl));
		if (driver == null) {
			trace(shape);
			throw new haxe.exceptions.NotImplementedException();
		} else {
			driver.draw(shape, getTranslateX(), getTranslateY(), getColorMapper(), getParam(), core);
		}
	}

	public function getSvg():String {
		return core.toSvg();
	}

	function copyUGraphic():UGraphicSvg {
		var result = new UGraphicSvg(core);
		result.translate = this.translate.copy();
		result.color = this.color;
		result.backColor = this.backColor;
		return result;
	}
}
