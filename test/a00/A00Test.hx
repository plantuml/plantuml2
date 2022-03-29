package a00;

import com.plantuml.api.v2.Plantuml;
import utest.Assert;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

class A00Test extends AbstractTest {
	function testExecute() {
		final diag = "
			@startmindmap
			* Debian
			** Ubuntu
			*** Linux Mint
			*** Kubuntu
			*** Lubuntu
			*** KDE Neon
			** LMDE
			** SolydXK
			** SteamOS
			** Raspbian with a very long name
			@endmindmap
		";
		final sha1 = exportSvgAndGetSha1(diag);
		final ok = Assert.equals("72353dffe5ef92e92fa1de7398784a4cba300b3c", sha1);
		if (!ok)
			errorInSha1(sha1);
	}
}
