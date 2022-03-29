package com.plantuml.svg;

using hx.strings.Strings;

class SvgSizeAsciiUtils {
	public static function between(c:Int, min:Int, max:Int):Bool {
		return c >= min && c <= max;
	}

	public static function isOneOf(c:Int, all:Array<Int>):Bool {
		return all.contains(c);
	}

	public static function asciiSize(c:Int):Int {
		switch (c) {
			case " ".code:
				return 500;
			case "!".code:
				return 410;
			case "\"".code:
				return 430;
			case "#".code:
				return 990;
			case "$".code:
				return 900;
			case "%".code:
				return 1170;
			case "&".code:
				return 1000;
			case "'".code:
				return 200;
			case "(".code | ")".code:
				return 560;
			case "*".code:
				return 690;
			case "+".code:
				return 910;
			case ",".code:
				return 320;
			case "-".code:
				return 440;
			case ".".code:
				return 420;
			case "/".code:
				return 490;
			case "0".code | "1".code | "2".code | "3".code | "4".code | "5".code | "6".code | "7".code | "8".code | "9".code:
				return 900;
			case ":".code:
				return 390;
			case ";".code:
				return 340;
			case "<".code:
				return 820;
			case "=".code:
				return 880;
			case ">".code:
				return 840;
			case "?".code:
				return 760;
			case "@".code:
				return 1440;
			case "A".code:
				return 1050;
			case "B".code:
				return 1000;
			case "C".code:
				return 1040;
			case "D".code:
				return 1050;
			case "E".code:
				return 910;
			case "F".code:
				return 890;
			case "G".code:
				return 1090;
			case "H".code:
				return 1140;
			case "I".code:
				return 440;
			case "J".code:
				return 890;
			case "K".code:
				return 1010;
			case "L".code:
				return 860;
			case "M".code:
				return 1400;
			case "N".code:
				return 1140;
			case "O".code:
				return 1100;
			case "P".code:
				return 1010;
			case "Q".code:
				return 1100;
			case "R".code:
				return 990;
			case "S".code:
				return 950;
			case "T".code:
				return 970;
			case "U".code:
				return 1040;
			case "V".code:
				return 1020;
			case "W".code:
				return 1420;
			case "X".code:
				return 1010;
			case "Y".code:
				return 980;
			case "Z".code:
				return 960;
			case "[".code | "]".code:
				return 430;
			case "\\".code:
				return 670;
			case "^".code:
				return 680;
			case "_".code:
				return 740;
			case "`".code:
				return 510;
			case "a".code:
				return 880;
			case "b".code:
				return 910;
			case "c".code:
				return 850;
			case "d".code:
				return 910;
			case "e".code:
				return 860;
			case "f".code:
				return 570;
			case "g".code:
				return 910;
			case "h".code:
				return 890;
			case "i".code:
				return 400;
			case "j".code:
				return 390;
			case "k".code:
				return 820;
			case "l".code:
				return 400;
			case "m".code:
				return 1420;
			case "n".code:
				return 900;
			case "o".code:
				return 930;
			case "p".code:
				return 910;
			case "q".code:
				return 920;
			case "r".code:
				return 550;
			case "s".code:
				return 840;
			case "t".code:
				return 540;
			case "u".code:
				return 900;
			case "v".code:
				return 790;
			case "w".code:
				return 1220;
			case "x".code:
				return 810;
			case "y".code:
				return 770;
			case "z".code:
				return 810;
			case "{".code | "}".code:
				return 560;
			case "|".code:
				return 400;
			case "~".code:
				return 1100;
		}
		return 0;
	}
}
