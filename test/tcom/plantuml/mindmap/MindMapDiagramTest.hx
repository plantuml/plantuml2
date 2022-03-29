package tcom.plantuml.mindmap;

import utest.Assert;
import com.plantuml.ugraphic.UGraphicSvg;
import com.plantuml.api.v1.*;
import com.plantuml.command.BlocLines;
import com.plantuml.command.regex.RegexLeaf;
import com.plantuml.mindmap.MindMapDiagramFactory;

class MindMapDiagramTest extends utest.Test {
	function testBasicThing1() {
		var lines = new BlocLines([
			"* WORLD", "** America", "*** Canada", "*** USA", "** Europe", "*** UK ", "*** France", "*** Germany", "*** Italy", "** Africa"
		]);

		var factory = new MindMapDiagramFactory();

		var diagram = factory.createSystem(lines);
		Assert.notNull(diagram);

		var svg:UGraphicSvg = UGraphicSvg.create();
		diagram.exportDiagramNow(svg);
		var s = svg.getSvg();

		#if js
		#else
		sys.io.File.saveContent('MinMapDiagramTest.svg', s);
		#end
	}
}
