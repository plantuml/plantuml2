package com.plantuml.mindmap;

enum IdeaShape {
	BOX;
	NONE;
}

class IdeaShapeUtils {
	public static function fromDesc(s:String):IdeaShape {
		if ("_" == s)
			return NONE;

		return BOX;
	}
}
