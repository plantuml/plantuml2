package com.plantuml;

import com.plantuml.style.StyleBuilder;

interface ISkinParam {
	public function getCurrentStyleBuilder():StyleBuilder;
}
