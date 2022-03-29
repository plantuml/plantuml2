package tcom.plantuml.core;

import com.plantuml.core.DiagramType;
import utest.Assert;
import com.plantuml.utils.AbstractEnumTools;
import com.plantuml.*;

class DiagramTypeTest extends utest.Test {
	function testType() {
		final v1 = DiagramType.MINDMAP;
		Assert.notNull(v1);

		final all:Array<DiagramType> = AbstractEnumTools.getValues(DiagramType);
		Assert.equals(3, all.length);

		final type = DiagramType.getTypeFromArobaseStart("@startmindmap");
		Assert.equals(DiagramType.MINDMAP, type);

		final type = DiagramType.getTypeFromArobaseStart("foo");
		Assert.equals(DiagramType.UNKNOWN, type);
	}
}
