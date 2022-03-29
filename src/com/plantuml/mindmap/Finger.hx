package com.plantuml.mindmap;

import com.plantuml.graphic.StringBounder;
import com.plantuml.graphic.UDrawable;

interface Finger extends UDrawable {
	public function getPhalanxThickness(stringBounder:StringBounder):Float;

	public function getNailThickness(stringBounder:StringBounder):Float;

	public function getFullThickness(stringBounder:StringBounder):Float;

	public function getPhalanxElongation(stringBounder:StringBounder):Float;

	public function getNailElongation(stringBounder:StringBounder):Float;

	public function getFullElongation(stringBounder:StringBounder):Float;

	public function doNotDrawFirstPhalanx():Void;
}
