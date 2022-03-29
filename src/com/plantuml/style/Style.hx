package com.plantuml.style;

import com.plantuml.graphic.FontConfiguration;
import com.plantuml.ugraphic.color.*;
import com.plantuml.ugraphic.color.HColor;

class Style {
	public function new() {}

	public function getFontConfiguration():FontConfiguration {
		return FontConfiguration.create(HColor.plain("#0000FF"));
	}
}
