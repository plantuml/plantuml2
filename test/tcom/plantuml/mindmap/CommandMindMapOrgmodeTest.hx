package tcom.plantuml.mindmap;

import com.plantuml.mindmap.CommandMindMapOrgmode;
import com.plantuml.command.BlocLines;
import com.plantuml.command.CommandControl;
import utest.Assert;

class CommandMindMapOrgmodeTest extends utest.Test {
	function testBasicThing1() {
		var cmd = new CommandMindMapOrgmode();
		var lines = new BlocLines(["* toto1"]);
		Assert.equals(CommandControl.OK, cmd.isValid(lines));
	}
}
