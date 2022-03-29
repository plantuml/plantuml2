package com.plantuml.ugraphic;

enum USegmentType {
	SEG_MOVETO;
	SEG_LINETO;
	SEG_QUADTO;
	SEG_CUBICTO;
	SEG_CLOSE;
	SEG_ARCTO;
}

class USegmentType_ {
	public static function getNbPoints(me:USegmentType):Int {
		switch (me) {
			case SEG_MOVETO:
				return 1;
			case SEG_LINETO:
				return 1;
			case SEG_CUBICTO:
				return 3;
			case SEG_CLOSE:
				return 0;
			default:
				throw new haxe.exceptions.NotImplementedException();
		}
		throw new haxe.exceptions.NotImplementedException();
	}
}
