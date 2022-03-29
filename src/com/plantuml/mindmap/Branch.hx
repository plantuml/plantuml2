package com.plantuml.mindmap;

import com.plantuml.graphic.StringBounder;
import com.plantuml.ugraphic.UGraphic;
import com.plantuml.graphic.UDrawable;
import com.plantuml.command.CommandExecutionResult;
import com.plantuml.cucadiagram.Display;
import com.plantuml.ugraphic.color.HColor;
import com.plantuml.style.StyleBuilder;

class Branch implements UDrawable {
	private var root:Idea;
	private var last:Idea;
	private var finger:Finger;

	public function new() {}

	public function hasRoot():Bool {
		return root != null;
	}

	public function initRoot(styleBuilder:StyleBuilder, backColor:HColor, label:Display, shape:IdeaShape, stereotype:String) {
		root = Idea.createIdeaSimple(styleBuilder, backColor, label, shape, stereotype);
		last = root;
	}

	public function add(styleBuilder:StyleBuilder, backColor:HColor, level:Int, label:Display, shape:IdeaShape, stereotype:String):CommandExecutionResult {
		if (last == null)
			return CommandExecutionResult.ERROR("Check your indentation ?");

		if (level == last.getLevel() + 1) {
			final newIdea:Idea = last.createIdea(styleBuilder, backColor, level, label, shape, stereotype);
			last = newIdea;
			return CommandExecutionResult.OK;
		}
		if (level <= last.getLevel()) {
			final diff = last.getLevel() - level + 1;
			final newIdea:Idea = getParentOfLast(diff).createIdea(styleBuilder, backColor, level, label, shape, stereotype);
			last = newIdea;
			return CommandExecutionResult.OK;
		}
		return CommandExecutionResult.ERROR("error42L");
	}

	function getParentOfLast(nb:Int) {
		var result:Idea = last;
		for (i in 0...nb)
			result = result.getParent();

		return result;
	}

	public function hasFinger():Bool {
		return finger != null;
	}

	public function hasChildren():Bool {
		return root.hasChildren();
	}

	public function initFinger(skinParam:ISkinParam, direction:Direction) {
		finger = FingerImpl.build(root, skinParam, direction);
	}

	public function doNotDrawFirstPhalanx() {
		throw new haxe.exceptions.NotImplementedException();
	}

	public function drawU(ug:UGraphic) {
		if (finger != null)
			finger.drawU(ug);
	}

	public function getHalfThickness(stringBounder:StringBounder):Float {
		if (finger == null)
			return 0;
		return finger.getFullThickness(stringBounder) / 2;
	}

	public function getFullElongation(stringBounder:StringBounder):Float {
		if (finger == null)
			return 0;
		return finger.getFullElongation(stringBounder);
	}

	public function getX12(stringBounder:StringBounder):Float {
		if (finger == null)
			return 0;
		return finger.getFullElongation(stringBounder) + (cast(finger, FingerImpl)).getX12();
	}
}
