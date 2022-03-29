package com.plantuml.api.v2;

import com.plantuml.command.BlocLines;
import com.plantuml.error.PSystemErrorUtils;
import com.plantuml.ugraphic.UGraphicSvg;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

@:expose
class Plantuml {
	private var format:String = "svg";

	private var data:Array<String> = [];

	public function new() {}

	public function addLineSingle(line:String) {
		data[data.length] = line;
	}

	public function addLinesArray(lines:Array<String>) {
		for (s in lines)
			addLineSingle(s);
	}

	public function addLines(lines:String) {
		for (s in lines.splitInLines())
			addLineSingle(s);
	}

	public function toString() {
		return data.toString();
	}

	public function setFormat(arg0:String) {}

	public function setSvgLinkTarget(arg0:String) {}

	public function setWatermark(arg0:String) {}

	public function setScale(arg0:Float) {}

	public function setStyle(arg0:String) {}

	public function compile() {
		for (s in data) {
			trace(s);
		}
	}

	public function getSvg():String {
		final blocLines = new BlocLines(data).findStartSomething();
		if (blocLines == null) {
			final diagramErr = PSystemErrorUtils.noDiagramFound(data);
			final svg:UGraphicSvg = UGraphicSvg.create();
			diagramErr.exportDiagramNow(svg);
			final s = svg.getSvg();
			return s;
		}
		final builder = new PSystemBuilder();
		try {
			final diagram = builder.createPSystem(blocLines.findStartSomething());
			final svg:UGraphicSvg = UGraphicSvg.create();
			diagram.exportDiagramNow(svg);
			final s = svg.getSvg();
			return s;
		} catch (e) {
			final svg:UGraphicSvg = UGraphicSvg.create();
			final diagramErr = PSystemErrorUtils.crashErrorAt(e);
			diagramErr.exportDiagramNow(svg);
			final s = svg.getSvg();
			return s;
		}
	}
}
