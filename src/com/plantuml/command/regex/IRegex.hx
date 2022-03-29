package com.plantuml.command.regex;

import haxe.ds.StringMap;

interface IRegex {
	public function getSize():Int;

	public function getPatternString():String;

	public function match(full:String):Bool;

	public function eat(array:Array<String>, map:Map<String, String>):Void;
}
