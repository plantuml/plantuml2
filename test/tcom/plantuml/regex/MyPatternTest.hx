package tcom.plantuml.regex;

import com.plantuml.regex.MyPattern;

using hx.strings.Strings;

import utest.Assert;

class MyPatternTest extends utest.Test {
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

	function testL() {
		final s = "^([%%L]*)(\\d*)$";
		final p = MyPattern.cmpile(s);

		final m = p.matcher(getLetterAccent() + "abc123");
		Assert.isTrue(m.matches());
		Assert.equals(getLetterAccent() + "abc", m.group(1));
		Assert.equals("123", m.group(2));
		Assert.equals(2, m.count());

		final m2 = p.matcher(";abc123");
		Assert.isFalse(m2.matches());
		Assert.isNull(m2.group(1));
		Assert.isNull(m2.group(2));

		Assert.isFalse(p.matcher("_abc123").matches());
	}

	function testUL() {
		final s = "^([%%UL]*)(\\d*)$";
		final p = MyPattern.cmpile(s);

		final m = p.matcher(getLetterAccent() + "abc123");
		Assert.isTrue(m.matches());
		Assert.equals(getLetterAccent() + "abc", m.group(1));
		Assert.equals("123", m.group(2));

		final m2 = p.matcher(";abc123");
		Assert.isFalse(m2.matches());
		Assert.isNull(m2.group(1));
		Assert.isNull(m2.group(2));

		Assert.isTrue(p.matcher("_abc123").matches());
	}

	function testLN() {
		final s = "^([%%LN]*)(\\d*)$";
		final p = MyPattern.cmpile(s);

		Assert.isTrue(p.matcher(getLetterAccent() + "abc123").matches());
	}

	function testGroup1() {
		final s = "^([%%UL]+)(?:foo)([0-9]+)$";
		final p = MyPattern.cmpile(s);

		final m = p.matcher("abc_sdf_foo123");
		Assert.isTrue(m.matches());
		Assert.equals("abc_sdf_", m.group(1));
		Assert.equals("123", m.group(2));
		Assert.equals(2, m.count());
	}

	function testGroup2() {
		final s = "^([%%UL]+)(?:[fo]+)([0-9]+)$";
		final p = MyPattern.cmpile(s);

		final m = p.matcher("abc_sdf_foo123");
		Assert.isTrue(m.matches());
		Assert.equals("abc_sdf_fo", m.group(1));
		Assert.equals("123", m.group(2));
	}

	function testGroup3() {
		final s = "^([%%UL]+?)(?:[fo]+)([0-9]+)$";
		final p = MyPattern.cmpile(s);

		final m = p.matcher("abc_sdf_foo123");
		Assert.isTrue(m.matches());
		Assert.equals("abc_sdf_", m.group(1));
		Assert.equals("123", m.group(2));
	}

	function testGroup3b() {
		final s = "^([%%UL]+?)([fo]+)([0-9]+)$";
		final p = MyPattern.cmpile(s);

		final m = p.matcher("abc_sdf_foo123");
		Assert.isTrue(m.matches());
		Assert.equals("abc_sdf_", m.group(1));
		Assert.equals("123", m.group(3));
		Assert.equals(3, m.count());
	}

	function testGroup4() {
		final s = "^([%s]+[%q]+[%g]+)$";
		final p = MyPattern.cmpile(s);

		Assert.isTrue(p.matcher("    '''''\"\"\"\"").matches());
		Assert.isFalse(p.matcher("'''''   \"\"\"\"").matches());
	}

	function testBasicThing2() {
		final s = "^([a-z]*)(\\d*)$";
		final p = MyPattern.cmpile(s);

		final m = p.matcher("abc123");
		Assert.isTrue(m.matches());
		Assert.equals("abc", m.group(1));
		Assert.equals("123", m.group(2));

		final m2 = p.matcher(";abc123");
		Assert.isFalse(m2.matches());
		Assert.isNull(m2.group(1));
		Assert.isNull(m2.group(2));
	}
}
