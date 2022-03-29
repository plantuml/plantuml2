package com.plantuml.mindmap;

import com.plantuml.ugraphic.UTranslate;
import com.plantuml.graphic.StringBounder;
import com.plantuml.ugraphic.UGraphic;
import com.plantuml.command.CommandExecutionResult;
import com.plantuml.cucadiagram.Display;
import com.plantuml.ugraphic.color.HColor;

class MindMap {
	private var left:Branch = new Branch();
	private var right:Branch = new Branch();
	private final skinParam:ISkinParam;

	public function new(skinParam:ISkinParam) {
		this.skinParam = skinParam;
	}

	public function isFull(level:Int):Bool {
		return level == 0 && this.right.hasRoot();
	}

	public function addIdeaInternal(stereotype:String, backColor:HColor, level:Int, label:Display, shape:IdeaShape,
			direction:Direction):CommandExecutionResult {
		if (this.left.hasRoot() == false && this.right.hasRoot() == false)
			level = 0;

		if (level == 0) {
			this.right.initRoot(skinParam.getCurrentStyleBuilder(), backColor, label, shape, stereotype);
			this.left.initRoot(skinParam.getCurrentStyleBuilder(), backColor, label, shape, stereotype);
			return CommandExecutionResult.OK;
		}
		if (direction == Direction.LEFT)
			return this.left.add(skinParam.getCurrentStyleBuilder(), backColor, level, label, shape, stereotype);

		return this.right.add(skinParam.getCurrentStyleBuilder(), backColor, level, label, shape, stereotype);
	}

	public function drawU(ug:UGraphic):Void {
		if (this.left.hasRoot() == false && this.right.hasRoot() == false)
			return;

		this.computeFinger();

		final stringBounder:StringBounder = ug.getStringBounder();
		final y1 = this.right.getHalfThickness(stringBounder);
		final y2 = this.left.getHalfThickness(stringBounder);
		final y = Math.max(y1, y2);

		final x = this.left.getX12(stringBounder);
		this.right.drawU(ug.apply(new UTranslate(x, y)));
		this.left.drawU(ug.apply(new UTranslate(x, y)));
	}

	private function computeFinger() {
		if (this.left.hasFinger() == false && this.right.hasFinger() == false) {
			if (this.left.hasChildren())
				left.initFinger(skinParam, Direction.LEFT);

			if (this.left.hasFinger() == false || this.right.hasChildren())
				right.initFinger(skinParam, Direction.RIGHT);

			if (this.left.hasFinger() && this.right.hasFinger())
				this.left.doNotDrawFirstPhalanx();
		}
	}
}
