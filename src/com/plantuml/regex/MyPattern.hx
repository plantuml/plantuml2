package com.plantuml.regex;

using hx.strings.Strings;

class MyPattern {
	public static function cmpile(p:String):Pattern2 {
		// trace('before=$p');
		p = transform(p);
		// trace('after =$p');
		return new Pattern2(p);
	}

	static function transform(s:String):String {
		#if python
		s = s.replaceAll("[%%LN]", "[^\\W_]");
		s = s.replaceAll("[%%L]", "[^\\W\\d_]");
		s = s.replaceAll("[%%UL]", "[^\\W\\d]");
		#else
		s = s.replaceAll("[%%LN]", "[\\p{L}0-9]");
		s = s.replaceAll("[%%L]", "[\\p{L}]");
		s = s.replaceAll("[%%UL]", "[_\\p{L}]");
		#end

		#if js
		s = s.replaceAll("%s", "\\s"); // space
		s = s.replaceAll("%q", "'"); // quote
		s = s.replaceAll("%g", "\""); // double quote
		#else
		s = s.replaceAll("%s", "\\s\u00A0"); // space
		s = s.replaceAll("%q", "'\u2018\u2019"); // quote
		s = s.replaceAll("%g", "\"\u201c\u201d\u00ab\u00bb"); // double quote
		#end

		return s;
	}

	// private static String transform(String p) {
	// 	// Replace ReadLineReader.java
	// 	p = p.replace("%pLN", "\\p{L}0-9"); // Unicode Letter, digit
	// 	p = p.replace("%s", "\\s\u00A0"); // space
	// 	p = p.replace("%q", "'\u2018\u2019"); // quote
	// 	p = p.replace("%g", "\"\u201c\u201d\u00ab\u00bb"); // double quote
	// 	return p;
	// }
}
