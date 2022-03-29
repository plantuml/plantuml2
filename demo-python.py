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
