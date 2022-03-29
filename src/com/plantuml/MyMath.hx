package com.plantuml;

class MyMath {
	private final a:Float;
	private final b:Float;

	public function new(a:Float, b:Float) {
		this.a = a;
		this.b = b;
	}

	public function sum(?c:Float = 0) {
		final sum = a + b + c;
		return sum;
	}

	static function main() {
		final res = new MyMath(7, 9);
		var s = res.sum();
		trace(s);

		trace(res.sum(8));
	}
}
