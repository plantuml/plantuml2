import a00.*;
import com.plantuml.command.regex.*;
import com.plantuml.mindmap.*;
import com.plantuml.regex.*;
import com.plantuml.svg.*;
import utest.Runner;
import utest.ui.Report;

class MainTestSingle {
	static function main() {
		trace("hello single");
		// the long way
		var runner = new Runner();
		runner.addCase(new A03Test());

		Report.create(runner);
		runner.run();
	}
}
