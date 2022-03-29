package com.plantuml.regex;

#if js
import js.lib.RegExp;
#end
#if python
import python.lib.Re;
#end
#if java
import java.util.regex.Pattern;
import java.util.regex.Matcher;
#end

class Matcher2 {
	final pString:String;
	final input:String;

	#if java
	final p:Pattern;
	final m:Matcher;

	public function new(pString, input, p:Pattern) {
		this.pString = pString;
		this.input = input;
		this.p = p;
		this.m = p.matcher(input);
	}
	#elseif python
	final p:Pattern;
	final m:MatchObject;

	public function new(pString, input, p:Pattern) {
		this.pString = pString;
		this.input = input;
		this.p = p;
		this.m = Re.match(p, input);
	}
	#elseif js
	final p:RegExp;
	final m:RegExpMatch;

	public function new(pString, input, p:RegExp) {
		this.pString = pString;
		this.input = input;
		this.p = p;
		this.m = p.exec(input);
	}
	#else
	public function new(pString, input) {
		this.pString = pString;
		this.input = input;
	}
	#end

	public function matches():Bool {
		#if java
		return m.matches();
		#elseif python
		return m != null;
		#elseif js
		return m != null;
		// return p.test(input);
		#else
		final r = new EReg(pString, "i");
		return r.match(input);
		#end
	}

	public function count():Int {
		#if java
		return m.groupCount();
		#elseif python
		return m.lastindex;
		#elseif js
		return m.length - 1;
		#else
		final r = new EReg(pString, "i");
		if (r.match(input) == false)
			throw new haxe.exceptions.NotImplementedException();

		var i = 1;
		try {
			while (true) {
				r.matched(i);
				i = i + 1;
			}
		} catch (e:haxe.Exception) {
			return i - 1;
		}
		#end
	}

	public function group(n:Int):String {
		#if java
		if (m.matches() == false)
			return null;
		return m.group(n);
		#elseif python
		if (m == null)
			return null;
		return m.group(n);
		#elseif js
		if (m == null)
			return null;
		return m[n];
		#else
		// trace('n=$n');
		final r = new EReg(pString, "i");
		var m = r.match(input);
		// trace('m=$m');
		if (m == false)
			return null;
		return r.matched(n);
		#end
	}
}
