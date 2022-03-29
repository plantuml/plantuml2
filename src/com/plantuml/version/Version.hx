package com.plantuml.version;

import com.plantuml.utils.MacroUtils;

class Version {
	static public function version() {
		return 2202200;
	}

	static public function versionString() {
		final s = Std.string(version());
		return s.substr(0, 1) + "." + s.substr(1, 4) + "." + s.substr(5);
	}

	static public function buidTime() {
		final time = Date.fromTime(MacroUtils.buildTime());
		// var result = DateTools.format(time, "%Y/%m/%d %H:%M:%S");
		final result = DateTools.format(time, "%F at %T");
		return result;
	}

	static public function runningTime() {
		final time = Date.now();
		final result = DateTools.format(time, "%F at %T");
		return result;
	}

	static public function getTarget():String {
		#if js
		return "javascript";
		#elseif java
		return "java";
		#elseif python
		return "python";
		#elseif hashlink
		return "hashlink";
		#elseif hl
		return "hl";
		#elseif necko
		return "necko";
		#elseif interp
		return "interp";
		#end
		return "other";
	}
}
