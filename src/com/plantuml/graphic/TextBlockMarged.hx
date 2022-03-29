package com.plantuml.graphic;

import com.plantuml.ugraphic.UTranslate;
import com.plantuml.ugraphic.UGraphic;
import com.plantuml.awt.geom.Dimension2D;

class TextBlockMarged implements TextBlock {
	private final textBlock:TextBlock;
	private final top:Float;
	private final right:Float;
	private final bottom:Float;
	private final left:Float;

	public function new(textBlock:TextBlock, top:Float, right:Float, bottom:Float, left:Float) {
		this.textBlock = textBlock;
		this.top = top;
		this.right = right;
		this.bottom = bottom;
		this.left = left;
	}

	public function drawU(ug:UGraphic) {
		final translate = new UTranslate(left, top);
		textBlock.drawU(ug.apply(translate));
	}

	public function calculateDimension(stringBounder:StringBounder):Dimension2D {
		final dim = textBlock.calculateDimension(stringBounder);
		return dim.delta(left + right, top + bottom);
	}
}
