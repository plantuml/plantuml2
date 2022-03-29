package com.plantuml.regex;

#if js
import js.lib.RegExp;
#end
#if python
import python.lib.Re;
#end
#if java
import java.util.regex.Pattern;
#end

class Pattern2 {
	final pString:String;
	#if java
	final p:Pattern;
	#elseif python
	final p:Pattern;
	#elseif js
	final p:RegExp;
	#end

	public function getPatternString():String {
		return pString;
	}

	public function new(pString:String) {
		this.pString = pString;
		#if java
		this.p = Pattern.compile(pString);
		#elseif python
		this.p = Re.compile(pString, Re.UNICODE);
		#elseif js
		this.p = new RegExp(pString, "u");
		#end
	}

	public function matcher(input:String):Matcher2 {
		#if java
		return new Matcher2(pString, input, p);
		#elseif python
		return new Matcher2(pString, input, p);
		#elseif js
		return new Matcher2(pString, input, p);
		#else
		return new Matcher2(pString, input);
		#end
	}
}
