package tcom;

import com.plantuml.utils.MacroUtils;
import com.plantuml.utils.AbstractEnumTools;
import utest.*;

using hx.strings.Strings;

class Foo {
	public static macro function trace_build_age_with_reification() {
		// https://code.haxe.org/category/macros/generating-code-in-a-macro.html
		final buildTime = Math.floor(Date.now().getTime() / 1000);

		var e = macro {
			var runTime = Math.floor(Date.now().getTime() / 1000);
			var age = runTime - $v{buildTime};
			trace("Foo it's " + runTime + ", and this build is " + age + " seconds old");
		};

		return e;
	}

	public static macro function foobar2():haxe.macro.Expr.ExprOf<String> {
		// https://haxe.org/manual/macro-reification-expression.html
		var commitHash:String = "foobar2";
		return macro $v{commitHash};
	}

	public static macro function buildTime():haxe.macro.Expr.ExprOf<Int> {
		var buildTime = Math.floor(Date.now().getTime() / 1000);
		return macro $v{buildTime};
	}
}

class MacroTest extends utest.Test {
	function testBuildTime() {
		final t:Float = MacroUtils.buildTime();
		trace('Buildtime MacroUtils is $t');
		Assert.isTrue(t > 0);
	}

	function testBuildTimeFoo() {
		final t:Int = Foo.buildTime();
		trace('Buildtime foo is $t');
		Assert.isTrue(t > 0);
	}

	function testMacrofoobar2() {
		final t = Foo.foobar2();
		trace(t);
		final i = 2 + 3;
		Assert.equals(5, i);
	}

	function testMacroTime() {
		Foo.trace_build_age_with_reification();
		final i = 2 + 3;
		Assert.equals(5, i);
	}
}
