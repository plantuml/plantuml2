package com.plantuml.svg;

import com.plantuml.ugraphic.UPath;
import com.plantuml.ugraphic.UShape;
import com.plantuml.ugraphic.color.ColorMapper;
import com.plantuml.ugraphic.UParam;
import com.plantuml.ugraphic.UDriver;

class DriverPathSvg implements UDriver<SvgGraphics> {
	public function new() {}

	public function draw(shape2:UShape, x:Float, y:Float, mapper:ColorMapper, param:UParam, object:SvgGraphics) {
		final shape = cast(shape2, UPath);

		object.svgPath(x, y, shape, shape.getDeltaShadow());
	}
}
