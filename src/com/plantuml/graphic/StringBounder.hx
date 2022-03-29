package com.plantuml.graphic;

import com.plantuml.awt.geom.Dimension2D;
import com.plantuml.ugraphic.UFont;

interface StringBounder {
	public function calculateDimension(font:UFont, text:String):Dimension2D;
}
