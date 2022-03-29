package com.plantuml.mindmap;

import haxe.ds.BalancedTree;

class BalancedTreeStripe extends BalancedTree<Stripe, Bool> {
	override function compare(k1:Stripe, k2:Stripe) {
		return Reflect.compare(k1.getStart(), k2.getStart());
	}

	public function size():Int {
		var cpt = 0;
		for (k in this.keys())
			cpt++;
		return cpt;
	}

	public function add(key:Stripe) {
		this.set(key, true);
	}
}

class Stripe {
	private final x1:Float;
	private final x2:Float;
	private final value:Float;

	public function new(x1:Float, x2:Float, value:Float) {
		if (x2 <= x1)
			throw new haxe.exceptions.NotImplementedException();

		this.x1 = x1;
		this.x2 = x2;
		this.value = value;
	}

	public function contains(x:Float):Bool {
		return x >= x1 && x <= x2;
	}

	public function toString():String {
		return "" + x1 + "->" + x2 + " (" + value + ")";
	}

	// public int compareTo(Stripe other) {
	// 	return (int) Math.signum(this.x1 - other.x1);
	// }
	public function getValue():Float {
		return value;
	}

	public function getStart():Float {
		return x1;
	}

	public function getEnd():Float {
		return x2;
	}
}
