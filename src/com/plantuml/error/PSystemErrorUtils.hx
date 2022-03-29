package com.plantuml.error;

import haxe.Exception;
import com.plantuml.command.BlocLines;
import com.plantuml.core.Diagram;

class PSystemErrorUtils {
	public static function syntaxErrorAt(lines:BlocLines):Diagram {
		return new DiagramSyntaxError(lines);
	}

	public static function crashErrorAt(e:Exception):Diagram {
		return new DiagramCrash(e);
	}

	public static function noDiagramFound(data:Array<String>):Diagram {
		return new DiagramNothingFound(data);
	}
}
