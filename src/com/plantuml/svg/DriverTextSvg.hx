package com.plantuml.svg;

import com.plantuml.graphic.FontConfiguration;
import com.plantuml.graphic.StringBounder;
import com.plantuml.ugraphic.UDriver;
import com.plantuml.ugraphic.UParam;
import com.plantuml.ugraphic.UShape;
import com.plantuml.ugraphic.UText;
import com.plantuml.ugraphic.color.ColorMapper;

class DriverTextSvg implements UDriver<SvgGraphics> {
	final stringBounder:StringBounder;

	public function new(stringBounder:StringBounder) {
		this.stringBounder = stringBounder;
	}

	public function draw(shape:UShape, x:Float, y:Float, mapper:ColorMapper, param:UParam, svg:SvgGraphics) {
		final text = cast(shape, UText);

		final fontConfiguration:FontConfiguration = text.getFontConfiguration();
		final dim = stringBounder.calculateDimension(fontConfiguration.getFont(), text.getText());

		final width = dim.getWidth();

		svg.setFillColor(mapper.toSvg(fontConfiguration.getColor()));

		svg.text(text.getText(), x, y + 12, "", 16, "", "plain", "", width, [], "");
	}
}
