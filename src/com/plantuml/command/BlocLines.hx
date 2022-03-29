package com.plantuml.command;

import com.plantuml.cucadiagram.Display;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;
using com.plantuml.ArrayExtensions;

class BlocLines {
	var lines:Array<String>;

	public function new(?lines:Array<String> = null) {
		if (lines == null)
			this.lines = [];
		else
			this.lines = lines.copy();
	}

	public function slice(pos:Int, ?end:Int) {
		if (end == null)
			return new BlocLines(lines.slice(pos));
		return new BlocLines(lines.slice(pos, end));
	}

	public function getLines() {
		return lines;
	}

	function toString():String {
		return lines.toString();
	}

	public function getFirst() {
		if (lines.length == 0)
			return null;
		return lines[0];
	}

	public function getLast() {
		return lines[lines.length - 1];
	}

	public function size() {
		return lines.length;
	}

	public static function single(s:String):BlocLines {
		return new BlocLines([s]);
	}

	public function addLineSingle(line:String) {
		lines[lines.length] = line;
	}

	public function addLines(lines:String) {
		for (s in lines.splitInLines())
			addLineSingle(s);
	}

	public function findStartSomething() {
		var headerToRemove = null;
		var result = null;
		for (s in lines) {
			final tmp = s.beforeStartUml();
			if (tmp != null)
				headerToRemove = tmp;
			s = s.removeHeader(headerToRemove);

			if (s.isArobaseStartDiagram())
				result = [];

			if (result != null)
				result.push(s);

			if (s.isArobaseEndDiagram())
				return new BlocLines(result);
		}
		return null;
	}

	public function getBlocLinesIterator():BlocLinesIterator {
		return new BlocLinesIteratorImpl(lines);
	}

	public function overideFirstAndLastLines(newFirst:String, newLast:String) {
		var newLines = lines.copy();
		newLines[0] = newFirst;
		newLines[newLines.length - 1] = newLast;
		return new BlocLines(newLines);
	}

	public function removeFirstAndLast() {
		return new BlocLines(lines.removeFirstAndLast());
	}

	public function toDisplay() {
		return Display.create(lines);
	}
}

class BlocLinesIteratorImpl implements BlocLinesIterator {
	final lines:Array<String>;
	var pos:Int = 0;

	public function new(lines:Array<String>) {
		this.lines = lines;
	}

	public function peek(nb:Int):Array<String> {
		if (pos + nb > lines.length)
			return null;
		return lines.slice(pos, pos + nb);
	}

	public function move(dist:Int) {
		pos += dist;
	}

	public function currentPosition():Int {
		return pos;
	}

	public function hasMore():Bool {
		return pos < lines.length;
	}
}
