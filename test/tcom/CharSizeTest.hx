package tcom;

import com.plantuml.ugraphic.UTranslate;
import com.plantuml.ugraphic.URectangle;
import com.plantuml.ugraphic.color.HColor;
import com.plantuml.graphic.FontConfiguration;
import com.plantuml.ugraphic.UText;
import com.plantuml.ugraphic.UGraphicSvg;
import hx.strings.StringBuilder;
import hx.strings.Char;
import utest.Assert;

using hx.strings.Strings;

class CharSizeTest extends utest.Test {
	function testSimple() {
		final s = "A".code;
		final ascii = "A".charCodeAt(0);
		Assert.equals(65, s);
		Assert.equals(65, ascii);
	}

	function testSimple2() {
		final c:Char = 65.toChar();
		Assert.equals("A", "" + c);
	}

	function testUnicode() {
		final ascii = getLetterAccent().charCodeAt(0);
		Assert.equals(12480, ascii);
	}

	function testGetLongString() {
		exportCodepoints(0xA1, 0xFF);
		exportCodepoints("!".code, "~".code);
	}

	function exportCodepoints(codepoint1, codepoint2) {
		var ug = UGraphicSvg.create();
		final sb = ug.getStringBounder();
		final fc = FontConfiguration.create(HColor.plain("#000000"));
		for (codepoint in codepoint1...(codepoint2 + 1)) {
			var text = getLongString(codepoint, 32 * 2);
			Assert.equals(32 * 2, text.length);
			final dim = sb.calculateDimension(fc.getFont(), text);
			final rect = new URectangle(dim.getWidth(), dim.getHeight());
			final rectLong = new URectangle(dim.getWidth() * 3, dim.getHeight());
			final ug2 = ug.apply(UTranslate.dx(40));
			final num = StringTools.hex(codepoint);
			ug.draw(new UText(num, fc));
			ug2.apply(HColor.plain("#FFFFFF")).draw(rectLong);
			ug2.apply(HColor.plain("#FF0000")).draw(rect);
			ug2.draw(new UText(text, fc));
			ug = ug.apply(UTranslate.dy(dim.getHeight() + 10));
		}
		final svg = ug.getSvg();
		final filename = 'unicode/unicode-$codepoint1-$codepoint2.svg';
		#if !js
		sys.FileSystem.createDirectory("unicode");
		sys.io.File.saveContent(filename, svg);
		#end
	}

	function getLetterAccent() {
		final s = "&#12480;".htmlDecode();
		#if !js
		Assert.equals("ダ", s);
		#end
		Assert.equals("&#12480;", s.htmlEncode());
		Assert.equals(1, s.length8());
		Assert.equals(1, s.length);
		Assert.equals(s, "" + 12480.toChar());
		return s;
	}

	function getLongString(codepoint:Int, size:Int) {
		final sb = new StringBuilder();
		for (i in 0...size)
			sb.add("" + codepoint.toChar());
		return sb.toString();
	}
}
