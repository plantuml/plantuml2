package tcom.plantuml.svg;

import com.plantuml.svg.SvgGraphics;
import utest.*;

using com.plantuml.utils.StartUtils;

class SvgGraphicsTest extends utest.Test {
	function testBasicThing0() {
		var s = "azertyzz".orderMe();
		Assert.equals("a(1)e(1)r(1)t(1)y(1)z(3)", s);
		Assert.equals("13ce5723ce8efb4bdd4930c4b4e3ec4ae912034b", s.sha1());
	}

	function testBasicThing1() {
		final svg = new SvgGraphics();
		final result = svg.toSvg();
		Assert.equals("7f3c67ffccd13e15f52309276a5bd48540a5a33b", result.orderMe().sha1());
	}

	function testBasicThing2() {
		final svg = new SvgGraphics();
		svg.text("Hello World", 10, 10, "", 14, "", "plain", "", 100.0, [], "white");
		final result = svg.toSvg();
		Assert.equals("d3185d5463c0e26fe495e573d261721cac8cdc91", result.orderMe().sha1());
	}
}
