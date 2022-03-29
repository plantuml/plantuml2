package com.plantuml.mindmap;

import com.plantuml.cucadiagram.Display;
import com.plantuml.mindmap.IdeaShape.IdeaShapeUtils;
import com.plantuml.ugraphic.color.HColor;
import com.plantuml.core.Diagram;
import com.plantuml.command.*;
import com.plantuml.command.regex.*;

class CommandMindMapOrgmode extends SingleLineCommand<MindMapDiagram> {
	public function new() {
		_init([
			RegexLeaf.start(), //
			new RegexLeaf(1, "([ \t]*[*]+)", "TYPE"), //
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

		final shape = IdeaShapeUtils.fromDesc(arg["SHAPE"]);

		return diagram.addIdea(backColor, diagram.getSmartLevel(type), Display.getWithNewlines(label), shape);

		// return CommandExecutionResult.OK;
	}
}
