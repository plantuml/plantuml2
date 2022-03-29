package com.plantuml.command.regex;

import com.plantuml.regex.MyPattern;
import haxe.display.JsonModuleTypes.JsonExpr;

class RegexLeaf extends AbstractRegex implements IRegex {
	private final name:String;
	private final size:Int;

	public function getSize():Int {
		return size;
	}

	public function new(size:Int, pattern:String, ?name:String) {
		this.name = name;
		super(pattern);
		this.size = size;
	}

	function toString():String {
		return name + "=" + getPatternString();
	}

	public function eat(array:Array<String>, map:Map<String, String>):Void {
		if (size == 1) {
			var s = array.pop();
			map.set(name, s);
		} else
			for (i in 0...size) {
				var s = array.pop();
				map.set(name + i, s);
			}
	}

	/*
		public function match(full:String):JsonExpr {
			var r = new EReg(pattern, "i");

			var s = '{"rating": 5}';
			var o = haxe.Json.parse(s);
			trace(o); // { rating: 5 }
			$type(o);

			return o;
	}*/
	public static function start() {
		return new RegexLeaf(0, "^");
	}

	public static function end() {
		return new RegexLeaf(0, "$");
	}

	public static function spaceZeroOrMore() {
		return new RegexLeaf(0, "[%s]*");
	}

	public static function spaceOneOrMore() {
		return new RegexLeaf(0, "[%s]+");
	}
}
