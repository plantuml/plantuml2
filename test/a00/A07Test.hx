package a00;

import com.plantuml.api.v2.Plantuml;
import utest.Assert;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

class A07Test extends AbstractTest {
	function testExecute() {
		final diag = "
		@startcharsize
		a
		500
		@endcharsize
		";

		final sha1 = exportSvgAndGetSha1(diag);
		final ok = Assert.equals("9380b99d08e3db010843a7e02414b29e9d7e73ec", sha1);
		if (!ok)
			errorInSha1(sha1);
	}
}
