package com.plantuml.command;

import com.plantuml.core.Diagram;

interface Command<D> {
	public function isValid(lines:BlocLines):CommandControl;

	public function execute(diagram:D, lines:BlocLines):CommandExecutionResult;
}
