package com.plantuml.command.regex;

class RegexConcat extends AbstractRegex implements IRegex {
	private final all:Array<IRegex>;

	public function getSize():Int {
		var size = 0;
		for (r in all)
			size += r.getSize();
		return size;
	}

	public function new(all:Array<IRegex>) {
		this.all = all;
		var tmp = "";
		for (r in all)
			tmp += r.getPatternString();

		super(tmp);
	}

	public function matcher(full:String):Map<String, String> {
		var array = this.matchArray(full);
		array.reverse();
		var map:Map<String, String> = [];
		this.eat(array, map);
		return map;
	}

	public function eat(array:Array<String>, map:Map<String, String>):Void {
		for (r in all)
			r.eat(array, map);
	}
}
