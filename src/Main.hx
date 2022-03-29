import utest.*;
import utest.Runner;
import utest.ui.Report;
import com.plantuml.command.regex.*;
import com.plantuml.api.v1.*;

class Main {
	static function main() {
		// the long way
		var runner = new Runner();
		runner.addCase(new MinMapDiagramTest());
		runner.addCase(new SvgGraphicsTest());
		runner.addCase(new TestCase1());
		runner.addCase(new CommandMindMapDirectionTest());
		runner.addCase(new CommandMindMapOrgmodeTest());
		runner.addCase(new StripeFrontierTest());
		runner.addCase(new StripeTest());

		Report.create(runner);
		runner.run();
	}


}
