package com.plantuml.mindmap;

import com.plantuml.ugraphic.UGraphic;

using hx.strings.Strings;

import com.plantuml.ugraphic.color.HColor;
import com.plantuml.cucadiagram.Display;
import com.plantuml.command.*;
import com.plantuml.core.Diagram;

class MindMapDiagram extends Diagram {
	private var first:String;
	private var mindmaps:Array<MindMap>;
	private var defaultDirection:Direction = Direction.RIGHT;

	public function setDefaultDirection(defaultDirection:Direction) {
		this.defaultDirection = defaultDirection;
	}

	public function new() {
		this.mindmaps = [new MindMap(getSkinParam())];
	}

	public function getSmartLevel(type:String):Int {
		if (first == null)
			first = type;

		if (type.endsWith("**"))
			type = type.replaceAll("\t", " ").trim();

		type = type.replaceAll("\t", " ");
		if (type.contains(" ") == false)
			return type.length - 1;

		if (type.endsWith(first))
			return type.length - first.length;

		if (type.trim().length == 1)
			return type.length - 1;

		if (type.startsWith(first))
			return type.length - first.length;

		throw new haxe.exceptions.NotImplementedException();
	}

	private function last():MindMap {
		return mindmaps[mindmaps.length - 1];
	}

	public function getSkinParam():ISkinParam {
		return new SkinParam();
	}

	public function addIdea(backColor:HColor, level:Int, label:Display, shape:IdeaShape, ?direction:Direction):CommandExecutionResult {
		final stereotype:String = label.getEndingStereotype();
		if (stereotype != null)
			label = label.removeEndingStereotype();

		if (last().isFull(level))
			this.mindmaps.push(new MindMap(getSkinParam()));

		if (direction == null)
			direction = defaultDirection;

		return last().addIdeaInternal(stereotype, backColor, level, label, shape, direction);

		throw new haxe.exceptions.NotImplementedException();
	}

	public function exportDiagramNow(ug:UGraphic):Void {
		for (mindmap in this.mindmaps) {
			mindmap.drawU(ug);
		}
	}
}
