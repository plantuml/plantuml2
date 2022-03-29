package com.plantuml.command;

interface BlocLinesIterator {
	public function peek(nb:Int):Array<String>;

	public function move(dist:Int):Void;

	public function currentPosition():Int;

	public function hasMore():Bool;
}
