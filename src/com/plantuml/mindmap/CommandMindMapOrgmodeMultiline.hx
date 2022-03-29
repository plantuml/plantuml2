package com.plantuml.mindmap;

import com.plantuml.mindmap.IdeaShape.IdeaShapeUtils;
import com.plantuml.ugraphic.color.HColor;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

import com.plantuml.command.*;
import com.plantuml.command.CommandControl;
import com.plantuml.command.CommandExecutionResult;
import com.plantuml.command.CommandMultilines2;
import com.plantuml.command.regex.*;
import com.plantuml.command.regex.RegexConcat;
import com.plantuml.core.Diagram;

class CommandMindMapOrgmodeMultiline extends CommandMultilines2<MindMapDiagram> {
	public function new() {
		final start = new RegexConcat([
			RegexLeaf.start(), //
			new RegexLeaf(1, "([*]+)", "TYPE"), //
			new RegexOptional(new RegexLeaf(1, "\\[(#\\w+)\\]", "BACKCOLOR")), //
			new RegexLeaf(1, "(_)?", "SHAPE"), //
			new RegexLeaf(0, ":"), //
			new RegexLeaf(1, "(.*)", "DATA"), //
			RegexLeaf.end()
		]);

		final end = new RegexConcat([
			RegexLeaf.start(), //
			new RegexLeaf(1, "(.*)", "DATA"), //
			new RegexLeaf(0, ";"), //
			new RegexOptional(new RegexLeaf(1, "[%s]*<<(.+)>>", "STEREO")), //
			RegexLeaf.end()
		]);

		super(start, end);
	}

	public function execute2(diagram:MindMapDiagram, lines:BlocLines):CommandExecutionResult {
		final line0 = getStartingPattern().matcher(lines.getFirst().getTrimmed().getString());

		final lineLast = getEndingPattern().matcher(lines.getLast().getString());
		lines = lines.overideFirstAndLastLines(line0["DATA"].getTrimmed(), lineLast["DATA"].getTrimmed());

		final stereotype = lineLast["STEREO"];
		//		if (stereotype != null) {
		//			lines = lines.overrideLastLine(lineLast.get(0));
		//		}

		final type = line0["TYPE"];
		final stringColor = line0["BACKCOLOR"];
		var backColor:HColor = null;
		//		if (stringColor != null) {
		//			backColor = diagram.getSkinParam().getIHtmlColorSet().getColor(diagram.getSkinParam().getThemeStyle(),
		//					stringColor);
		//		}

		final shape = IdeaShapeUtils.fromDesc(line0["SHAPE"]);

		if (stereotype == null) {
			return diagram.addIdea(backColor, type.length - 1, lines.toDisplay(), shape);
		}
		//		return diagram.addIdea(stereotype, backColor, type.length() - 1, lines.toDisplay(),
		//				IdeaShape.fromDesc(line0.get("SHAPE", 0)));
		throw new haxe.exceptions.NotImplementedException();
	}
}
