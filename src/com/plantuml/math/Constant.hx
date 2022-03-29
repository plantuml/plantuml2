package com.plantuml.math;

// https://github.com/skial/min-max/blob/master/src/be/Constant.hx

class Constant {}
typedef Ints = I;

@:notNull abstract I(Int) from Int to Int {
	public static var MIN(get, never):Int;

	private static inline function get_MIN():Int {
		#if flash
		return untyped __global__['int'].MIN_VALUE;
		#elseif js
		return js.Syntax.code('Number.MIN_SAFE_INTEGER');
		#elseif cs
		return untyped __cs__('int.MinValue');
		#elseif java
		return untyped __java__('Integer.MIN_VALUE');
		#elseif (cpp || hl || neko)
		return -2147483648;
		#elseif python
		return -Sys.maxsize - 1;
		#elseif php
		return php.Const.PHP_INT_MIN;
		#else
		return -2147483648; //-2^31;
		#end
	}

	public static var MAX(get, never):Int;

	private static inline function get_MAX():Int {
		#if flash
		return untyped __global__['int'].MAX_VALUE;
		#elseif js
		return js.Syntax.code('Number.MAX_SAFE_INTEGER');
		#elseif cs
		return untyped __cs__('int.MaxValue');
		#elseif java
		return untyped __java__('Integer.MAX_VALUE');
		#elseif (cpp || hl || neko)
		return 2147483647;
		#elseif python
		return Sys.maxsize;
		#elseif php
		return php.Const.PHP_INT_MAX;
		#else
		return 2147483647; // 2^31-1;
		#end
	}
}

#if python
@:pythonImport("sys")
private extern class Sys {
	public static var maxsize:Int;
}
#end
