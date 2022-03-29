package a00;

import com.plantuml.api.v2.Plantuml;
import utest.Assert;

using com.plantuml.utils.StartUtils;
using hx.strings.Strings;

class A01Test extends AbstractTest {
	function testExecute() {
		final diag = "
			@startmindmap
			* Debianなダイアグラム
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
		final v = "&#12394;&#12480;&#12452;&#12450;&#12464;&#12521;&#12512;".htmlDecode();
		final diag2 = '
			@startmindmap
			* Debian$v
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
		';
		#if !js
		Assert.equals(diag, diag2);
		#end
		final sha1 = exportSvgAndGetSha1(diag2);
		final ok = Assert.equals("abeeabe3bb73e27ea2dd8035b552019ba933ea61", sha1);
		if (!ok)
			errorInSha1(sha1);
	}
}
