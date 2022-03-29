package com.plantuml.command.regex;

import com.plantuml.regex.MyPattern;
import com.plantuml.regex.Pattern2;

abstract class AbstractRegex implements IRegex {
	private final regex:Pattern2;

	public function new(s:String) {
		this.regex = MyPattern.cmpile(s);
	}

	public function getPatternString():String {
		return regex.getPatternString();
	}

	public function match(full:String):Bool {
		return regex.matcher(full).matches();
	}

	public function matchArray(full:String):Array<String> {
		final m = regex.matcher(full);
		if (m.matches() == false)
			return null;

		var result = [];
		final nb = m.count() + 1;
		for (i in 1...nb)
			result.push(m.group(i));

		return result;
	}
}
