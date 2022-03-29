package com.plantuml.command;

import com.plantuml.core.Diagram;
import com.plantuml.command.*;
import com.plantuml.command.regex.*;

abstract class CommandMultilines2<D> implements Command<D> {
	final regexStart:RegexConcat;
	final regexEnd:RegexConcat;

	public function new(regexStart:RegexConcat, regexEnd:RegexConcat) {
		this.regexStart = regexStart;
		this.regexEnd = regexEnd;
	}

	public function getStartingPattern() {
		return regexStart;
	}

	public function getEndingPattern() {
		return regexEnd;
	}

	public function isValid(lines:BlocLines):CommandControl {
		// trace('lines=$lines');
		final s = lines.getFirst();
		if (regexStart.match(s) == false)
			return CommandControl.NOT_OK;

		if (lines.size() == 1)
			return CommandControl.OK_PARTIAL;

		if (regexEnd.match(lines.getLast()))
			return CommandControl.OK;

		return CommandControl.OK_PARTIAL;
	}

	public function execute(diagram:D, lines:BlocLines):CommandExecutionResult {
		return execute2(diagram, lines);
	}

	public abstract function execute2(diagram:D, lines:BlocLines):CommandExecutionResult;
}
