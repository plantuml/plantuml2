package tcom.plantuml.command.regex;

import com.plantuml.command.regex.*;
import utest.Assert;

class RegexLeaf2Test extends utest.Test {
	function testSpace() {
		var leaf = new RegexLeaf(1, "[%s]*<<(.+)>>", "STEREO");
		var r = new RegexConcat([leaf]);
		var res = r.matcher("   <<foo>>");
		Assert.equals("foo", res["STEREO"]);
	}
}
