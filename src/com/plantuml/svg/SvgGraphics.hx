package com.plantuml.svg;

import com.plantuml.math.Fixed;
import com.plantuml.ugraphic.color.Color;
import com.plantuml.ugraphic.*;
import hx.strings.StringBuilder;

class SvgGraphics {
	// https://stackoverflow.com/questions/36253961/using-google-fonts-with-svg-object
	final root = Xml.createElement("svg");
	final defs = Xml.createElement("defs");
	final gRoot = Xml.createElement("g");
	var generalBackground:Color;

	var stroke:String = "black";
	var fill:String = "black";
	var scale = 1.;

	var maxX:Int = 10;
	var maxY:Int = 10;

	// var defs;
	// var gRoot;

	public function new() {
		root.set("xmlns", "http://www.w3.org/2000/svg");
		root.set("xmlns:xlink", "http://www.w3.org/1999/xlink");
		root.set("version", "1.1");

		root.addChild(defs);
		root.addChild(gRoot);
	}

	function ensureVisible(x:Float, y:Float) {
		if (x > maxX)
			maxX = Math.ceil(x + 1);

		if (y > maxY)
			maxY = Math.ceil(y + 1);
	}

	public function text(text:String, x:Float, y:Float, fontFamily:String, fontSize:Int, fontWeight:String, fontStyle:String, textDecoration:String,
			textLength:Float, attributes:Map<String, String>, textBackColor:String) {
		final elt = Xml.createElement("text");
		elt.set("x", format(x));
		elt.set("y", format(y));
		fillMe(elt);

		elt.set("font-size", format(fontSize));
		elt.set("font-family", "Roboto");
		// elt.set("text", text);
		elt.addChild(Xml.createCData(text));
		getG().addChild(elt);

		ensureVisible(x, y);
		ensureVisible(x + textLength, y);
	}

	public function svgRectangle(x:Float, y:Float, width:Float, height:Float, rx:Float, ry:Float, deltaShadow:Float, id:String, codeLine:String) {
		final elt = createRectangleInternal(x, y, width, height);
		getG().addChild(elt);
		ensureVisible(x + width + 2 * deltaShadow, y + height + 2 * deltaShadow);
	}

	function createRectangleInternal(x:Float, y:Float, width:Float, height:Float) {
		final elt = Xml.createElement("rect");
		elt.set("x", format(x));
		elt.set("y", format(y));
		elt.set("width", format(width));
		elt.set("height", format(height));
		fillMe(elt);
		elt.set("style", getStyleSpecial());
		// manageDarkStroke(elt);
		return elt;
	}

	function getG() {
		return gRoot;
	}

	function format(x:Float):String {
		final tmp:Fixed = x;
		return "" + tmp;
	}

	function getDefStyle() {
		final elt = Xml.createElement("style");
		elt.set("type", "text/css");
		final cmd = "@import url('https://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic');";
		elt.addChild(Xml.createCData(cmd));
		return elt;
	}

	public function toSvg():String {
		final maxXscaled:Int = Math.ceil(maxX * scale);
		final maxYscaled:Int = Math.ceil(maxY * scale);

		defs.addChild(getDefStyle());

		var style = 'width:$maxXscaled px;height: $maxYscaled px;';
		// if (/*this.classesForDarkness.size() == 0 &&*/ backcolor != null)
		// trace('checking generalBackground $generalBackground');
		if (generalBackground != null)
			style += 'background:$generalBackground;';

		root.set("style", style);
		root.set("width", '$maxXscaled' + "px");
		root.set("height", '$maxYscaled' + "px");

		return root.toString();
	}

	function fillMe(elt:Xml) {
		elt.set("fill", fill);
	}

	function getStyleSpecial():String {
		final style = new StringBuilder();
		// if (stroke.equals(strokeDark))
		style.add('stroke:$stroke;');

		return style.toString();
	}

	function getStyle():String {
		final style = new StringBuilder();
		// if (stroke.equals(strokeDark))
		style.add('stroke:$stroke;');
		style.add('fill:none;');

		return style.toString();
	}

	public function svgPath(x:Float, y:Float, path:UPath, deltaShadow:Float) {
		final sb = new StringBuilder();
		for (seg in path.getSegments()) {
			final type = seg.getSegmentType();
			final coord = seg.getCoord();
			if (type == USegmentType.SEG_MOVETO) {
				sb.add("M" + format(coord[0] + x) + "," + format(coord[1] + y) + " ");
				// ensureVisible(coord[0] + x + 2 * deltaShadow, coord[1] + y + 2 * deltaShadow);
			} else if (type == USegmentType.SEG_LINETO) {
				sb.add("L" + format(coord[0] + x) + "," + format(coord[1] + y) + " ");
				// ensureVisible(coord[0] + x + 2 * deltaShadow, coord[1] + y + 2 * deltaShadow);
			} else if (type == USegmentType.SEG_CUBICTO) {
				sb.add("C" + format(coord[0] + x) + "," + format(coord[1] + y) + " " + format(coord[2] + x) + "," + format(coord[3] + y) + " "
					+ format(coord[4] + x) + "," + format(coord[5] + y) + " ");
				// ensureVisible(coord[0] + x + 2 * deltaShadow, coord[1] + y + 2 * deltaShadow);
				// ensureVisible(coord[2] + x + 2 * deltaShadow, coord[3] + y + 2 * deltaShadow);
				// ensureVisible(coord[4] + x + 2 * deltaShadow, coord[5] + y + 2 * deltaShadow);
			} else {
				trace(type);
				throw new haxe.exceptions.NotImplementedException();
			}
		}

		final elt = Xml.createElement("path");
		elt.set("d", sb.toString());
		elt.set("style", getStyle());
		getG().addChild(elt);
	}

	public function setGeneralBackground(color:Color) {
		this.generalBackground = color;
	}

	public function setFillColor(fill:String) {
		this.fill = fill == null ? "none" : fill;
	}

	public function setStrokeColor(stroke:String) {
		this.stroke = stroke == null ? "none" : stroke;
	}
}
