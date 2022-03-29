package tcom;

import utest.*;

using hx.strings.Strings;

class UnicodeTest extends utest.Test {
	function testBasicThing1() {
		final v = "a";
		Assert.equals("a", v);
	}

	#if !js
	function testUnicode1() {
		final v = "é";
		Assert.equals(1, v.length8());
		Assert.equals(1, v.length);
		Assert.equals("é", v);
		Assert.equals("&#233;", v.htmlEncode());
	}

	function testUnicode2() {
		final v = "なダイアグラム";
		Assert.equals(7, v.length8());
		Assert.equals(7, v.length);
		Assert.equals("なダイアグラム", v);
		Assert.equals("&#12394;&#12480;&#12452;&#12450;&#12464;&#12521;&#12512;", v.htmlEncode());
	}
	#end

	function testDecode1() {
		final v = "&#233;".htmlDecode();
		Assert.equals(1, v.length8());
		Assert.equals(1, v.length);
		Assert.equals("&#233;".htmlDecode(), v);
		Assert.equals("&#233;", v.htmlEncode());
	}

	function testDecode2() {
		final v = "&#12394;&#12480;&#12452;&#12450;&#12464;&#12521;&#12512;".htmlDecode();
		Assert.equals(7, v.length8());
		Assert.equals(7, v.length);
		Assert.equals("&#12394;&#12480;&#12452;&#12450;&#12464;&#12521;&#12512;".htmlDecode(), v);
		Assert.equals("&#12394;&#12480;&#12452;&#12450;&#12464;&#12521;&#12512;", v.htmlEncode());
	}
}
