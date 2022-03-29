package com.plantuml.cucadiagram;

using com.plantuml.ArrayExtensions;
using com.plantuml.utils.StartUtils;

import com.plantuml.graphic.FontConfiguration;
import com.plantuml.ugraphic.UTranslate;
import com.plantuml.ugraphic.UText;
import com.plantuml.ugraphic.UFont;
import com.plantuml.ugraphic.UGraphic;
import com.plantuml.graphic.StringBounder;
import com.plantuml.awt.geom.Dimension2D;
import com.plantuml.graphic.TextBlock;

class Display {
	final displayData:Array<String>;

	private function new(displayData:Array<String>) {
		this.displayData = displayData;
	}

	public static function getWithNewlines(label:String) {
		final r = new Display([]);
		for (s in label.splitInLines())
			r.displayData.push(s);
		return r;
	}

	public function pushWithNewlines(label:String):Display {
		final r = new Display(displayData.copy());
		for (s in label.splitInLines())
			r.displayData.push(s);
		return r;
	}

	public function push(label:String):Display {
		final r = new Display(displayData.copy());
		r.displayData.push(label);
		return r;
	}

	public function pushAll(lines:Array<String>):Display {
		final r = new Display(displayData.copy());
		for (s in lines)
			r.displayData.push(s);
		return r;
	}

	public static function create(lines:Array<String>):Display {
		final r = new Display(lines.copy());
		return r;
	}

	public function getEndingStereotype():String {
		return null;
	}

	public function removeEndingStereotype():Display {
		return this;
	}

	public function get(i:Int):String {
		return displayData[i];
	}

	// public function toString():String {
	// 	return label;
	// }

	public function toTextBlock(fontConfiguration:FontConfiguration):TextBlock {
		return new Simple(displayData, fontConfiguration);
	}
}

class Simple implements TextBlock {
	final displayData:Array<String>;
	final fontConfiguration:FontConfiguration;

	public function new(displayData:Array<String>, fontConfiguration:FontConfiguration) {
		this.displayData = displayData;
		this.fontConfiguration = fontConfiguration;
	}

	public function drawU(ug:UGraphic) {
		var y = 0.;
		final font = new UFont();
		for (s in displayData) {
			ug.apply(UTranslate.dy(y)).draw(new UText(s, fontConfiguration));
			final dim = ug.getStringBounder().calculateDimension(font, s);
			y += dim.getHeight();
		}
	}

	public function calculateDimension(stringBounder:StringBounder):Dimension2D {
		var width = 0.;
		var height = 0.;
		final font = new UFont();
		for (s in displayData) {
			final dim = stringBounder.calculateDimension(font, s);
			width = Math.max(width, dim.getWidth());
			height += dim.getHeight();
		}
		return new Dimension2D(width, height);
	}
}
