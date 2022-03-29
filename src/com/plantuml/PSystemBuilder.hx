package com.plantuml;

import com.plantuml.eggs.*;
import com.plantuml.error.PSystemErrorUtils;
import com.plantuml.error.DiagramNothingFound;
import com.plantuml.command.BlocLines;
import com.plantuml.core.Diagram;
import com.plantuml.core.DiagramType;
import com.plantuml.mindmap.MindMapDiagramFactory;

using com.plantuml.ArrayExtensions;
using com.plantuml.utils.StartUtils;

class PSystemBuilder {
	private final factories:Array<PSystemFactory> = [];

	public function new() {
		factories.push(new CharSizeDiagramFactory());
		factories.push(new MindMapDiagramFactory());
	}

	public function createPSystem(lines:BlocLines):Diagram {
		lines = lines.findStartSomething();
		if (lines == null)
			return new DiagramNothingFound([]);

		final type = DiagramType.getTypeFromArobaseStart(lines.getFirst());

		if (type == UNKNOWN)
			return new DiagramNothingFound(lines.getLines());

		lines = lines.removeFirstAndLast();
		for (f in factories.filter(x -> x.getDiagramType() == type)) {
			try {
				final result = f.createSystem(lines);
				if (result != null)
					return result;
			} catch (e) {
				trace("Error in some factory");
				trace(e.message);
				return PSystemErrorUtils.crashErrorAt(e);
			}
		}
		trace("No factory found!");
		return new DiagramNothingFound(lines.getLines());
	}
}
