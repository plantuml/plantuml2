package com.plantuml.ugraphic.color;

/**
 * https://github.com/peteshand/color
 * 
 * @author P.J.Shand
 */
abstract Color(Null<UInt>) from Int from UInt to Null<UInt> {
	public var red(get, set):UInt;
	public var green(get, set):UInt;
	public var blue(get, set):UInt;
	public var alpha(get, set):UInt;

	public function new(value:Null<UInt>) {
		this = value;
	}

	inline function get_red():UInt {
		if (this == null)
			return 0;
		return (this & 0x00ff0000) >>> 16;
	}

	inline function get_green():UInt {
		if (this == null)
			return 0;
		return (this & 0x0000ff00) >>> 8;
	}

	inline function get_blue():UInt {
		if (this == null)
			return 0;
		return this & 0x000000ff;
	}

	inline function get_alpha():UInt {
		if (this == null)
			return 0;
		return this >>> 24;
	}

	inline function set_red(value:UInt):UInt {
		this = (alpha << 24) | (value << 16) | (green << 8) | blue;
		return value;
	}

	inline function set_green(value:UInt):UInt {
		this = (alpha << 24) | (red << 16) | (value << 8) | blue;
		return value;
	}

	inline function set_blue(value:UInt):UInt {
		this = (alpha << 24) | (red << 16) | (green << 8) | value;
		return value;
	}

	inline function set_alpha(value:UInt):UInt {
		this = (value << 24) | (red << 16) | (green << 8) | blue;
		return value;
	}

	@:from
	static public function fromString(s:String) {
		if (s == null)
			return null;
		if (s.indexOf("#") == 0)
			return new Color(Std.parseInt("0x" + s.substring(1, s.length)));
		else if (s.indexOf("0x") == 0)
			return new Color(Std.parseInt(s));
		// unable to parse
		return new Color(0);
	}

	public function mix(color:Color, strength:Float):Color {
		var output:Color = new Color(0);
		output.red = Math.floor((red * (1 - strength)) + (color.red * strength));
		output.green = Math.floor((green * (1 - strength)) + (color.green * strength));
		output.blue = Math.floor((blue * (1 - strength)) + (color.blue * strength));
		output.alpha = Math.floor((alpha * (1 - strength)) + (color.alpha * strength));
		return output;
	}

	public function toString() {
		return "#" + StringTools.hex(this, 6);
	}

	public function hsl():HSL {
		var max:Float = Math.max(red, green);
		max = Math.max(max, blue);
		var min:Float = Math.min(red, green);
		min = Math.min(min, blue);

		var hue:Float = 0;
		var saturation:Float = 0;
		var value:Float = 0;

		// get Hue
		if (max == min)
			hue = 0;
		else if (max == red)
			hue = (60 * (green - blue) / (max - min) + 360) % 360;
		else if (max == green)
			hue = (60 * (blue - red) / (max - min) + 120);
		else if (max == blue)
			hue = (60 * (red - green) / (max - min) + 240);

		// get Value
		value = max;

		// get Saturation
		if (max == 0) {
			saturation = 0;
		} else {
			saturation = (max - min) / max;
		}

		return {
			hue: Math.round(hue),
			saturation: Math.round(saturation * 100),
			lightness: Math.round(value / 255 * 100),
		};
	}
}

typedef HSL = {
	hue:Int,
	saturation:Int,
	lightness:Int
}
