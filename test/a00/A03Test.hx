package a00;

import com.plantuml.api.v2.Plantuml;
import utest.Assert;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

class A03Test extends AbstractTest {
	function testExecute() {
		final diag = "
		@startmindmap
		* Debian
		**: This is ubuntu
		on several
		lines;
		*** Linux Mint
		*** Kubuntu
		*** Lubuntu
		*** KDE Neon
		** LMDE
		** SolydXK
		** SteamOS
		** Raspbian with a very long name
		@endmindmap		";
		final sha1 = exportSvgAndGetSha1(diag);
		final ok = Assert.equals("ed5c8ac78107784d12dfbc76658a8e9d3eca0723", sha1);
		if (!ok)
			errorInSha1(sha1);
	}
}
