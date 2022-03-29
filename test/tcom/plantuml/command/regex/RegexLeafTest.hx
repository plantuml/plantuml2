package tcom.plantuml.command.regex;

import com.plantuml.command.regex.*;
import com.plantuml.command.regex.RegexLeaf;
import com.plantuml.command.regex.RegexOptional;
import utest.Assert;

class RegexLeafTest extends utest.Test {
	function testAz() {
		final az = new RegexLeaf(1, "([a-z]+)", "name");
		Assert.isTrue(az.match("john"));
		Assert.isFalse(az.match("123"));
	}

	function testNumber() {
		final az = new RegexLeaf(1, "([0-9]+)", "name");
		Assert.isFalse(az.match("john"));
		Assert.isTrue(az.match("123"));
	}

	function test123john() {
		var r = new RegexLeaf(2, "^cmd ([0-9]+) ([a-z]+)$");
		final array = r.matchArray("cmd 123 john");
		Assert.notNull(array);
		Assert.equals(2, array.length);
		Assert.equals("123", array[0]);
		Assert.equals("john", array[1]);

		final array = r.matchArray("cmd123john");
		Assert.isNull(array);
	}

	function testCmd1() {
		var start = new RegexLeaf(0, "^");
		var cmd = new RegexLeaf(1, "(cmd)", "COMMAND");
		var spaces = new RegexLeaf(0, "\\s*");
		var number = new RegexLeaf(1, "([0-9]+)", "NUMBER");
		var az = new RegexLeaf(1, "([a-z]+)", "AZ");
		var end = new RegexLeaf(0, "$");
		var r = new RegexConcat([start, cmd, spaces, number, spaces, az, end]);
		Assert.isTrue(r.match("cmd 123 john"));
	}

	function testCmd2() {
		var start = new RegexLeaf(0, "^");
		var cmd = new RegexLeaf(1, "(cmd)", "COMMAND");
		var spaces = new RegexLeaf(0, "\\s*");
		var number = new RegexLeaf(1, "([0-9]+)", "NUMBER");
		var az = new RegexLeaf(1, "([a-z]+)", "AZ");
		var end = new RegexLeaf(0, "$");
		var r = new RegexConcat([start, cmd, spaces, number, spaces, az, end]);
		// trace(r.match("cmd 123 john"));
		var res = r.matcher("cmd 123 john");
		Assert.equals("123", res.get("NUMBER"));
		Assert.equals("cmd", res.get("COMMAND"));
		Assert.equals("john", res.get("AZ"));
	}

	function testCmd3() {
		var start = new RegexLeaf(0, "^");
		var cmd = new RegexOptional(new RegexLeaf(1, "(cmd)", "COMMAND"));
		var spaces = new RegexLeaf(0, "\\s*");
		var number = new RegexLeaf(1, "([0-9]+)", "NUMBER");
		var az = new RegexLeaf(1, "([a-z]+)", "AZ");
		var end = new RegexLeaf(0, "$");
		var r = new RegexConcat([start, cmd, spaces, number, spaces, az, end]);
		// trace(r.match("cmd 123 john"));
		var res = r.matcher("cmd 123 john");
		Assert.equals("123", res.get("NUMBER"));
		Assert.equals("cmd", res.get("COMMAND"));
		Assert.equals("john", res.get("AZ"));
		var res = r.matcher("123 john");
		Assert.equals("123", res.get("NUMBER"));
		Assert.isNull(res.get("COMMAND"));
		Assert.equals("john", res.get("AZ"));
	}
}
