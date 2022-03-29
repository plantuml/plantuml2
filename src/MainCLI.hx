import com.plantuml.api.v2.*;

class MainCLI {
	static function main() {
		var args = Sys.args();
		if (args.length != 2) {
			Sys.println("usage: <PlantUML> foo.puml foo.svg");
			return;
		}
		var content:String = sys.io.File.getContent(args[0]);

		final plantu = new Plantuml();

		plantu.addLines(content);

		sys.io.File.saveContent(args[1], plantu.getSvg());
	}
}
