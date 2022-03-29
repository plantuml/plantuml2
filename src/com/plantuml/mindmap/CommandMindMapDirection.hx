package com.plantuml.mindmap;

import com.plantuml.Direction.DirectionUtils;

using com.plantuml.ArrayExtensions;
using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

import com.plantuml.command.*;
import com.plantuml.command.regex.*;
import com.plantuml.core.Diagram;

class CommandMindMapDirection extends SingleLineCommand<MindMapDiagram> {
	public function new() {
		_init([
			RegexLeaf.start(),
			new RegexLeaf(0, "[^*]*"), //
			new RegexLeaf(0, "\\b"), //
			new RegexLeaf(1, "(left|right)", "DIRECTION"), //
			new RegexLeaf(0, "\\b"), //
			new RegexLeaf(0, "[^*]*"),
			RegexLeaf.end()
		]);
	}

	public function executeArg(diagram:MindMapDiagram, lines:BlocLines, arg:Map<String, String>):CommandExecutionResult {
		final direction = arg["DIRECTION"];
		diagram.setDefaultDirection(DirectionUtils.valueOf(direction.toUpperCase()));
		return CommandExecutionResult.OK;
	}
}
