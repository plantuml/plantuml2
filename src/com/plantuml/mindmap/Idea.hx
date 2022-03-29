package com.plantuml.mindmap;

import com.plantuml.cucadiagram.Display;
import com.plantuml.style.StyleBuilder;
import com.plantuml.ugraphic.color.HColor;

class Idea {
	private final label:Display;
	private final level:Int;
	private final parent:Idea;
	private final children:Array<Idea> = [];
	private final shape:IdeaShape;
	private final backColor:HColor;
	private final styleBuilder:StyleBuilder;
	private final stereotype:String;

	private function new(styleBuilder:StyleBuilder, backColor:HColor, level:Int, parent:Idea, label:Display, shape:IdeaShape, stereotype:String) {
		this.backColor = backColor;
		this.styleBuilder = styleBuilder;
		this.label = label;
		this.level = level;
		this.parent = parent;
		this.shape = shape;
		this.stereotype = stereotype;
	}

	public static function createIdeaSimple(styleBuilder:StyleBuilder, backColor:HColor, label:Display, shape:IdeaShape, stereotype:String):Idea {
		return new Idea(styleBuilder, backColor, 0, null, label, shape, stereotype);
	}

	public function getLevel():Int {
		return level;
	}

	public function createIdea(styleBuilder:StyleBuilder, backColor:HColor, newLevel:Int, newDisplay:Display, newShape:IdeaShape, stereotype:String):Idea {
		final result:Idea = new Idea(styleBuilder, backColor, newLevel, this, newDisplay, newShape, stereotype);
		this.children.push(result);
		return result;
	}

	public function getParent():Idea {
		return parent;
	}

	public function hasChildren():Bool {
		return children.length > 0;
	}

	public function getStyleBuilder():StyleBuilder {
		return styleBuilder;
	}

	public function getBackColor():HColor {
		return backColor;
	}

	public function getLabel():Display {
		return label;
	}

	public function getShape():IdeaShape {
		return shape;
	}

	public function getStereotype():String {
		return stereotype;
	}

	public function getChildren() {
		return children;
	}
}
