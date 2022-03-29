package com.plantuml.svg;

import com.plantuml.ugraphic.URectangle;
import com.plantuml.ugraphic.UText;
import com.plantuml.ugraphic.UShape;
import com.plantuml.ugraphic.color.ColorMapper;
import com.plantuml.ugraphic.UParam;
import com.plantuml.ugraphic.UDriver;

class DriverRectangleSvg implements UDriver<SvgGraphics> {
	public function new() {}

	public function draw(shape:UShape, x:Float, y:Float, mapper:ColorMapper, param:UParam, svg:SvgGraphics) {
		final rect = cast(shape, URectangle);

		final width = rect.getWidth();
		final height = rect.getHeight();

		applyFillColor(svg, mapper, param);
		applyStrokeColor(svg, mapper, param);

		final rx = 0;
		final ry = 0;

		svg.svgRectangle(x, y, width, height, rx / 2, ry / 2, rect.getDeltaShadow(), rect.getComment(), rect.getCodeLine());
	}

	function applyFillColor(svg:SvgGraphics, mapper:ColorMapper, param:UParam) {
		final fillcolor = param.getBackcolor();
		svg.setFillColor(mapper.toSvg(fillcolor));
	}

	function applyStrokeColor(svg:SvgGraphics, mapper:ColorMapper, param:UParam) {
		final color = param.getColor();
		svg.setStrokeColor(mapper.toSvg(color));
	}
}
