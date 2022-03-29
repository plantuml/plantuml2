package com.plantuml;

import com.plantuml.core.DiagramType;
import com.plantuml.core.Diagram;
import com.plantuml.command.BlocLines;

interface PSystemFactory {
	public function createSystem(lines:BlocLines):Diagram;
	public function getDiagramType():DiagramType;
}
