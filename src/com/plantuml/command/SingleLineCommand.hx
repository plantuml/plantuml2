package com.plantuml.command;

import com.plantuml.core.Diagram;
import com.plantuml.command.*;
import com.plantuml.command.regex.*;

abstract class SingleLineCommand<D> implements Command<D> {
	var regex:RegexConcat;

	function _init(array:Array<IRegex>) {
		this.regex = new RegexConcat(array);
	}

	public function getPatternString():String {
		return regex.getPatternString();
	}

	public function isValid(lines:BlocLines):CommandControl {
		if (lines.size() != 1)
			return CommandControl.NOT_OK;
		final s = lines.getFirst();
		if (regex.match(s))
			return CommandControl.OK;
		return CommandControl.NOT_OK;
	}

	public function execute(diagram:D, lines:BlocLines):CommandExecutionResult {
		var map:Map<String, String> = regex.matcher(lines.getLines()[0]);
		return executeArg(diagram, lines, map);
	}

	public abstract function executeArg(diagram:D, lines:BlocLines, map:Map<String, String>):CommandExecutionResult;
}
