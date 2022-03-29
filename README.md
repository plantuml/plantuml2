# PlantUML 2

For the next major version, PlantUML will be developped using [Haxe language](https://haxe.org).

Moving to [Haxe](https://haxe.org/documentation/introduction/compiler-targets.html) means that we will have a native implementation of PlantUML in all following languages:
* Javascript
* Java (JVM)
* Python 3
* PHP7
* C#
* C++

This way, PlantUML could run almost everywhere.


# Current situation

PlantUML 2 is really a rewrite of the existing Java code.

[Haxe](https://haxe.org) provides everything (and more!) that we need for PlantUML (oriented-object, regular expression, nice standard library), however re-implementing all that PlantUML is currently doing will takes time (that is, at least 2 years).

This means that we are going to slow down on adding new features in current PlantUML 1. We will only focus on bug fixes.

Current version of PlantUML 2 provides only a **tiny** part of what PlantUML 1 is capable of:
* only Mindmap diagrams
* only SVG output
* no preprocessor
* no standard library

**Next step is now to add Sequence Diagram.**

# Compatibility

Globally, PlantUML 2 will be able to parse the same file than PlantUML 1.

Some features will not be re-implemented, but the most important will:
* MindMap diagram (**done**)
* Sequence diagram
* Usecase diagram
* Activity diagram
* Class diagram
* Object diagram
* Component diagram
* Deployment diagram
* State diagram
* Timing diagram
* JSON data
* YAML data
* Network diagram (nwdiag)
* Wireframe graphical interface or UI mockups (salt)
* Archimate diagram
* Specification and Description Language (SDL)
* Gantt diagram
* Work Breakdown Structure diagram (WBS)
* Entity Relationship diagram (IE/ER)

We are unsure about the following one:
* Mathematic with AsciiMath or JLaTeXMath notation
* Activity diagram legacy

Features that will be excluded:
* Ditaa

We will port to Haxe the [Smetana project](https://plantuml.comsmetana02) which means that PlantUML 2 will **not** need any Graphviz/dot executable to run. 

### Incompatible changes

As said, we will be globally be compatible with PlantUML 1 syntax. However, we take this new release as an opportunity to improve some inconsistent choices that have been made in the past.

* In class diagram, `package` do not define any namespace, which may be confusing. We have added `namespace` keywords to mitigate this. However, in Plantuml 2, `package` and `namespace` will be synonym, which may break some existing diagrams.

Let us know if you know any other inconsistencies that you would like to see resolved. :-)

## Install Haxe

You first have to install [Haxe 4](https://haxe.org).

The two following libraries are used:

```
haxelib install utest
haxelib install haxe-strings
```

If you have some HTTPS certificate issues (because of proxy for example), you can use:

```
haxelib install utest -R http://lib.haxe.org/
haxelib install haxe-strings -R http://lib.haxe.org/
```

For building, you have to launch the `haxe` command with some `.hxml` build file.

As IDE, we recommand the use of [VSCode](https://code.visualstudio.com/). 

## Unit testing

To build the unit tests, you have to launch the following command:
```
haxe unit-test.hxml 
```

Then you can run the unit tests in Java:
```
java -jar unit-test/MainTest.jar
```

Or in python3:
```
python3 unit-test.py
```

You can also open `unit-test.html` file in your favorite browser to run unitary tests in Javascript.


## Command Line Interface

A basic Command Line Interface (CLI) is included for Java and Python.

To build them, just run:

```
haxe CLI.hxml 
```

Then you can run the python CLI:

```
$ python3 plantuml-cli.py 
usage: <PlantUML> foo.puml foo.svg
```

or the Java one:
```
$ java -jar plantuml-cli/MainCLI.jar 
usage: <PlantUML> foo.puml foo.svg
```

This CLI is right now really minimalist.


## PlantUML as library

To build the PlantUML library, you must run the following command:
```
haxe lib.hxml 
```

This will build the following files:
* libplantuml.js
* libplantuml.py
* libplantuml/Libplantuml.jar


### Javascript example

You can use `libplantuml.js` this way:

```
<script type="text/javascript" src="libplantuml.js"></script>
<script type="text/javascript">
	function update() {
		var plantuml = new PlantumlV2();
		var tt = document.getElementById('tt').value;
		plantuml.addLines(tt);
		document.getElementById('result').innerHTML = plantuml.getSvg();
	}
</script>
```


### Python example

You can use `libplantuml.py` this way:

```
#!/usr/bin/python
import libplantuml

if __name__ == "__main__":
    plantuml = libplantuml.PlantumlV2()
    plantuml.addLineSingle("@startmindmap")
    plantuml.addLineSingle("* World")
    plantuml.addLineSingle("** America")
    plantuml.addLineSingle("** Europe")
    plantuml.addLineSingle("@endmindmap")
    svg = plantuml.getSvg()
    print(svg)
```


### Java example

The very same example running in Java:

```
import com.plantuml.api.v2.Plantuml;

public class Main {

	public static void main(String[] args) {
		
		final Plantuml plantuml = new Plantuml();
		plantuml.addLineSingle("@startmindmap");
		plantuml.addLineSingle("* World");
		plantuml.addLineSingle("** America");
		plantuml.addLineSingle("** Europe");
		plantuml.addLineSingle("@endmindmap");
		
		final String svg = plantuml.getSvg();
		System.out.println(svg);

	}

}
```
