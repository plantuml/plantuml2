package tcom.plantuml.mindmap;

import com.plantuml.mindmap.StripeFrontier;
import utest.*;

class StripeFrontierTest extends utest.Test {
	function testBasicThing1() {
		var cut = new StripeFrontier();
		Assert.isTrue(cut.isEmpty());
	}
}
