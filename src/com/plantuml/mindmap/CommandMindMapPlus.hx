package com.plantuml.mindmap;

import com.plantuml.cucadiagram.Display;

using com.plantuml.ArrayExtensions;
using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

import com.plantuml.mindmap.IdeaShape.IdeaShapeUtils;
import com.plantuml.ugraphic.color.HColor;
import com.plantuml.core.Diagram;
import com.plantuml.command.*;
import com.plantuml.command.regex.*;

class CommandMindMapPlus extends SingleLineCommand<MindMapDiagram> {
	public function new() {
		_init([
			RegexLeaf.start(), //
			new RegexLeaf(1, "([+-]+)", "TYPE"), //
			new RegexOptional(new RegexLeaf(1, "\\[(#\\w+)\\]", "BACKCOLOR")), //
			new RegexLeaf(1, "(_)?", "SHAPE"), //
			RegexLeaf.spaceOneOrMore(), //
			new RegexLeaf(1, "([^%s].*)", "LABEL"),
			RegexLeaf.end()
		]);
	}

	public function executeArg(diagram:MindMapDiagram, lines:BlocLines, arg:Map<String, String>):CommandExecutionResult {
		final type:String = arg["TYPE"];
		final label:String = arg["LABEL"];
		final stringColor:String = arg["BACKCOLOR"];
		final backColor:HColor = null;
		//		if (stringColor != null) {
		//			backColor = diagram.getSkinParam().getIHtmlColorSet().getColor(diagram.getSkinParam().getThemeStyle(),
		//					stringColor);
		//		}

		final shape = IdeaShapeUtils.fromDesc(arg["SHAPE"]);

		final direction = type.contains("-") ? Direction.LEFT : Direction.RIGHT;
		return diagram.addIdea(backColor, type.length - 1, Display.getWithNewlines(label), shape, direction);
	}
}
