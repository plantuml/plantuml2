import tcom.*;
import com.plantuml.svg.*;
import utest.Runner;
import utest.ui.Report;

class MainTest {
	static function main() {
		var runner = new Runner();
		runner.addCases("a00");
		runner.addCases("tcom");
		// runner.addCase(new CharSizeTest());

		runner.onComplete.add(_ -> {
			AbstractTest.saveContentStrings();
		});

		Report.create(runner);
		runner.run();
	}
}
