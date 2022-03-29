package tcom;

import utest.*;
#if js
import js.lib.RegExp;
#end
#if python
import python.lib.Re;
#end
#if java
import java.util.regex.Pattern;
#end

using hx.strings.Strings;

class UnicodeRegexTest extends utest.Test {
	function testBasicThing1() {
		var r = new EReg("\\w", "i");
		Assert.isTrue(r.match(getLetter()));
	}

	#if python
	function testBasicThing1AccentPython() {
		// https://api.haxe.org/python/lib/Regex.html

		final onlyLetter:Pattern = Re.compile("[^\\W\\d_]", Re.UNICODE);
		final onlyDigit:Pattern = Re.compile("[\\d]", Re.UNICODE);

		final tmp:MatchObject = Re.match(onlyLetter, getLetterAccent());

		Assert.notNull(Re.match(onlyLetter, getLetterAccent()));
		Assert.isNull(Re.match(onlyDigit, getLetterAccent()));

		Assert.notNull(Re.match(onlyLetter, getLetter()));
		Assert.isNull(Re.match(onlyDigit, getLetter()));

		Assert.isNull(Re.match(onlyLetter, getNumber()));
		Assert.notNull(Re.match(onlyDigit, getNumber()));
	}
	#end

	#if java
	function testBasicThing1AccentJava() {
		// https://api.haxe.org/java/util/regex/Pattern.html
		var onlyLetter = Pattern.compile("[\\p{L}]");
		var onlyDigit = Pattern.compile("\\d");

		Assert.isTrue(onlyLetter.matcher(getLetterAccent()).matches());
		Assert.isFalse(onlyDigit.matcher(getLetterAccent()).matches());

		Assert.isTrue(onlyLetter.matcher(getLetter()).matches());
		Assert.isFalse(onlyDigit.matcher(getLetter()).matches());

		Assert.isFalse(onlyLetter.matcher(getNumber()).matches());
		Assert.isTrue(onlyDigit.matcher(getNumber()).matches());
	}
	#end

	#if js
	function testBasicThing1AccentJs() {
		// https://api.haxe.org/js/lib/RegExp.html
		var onlyLetter = new RegExp("\\w", "u");
		var onlyDigit = new RegExp("\\d", "u");

		final m:RegExpMatch = onlyLetter.exec(getLetter());
		trace('mmm1=$m');
		Assert.equals(getLetter(), m[0]);
		final gg = m.groups;
		trace('gg1=$gg');
	}

	function testBasicThing1AccentJs2() {
		// https://api.haxe.org/js/lib/RegExp.html
		var onlyLetter = new RegExp("\\w", "u");
		var onlyDigit = new RegExp("\\d", "u");

		final m:RegExpMatch = onlyLetter.exec(getNumber());
		trace('mmm0=$m');
		Assert.equals(getNumber(), m[0]);
		final gg = m.groups;
		trace('gg0=$gg');
	}

	function testBasicThing1AccentJsOld() {
		// https://api.haxe.org/js/lib/RegExp.html
		var onlyLetter = new RegExp("\\p{L}", "u");
		var onlyDigit = new RegExp("\\d", "u");

		Assert.isTrue(onlyLetter.test(getLetterAccent()));
		Assert.isFalse(onlyDigit.test(getLetterAccent()));

		Assert.isTrue(onlyLetter.test(getLetter()));
		Assert.isFalse(onlyDigit.test(getLetter()));

		Assert.isFalse(onlyLetter.test(getNumber()));
		Assert.isTrue(onlyDigit.test(getNumber()));
	}
	#end

	function testBasic1() {
		var onlyLetter = new EReg("[^\\W\\d_]", "i");
		var onlyDigit = new EReg("\\d", "i");

		#if !js
		Assert.isTrue(onlyLetter.match(getLetterAccent()));
		Assert.isFalse(onlyDigit.match(getLetterAccent()));
		#end

		Assert.isTrue(onlyLetter.match(getLetter()));
		Assert.isFalse(onlyDigit.match(getLetter()));

		Assert.isFalse(onlyLetter.match(getNumber()));
		Assert.isTrue(onlyDigit.match(getNumber()));
	}

	function getLetter() {
		final s = "a";
		Assert.equals(1, s.length8());
		Assert.equals(1, s.length);
		return s;
	}

	function getNumber() {
		final s = "2";
		Assert.equals(1, s.length8());
		Assert.equals(1, s.length);
		return s;
	}

	function getLetterAccent() {
		final s = "&#12480;".htmlDecode();
		#if !js
		Assert.equals("ダ", s);
		#end
		Assert.equals("&#12480;", s.htmlEncode());
		Assert.equals(1, s.length8());
		Assert.equals(1, s.length);
		return s;
	}

	function getLetterAccent2() {
		final s = "&#233;".htmlDecode();
		#if !js
		Assert.equals("é", s);
		#end
		Assert.equals("&#233;", s.htmlEncode());
		Assert.equals(1, s.length8());
		Assert.equals(1, s.length);
		return s;
	}
}
