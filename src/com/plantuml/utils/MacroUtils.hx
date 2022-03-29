package com.plantuml.utils;

class MacroUtils {
	public static macro function buildTimeOld():haxe.macro.Expr.ExprOf<Int> {
		final buildTime = Math.floor(Date.now().getTime() / 1000);
		return macro $v{buildTime};
	}

	public static macro function buildTime():haxe.macro.Expr.ExprOf<Float> {
		final buildTime = Date.now().getTime();
		return macro $v{buildTime};
	}
}
