package com.plantuml.mindmap;

import com.plantuml.style.Style;
import com.plantuml.awt.geom.Dimension2D;
import com.plantuml.awt.geom.Point2D;
import com.plantuml.cucadiagram.Display;
import com.plantuml.graphic.StringBounder;
import com.plantuml.graphic.TextBlock;
import com.plantuml.graphic.UDrawable;
import com.plantuml.style.StyleBuilder;
import com.plantuml.ugraphic.TextBlockUtils;
import com.plantuml.ugraphic.UGraphic;
import com.plantuml.ugraphic.UPath;
import com.plantuml.ugraphic.UTranslate;
import com.plantuml.ugraphic.color.HColor;

class FingerImpl implements Finger implements UDrawable {
	private final label:Display;
	private final backColor:HColor;
	private final stereotype:String;
	private final skinParam:ISkinParam;
	private final styleBuilder:StyleBuilder;
	private final shape:IdeaShape;
	private final direction:Direction;
	private final level:Int;
	private var drawPhalanx:Bool = true;
	private var marginLeft = 10.0;
	private var marginRight = 10.0;
	private var marginTop = 10.0;
	private var marginBottom = 10.0;

	private final nail:Array<FingerImpl> = [];
	private var tetris:Tetris;

	public function drawU(ug:UGraphic) {
		final stringBounder:StringBounder = ug.getStringBounder();
		final phalanx:TextBlock = getPhalanx();
		final dimPhalanx:Dimension2D = phalanx.calculateDimension(stringBounder);
		if (drawPhalanx) {
			final posY = -getPhalanxThickness(stringBounder) / 2;
			final posX = direction == Direction.RIGHT ? 0 : -dimPhalanx.getWidth();
			phalanx.drawU(ug.apply(new UTranslate(posX, posY)));
		}
		final p1:Point2D = new Point2D(direction == Direction.RIGHT ? dimPhalanx.getWidth() : -dimPhalanx.getWidth(), 0);

		for (i in 0...nail.length) {
			final child = nail[i];
			final stp:SymetricalTeePositioned = getTetris(stringBounder).getElements()[i];
			final x = direction == Direction.RIGHT ? dimPhalanx.getWidth() + getX12() : -dimPhalanx.getWidth() - getX12();
			final p2:Point2D = new Point2D(x, stp.getY());
			child.drawU(ug.apply(p2.asTranslate()));
			// trace("IL MANQUE UNE LIGNE");
			// 	drawLine(ug.apply(getLinkColor()).apply(getUStroke()), p1, p2);
			drawLine(ug, p1, p2);
		}
	}

	public function getPhalanxThickness(stringBounder:StringBounder):Float {
		return getPhalanx().calculateDimension(stringBounder).getHeight();
	}

	public function getNailThickness(stringBounder:StringBounder):Float {
		return getTetris(stringBounder).getHeight();
	}

	public function getFullThickness(stringBounder:StringBounder):Float {
		final thickness1 = getPhalanxThickness(stringBounder);
		final thickness2 = getNailThickness(stringBounder);
		return Math.max(thickness1, thickness2);
	}

	public function getPhalanxElongation(stringBounder:StringBounder):Float {
		return getPhalanx().calculateDimension(stringBounder).getWidth();
	}

	public function getNailElongation(stringBounder:StringBounder):Float {
		return getTetris(stringBounder).getWidth();
	}

	public function getFullElongation(stringBounder:StringBounder):Float {
		return getPhalanxElongation(stringBounder) + getNailElongation(stringBounder);
	}

	public function doNotDrawFirstPhalanx() {}

	public function new(styleBuilder:StyleBuilder, backColor:HColor, label:Display, skinParam:ISkinParam, shape:IdeaShape, direction:Direction, level:Int,
			stereotype:String) {
		this.backColor = backColor;
		this.stereotype = stereotype;
		this.level = level;
		this.label = label;
		this.skinParam = skinParam;
		this.styleBuilder = styleBuilder;
		this.shape = shape;
		this.direction = direction;
	}

	public function getX12():Float {
		return getX1() + getX2();
	}

	public static function build(idea:Idea, skinParam:ISkinParam, direction:Direction):FingerImpl {
		final result = new FingerImpl(idea.getStyleBuilder(), idea.getBackColor(), idea.getLabel(), skinParam, idea.getShape(), direction, idea.getLevel(),
			idea.getStereotype());
		for (child in idea.getChildren())
			result.addInNail(build(child, skinParam, direction));
		return result;
	}

	public function addInNail(child:FingerImpl) {
		nail.push(child);
	}

	function getPhalanx():TextBlock {
		if (drawPhalanx == false)
			return TextBlockUtils.empty(0, 0);

		if (shape == IdeaShape.BOX) {
			final style = new Style();
			final box:TextBlock = FtileBoxOld.createMindMap(style, label);
			return TextBlockUtils.withMargin(box, 0, 0, marginTop, marginBottom);
		}
		throw new haxe.exceptions.NotImplementedException();
	}

	function getTetris(stringBounder:StringBounder):Tetris {
		if (tetris == null) {
			tetris = new Tetris(label.get(0));
			for (child in nail)
				tetris.add(child.asSymetricalTee(stringBounder));

			tetris.balance();
		}
		return tetris;
	}

	function asSymetricalTee(stringBounder:StringBounder):SymetricalTee {
		final thickness1 = getPhalanxThickness(stringBounder);
		final elongation1 = getPhalanxElongation(stringBounder);
		if (nail.length == 0)
			return new SymetricalTee(thickness1, elongation1, 0, 0);

		final thickness2 = getNailThickness(stringBounder);
		final elongation2 = getNailElongation(stringBounder);
		return new SymetricalTee(thickness1, elongation1 + getX1(), thickness2, getX2() + elongation2);
	}

	private function getX1() {
		return marginLeft;
	}

	private function getX2() {
		return marginRight + 30;
	}

	function drawLine(ug:UGraphic, p1:Point2D, p2:Point2D) {
		final path = new UPath();
		final delta1 = direction == Direction.RIGHT ? 10 : -10;
		final delta2 = direction == Direction.RIGHT ? 25 : -25;
		path.moveToPoint(p1);
		path.lineTo(p1.getX() + delta1, p1.getY());
		path.cubicTo(p1.getX() + delta2, p1.getY(), p2.getX() - delta2, p2.getY(), p2.getX() - delta1, p2.getY());
		path.lineToPoint(p2);
		ug.draw(path);
	}
}
