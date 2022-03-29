package com.plantuml.error;

import com.plantuml.version.Version;

using com.plantuml.ArrayExtensions;
using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

import com.plantuml.core.Diagram;
import com.plantuml.cucadiagram.Display;
import com.plantuml.graphic.FontConfiguration;
import com.plantuml.ugraphic.UGraphic;
import com.plantuml.ugraphic.color.Color;
import com.plantuml.ugraphic.color.HColor;
import haxe.CallStack;
import haxe.Exception;

class DiagramCrash extends Diagram {
	final ex:Exception;

	public function new(ex:Exception) {
		this.ex = ex;
	}

	public function exportDiagramNow(ug:UGraphic) {
		final back:Color = "#000000";
		ug.applySetting(GeneralBackground(back));

		var err = Display.create(["For some reason, PlantUML has crashed", " "]);

		err = err.push("RootCause " + ex.toString());
		err = err.push(" ");
		err = err.push("This has been generated with PlantUML (" + Version.versionString() + ").");
		err = err.push("Running plateform: " + Version.getTarget());
		err = err.push(" ");
		err = err.push("Build time: " + Version.buidTime());
		err = err.push("Running time: " + Version.runningTime());
		err = err.push(" ");

		err = err.pushWithNewlines(ex.stack.toString().replaceAll('\nCalled from ', '\n |  '));
		err = err.push("|");

		final fc = FontConfiguration.create(HColor.plain("#00FF00"));

		err.toTextBlock(fc).drawU(ug);
	}
}
