package com.plantuml.eggs;

import com.plantuml.command.*;
import com.plantuml.core.Diagram;
import com.plantuml.core.DiagramType;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;
using com.plantuml.ArrayExtensions;

class CharSizeDiagramFactory implements PSystemFactory {
	public function new() {}

	public function getDiagramType():DiagramType {
		return DiagramType.CHARSIZE;
	}

	public function createSystem(lines:BlocLines):Diagram {
		final all = lines.getLines();
		final single = all[0];
		final size = Std.parseInt(all[1]);
		return new CharSizeDiagram(single, size);
	}
}
