package tcom;

import com.plantuml.utils.AbstractEnumTools;
import utest.*;

using hx.strings.Strings;

@:enum
abstract HttpStatus1(Int) {
	var NotFound1 = 404;
	var MethodNotAllowed1 = 405;

	public function doit() {
		trace('I am in doit $this');
	}
}

@:enum
abstract HttpStatus2(String) {
	var NotFound2 = "string404";
	var MethodNotAllowed2 = "string405";

	public function doit() {
		trace('I am in $this');
	}
}

class EnumTest extends utest.Test {
	function testBasicThing1() {
		final v = NotFound1;
		Assert.equals(NotFound1, v);
		trace('v=$v');
		v.doit();

		var values = AbstractEnumTools.getValues(HttpStatus1);
		trace(values);
	}

	function testBasicThing2() {
		final v2 = NotFound2;
		Assert.equals(NotFound2, v2);
		trace('v=$v2');
		v2.doit();

		var values = AbstractEnumTools.getValues(HttpStatus2);
		trace(values);
	}
}
