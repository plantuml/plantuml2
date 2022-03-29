package com.plantuml;

import com.plantuml.style.StyleBuilder;

class SkinParam implements ISkinParam {
	public function new() {}

	public function getCurrentStyleBuilder():StyleBuilder {
		return new StyleBuilder();
	}
}
