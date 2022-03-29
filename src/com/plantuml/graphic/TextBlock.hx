package com.plantuml.graphic;

import com.plantuml.awt.geom.Dimension2D;
import com.plantuml.ugraphic.UShape;

interface TextBlock extends UDrawable extends UShape {
	public function calculateDimension(stringBounder:StringBounder):Dimension2D;
}
