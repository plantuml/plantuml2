package com.plantuml.svg;

using hx.strings.Strings;
using com.plantuml.svg.SvgSizeAsciiUtils;

class SvgSizeUtils {
	public static function singleSize(c:Int):Int {
		final v1 = SvgSizeAsciiUtils.asciiSize(c);
		if (v1 != 0)
			return v1;
		if (c == 0xA1)
			return SvgSizeAsciiUtils.asciiSize("!".code);
		if (c.isOneOf([0xB4, 0xB8]))
			return SvgSizeAsciiUtils.asciiSize("`".code);
		if (c.between(0xA2, 0xA5))
			return SvgSizeAsciiUtils.asciiSize("0".code);
		if (c.between(0xC0, 0xC5))
			return SvgSizeAsciiUtils.asciiSize("A".code);
		if (c.between(0xC8, 0xCB))
			return SvgSizeAsciiUtils.asciiSize("E".code);
		if (c.between(0xD2, 0xD6))
			return SvgSizeAsciiUtils.asciiSize("O".code);
		if (c.isOneOf([0xD8]))
			return SvgSizeAsciiUtils.asciiSize("O".code);
		if (c.between(0xD9, 0xDD))
			return SvgSizeAsciiUtils.asciiSize("U".code);
		if (c.between(0xE0, 0xE5))
			return SvgSizeAsciiUtils.asciiSize("a".code);
		return 1500;
	}
}
