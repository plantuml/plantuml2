package com.plantuml.mindmap;

import haxe.ds.BalancedTree;
import com.plantuml.mindmap.Stripe.BalancedTreeStripe;

class StripeFrontier {
	private final stripes:BalancedTreeStripe = new BalancedTreeStripe();

	public function new() {
		this.stripes.set(new Stripe(-Tetris.MAX_VALUE, Tetris.MAX_VALUE, -Tetris.MAX_VALUE), true);
	}

	public function isEmpty():Bool {
		return stripes.size() == 1;
	}

	public function addSegment(x1:Float, x2:Float, value:Float) {
		if (x2 <= x1) {
			trace("x1=" + x1);
			trace("x2=" + x2);
			throw new haxe.exceptions.NotImplementedException();
		}
		final collisions:BalancedTreeStripe = collisionning(x1, x2);
		if (collisions.size() > 1) {
			final it = collisions.keys();
			it.next();
			var x = x1;
			while (it.hasNext()) {
				final tmp:Stripe = it.next();
				addSegment(x, tmp.getStart(), value);
				x = tmp.getStart();
			}
			addSegment(x, x2, value);
		} else {
			final touch:Stripe = collisions.keys().next();
			addSingleInternal(x1, x2, value, touch);
		}
	}

	function collisionning(x1:Float, x2:Float):BalancedTreeStripe {
		final result:BalancedTreeStripe = new BalancedTreeStripe();
		for (stripe in stripes.keys()) {
			if (x1 >= stripe.getEnd())
				continue;
			result.add(stripe);
			if (x2 <= stripe.getEnd())
				return result;
		}
		throw new haxe.exceptions.NotImplementedException();
	}

	function addSingleInternal(x1:Float, x2:Float, value:Float, touch:Stripe) {
		if (value <= touch.getValue())
			return;

		final ok = this.stripes.remove(touch);
		if (!ok)
			throw new haxe.exceptions.NotImplementedException();

		if (touch.getStart() != x1)
			this.stripes.add(new Stripe(touch.getStart(), x1, touch.getValue()));

		this.stripes.add(new Stripe(x1, x2, value));
		if (x2 != touch.getEnd())
			this.stripes.add(new Stripe(x2, touch.getEnd(), touch.getValue()));

		// assert checkConsistent();
	}

	public function getContact(x1:Float, x2:Float):Float {
		final collisions:BalancedTreeStripe = collisionning(x1, x2);
		var result = -Tetris.MAX_VALUE;
		for (strip in collisions.keys())
			result = Math.max(result, strip.getValue());

		return result;
	}
}
