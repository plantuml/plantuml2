package com.plantuml.ugraphic;

import com.plantuml.graphic.TextBlockMarged;
import com.plantuml.graphic.TextBlockMarged;
import com.plantuml.graphic.StringBounder;
import com.plantuml.awt.geom.Dimension2D;
import com.plantuml.graphic.TextBlock;

class Empty implements TextBlock {
	final width:Float;
	final height:Float;

	public function new(width:Float, height:Float) {
		this.width = width;
		this.height = height;
	}

	public function drawU(ug:UGraphic) {}

	public function calculateDimension(stringBounder:StringBounder):Dimension2D {
		return new Dimension2D(width, height);
	}
}

class TextBlockUtils {
	public static function empty(width:Float, height:Float):TextBlock {
		return new Empty(width, height);
	}

	public static function withMargin(textBlock:TextBlock, marginX1:Float, marginX2:Float, marginY1:Float, marginY2:Float):TextBlock {
		return new TextBlockMarged(textBlock, marginY1, marginX2, marginY2, marginX1);
	}
}
