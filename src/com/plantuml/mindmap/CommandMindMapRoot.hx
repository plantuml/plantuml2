package com.plantuml.mindmap;

import com.plantuml.command.*;
import com.plantuml.command.regex.*;
import com.plantuml.core.Diagram;

class CommandMindMapRoot extends SingleLineCommand<MindMapDiagram> {
	public function new() {
		_init([
			RegexLeaf.start(), //
			new RegexLeaf(1, "(0)", "TYPE"), //
			RegexLeaf.spaceOneOrMore(), //
			new RegexLeaf(1, "([^%s].*)", "LABEL"),
			RegexLeaf.end()
		]);
	}

	public function executeArg(diagram:MindMapDiagram, lines:BlocLines, map:Map<String, String>):CommandExecutionResult {
		throw new haxe.exceptions.NotImplementedException();
	}
}
