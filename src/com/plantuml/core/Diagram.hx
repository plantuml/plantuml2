package com.plantuml.core;

import com.plantuml.ugraphic.UGraphic;

abstract class Diagram {
	public abstract function exportDiagramNow(ug:UGraphic):Void;
}
