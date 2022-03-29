package com.plantuml.error;

import com.plantuml.command.BlocLines;
import com.plantuml.core.Diagram;
import com.plantuml.cucadiagram.Display;
import com.plantuml.graphic.FontConfiguration;
import com.plantuml.ugraphic.UGraphic;
import com.plantuml.ugraphic.UTranslate;
import com.plantuml.ugraphic.color.Color;
import com.plantuml.ugraphic.color.HColor;

class DiagramNothingFound extends Diagram {
	final lines:Array<String>;

	public function new(lines:Array<String>) {
		this.lines = lines;
	}

	public function exportDiagramNow(ug:UGraphic) {
		final back:Color = "#000000";
		ug.applySetting(GeneralBackground(back));

		var err = Display.create(["No @start found in your data:", " "]);

		err = err.pushAll(lines);

		final fc = FontConfiguration.create(HColor.plain("#00FF00"));

		err.toTextBlock(fc).drawU(ug);
	}
}
