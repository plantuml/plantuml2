package com.plantuml.utils;

import haxe.crypto.Sha1;
import hx.strings.StringBuilder;
import haxe.ds.BalancedTree;
import com.plantuml.core.DiagramType;

using hx.strings.Strings;

class StartUtils {
	static public function beforeStartUml(s:String):String {
		final x = s.indexOf("@start");
		if (x == -1)
			return null;
		return s.substr(0, x);
	}

	static public function removeHeader(s:String, header:String):String {
		if (header != null && s.startsWith(header))
			return s.substring(header.length);
		return s;
	}

	static public function isArobaseEndDiagram(s:String):Bool {
		final s2 = s.trim();
		return startsWithSymbolAnd(s2, "end");
	}

	static public function isArobaseStartDiagram(s:String):Bool {
		final s2 = s.trim();
		if (s2.startsWith("@") == false && s2.startsWith("\\") == false)
			return false;

		return DiagramType.getTypeFromArobaseStart(s2) != DiagramType.UNKNOWN;
	}

	static public function startsWithSymbolAnd(s:String, value:String) {
		return s.startsWith("@" + value) || s.startsWith("\\" + value);
	}

	static public function splitInLines(s:String):Array<String> {
		final r = ~/\r?\n/g;
		return r.split(s);
	}

	static public function orderMe(s:String):String {
		final tree:BalancedTree<String, Int> = new BalancedTree();
		// https://www.regular-expressions.info/unicode.html
		final r = ~/[!-~]/;
		for (i in 0...s.length) {
			var c = s.charAt(i);
			if (r.match(c) == false)
				continue;
			var cpt = tree.get(c);
			if (cpt == null)
				tree.set(c, 1);
			else
				tree.set(c, cpt + 1);
		}
		var sb:StringBuilder = new StringBuilder();
		for (ent in tree.keyValueIterator()) {
			sb.add(ent.key);
			sb.add("(");
			sb.add(ent.value);
			sb.add(")");
		}

		return sb.toString();
	}

	static public function sha1(s:String):String {
		return Sha1.encode(s);
	}

	static public function getTrimmed(s:String):String {
		return s.trim();
	}

	static public function getString(s:String):String {
		return s;
	}
}
