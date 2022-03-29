package a00;

import com.plantuml.api.v2.Plantuml;
import utest.Assert;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

class A02Test extends AbstractTest {
	function testExecute() {
		final diag = "
			@startmindmap
			ERROR
			@endmindmap
		";
		final sha1 = exportSvgAndGetSha1(diag);
		final ok = Assert.equals("48969683cf7d7b788123884c734fed7615bf3d4e", sha1);
		if (!ok)
			errorInSha1(sha1);
	}
}
