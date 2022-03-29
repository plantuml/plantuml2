import haxe.ds.BalancedTree;
import hx.strings.StringBuilder;
import com.plantuml.command.BlocLines;
import com.plantuml.api.v2.Plantuml;

using hx.strings.Strings;
using com.plantuml.utils.StartUtils;

import utest.Test;
import utest.utils.Print;
import utest.Assert;

class AbstractTest extends Test {
	private static var allPaths:Map<String, String> = [];
	private static var onlyErrorPaths:Map<String, String> = [];

	public function new() {
		super();
	}

	function getPath():String {
		final name = Type.getClassName(Type.getClass(this));
		final path = "test/" + name.replaceAll(".", "/") + ".hx";
		return path;
	}

	static function getTarget():String {
		#if js
		return "js";
		#elseif java
		return "java";
		#elseif python
		return "py";
		#elseif hashlink
		return "hashlink";
		#elseif hl
		return "hl";
		#elseif necko
		return "necko";
		#elseif interp
		return "interp";
		#end
		return "other";
	}

	function exportSvgAndGetSha1(diag2:String):String {
		var bl = new BlocLines();
		bl.addLines(diag2);
		bl = bl.findStartSomething();

		final p = new Plantuml();
		p.addLinesArray(bl.getLines());

		final svg = p.getSvg();
		Assert.isTrue(svg.length > 0);

		final target = getTarget();
		final path = getPath().replaceFirst(".hx", '-$target.svg');
		final targetHtml = 'all-$target.html';
		final sha1 = svg.orderMe().sha1();

		allPaths[sha1] = path;

		#if !js
		sys.io.File.saveContent(path, svg);
		// trace(allPaths);
		#end
		return sha1;
	}

	function errorInSha1(sha1:String) {
		trace('Error in $sha1');
		final path = allPaths[sha1];
		if (path != null)
			onlyErrorPaths[sha1] = path;
		trace(onlyErrorPaths);
	}

	#if !js
	public static function exportHtml(file, myMap:Map<String, String>) {
		final content = [];
		content.push("<html>");
		content.push("<style>");
		content.push("body {");
		content.push("background-color: #f8f8f8;");
		content.push("}");
		content.push("</style>");
		content.push("<body>");
		for (p in myMap) {
			content.push("<a href='" + p + "'>");
			content.push(p);
			content.push("</a>");
			content.push("<p>");
			content.push("<a href='" + p + "'>");
			content.push("<object data='" + p + "' type='image/svg+xml'>");
			content.push("</object>");
			// content.push("<img src='" + p + "'>");
			content.push("</a>");
			content.push("<hr>");
		}
		content.push("</body>");
		content.push("</html>");

		final sb:StringBuilder = new StringBuilder();
		for (s in content) {
			sb.add(s);
			sb.add("\n");
		}
		sys.io.File.saveContent(file, sb.toString());
	}
	#end

	public static function saveContentStrings() {
		trace("saveContentStrings");
		#if !js
		final target = getTarget();
		final all = '_all-$target.html';
		final error = '_error-$target.html';

		exportHtml(all, allPaths);
		exportHtml(error, onlyErrorPaths);
		#end
	}
} // http://www.unexpected-vortices.com/haxe/brief-tutorial.html
// http://thx-lib.org/api/thx/Set.html
