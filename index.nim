import nimib, nimiSlides

template slideIframe*(url: string) =
  nbRawHtml: "<section data-background-iframe=\"" & url & "\" data-background-interactive></section>"

template slideIframeFromNblog*(filename: string) =
  slideIframe("https://nimib-land.github.io/nblog/drafts/" & filename & ".html")


template slideTitle =
    slide:
        nbText: "# [**NimibLand**]()\n## Literate Programming and Explorable Explanations"
        speakerNote: """
- I have a talk proposal with more or less of this title which I am waiting to see if it will be accepted to be presented at FOSDEM
- This presentation is also accountability for the commitment I would like to have to focus on these stuff for the rest of the batch
"""

template slideLiterate =
    slide:
        nbText: """### [Literate Programming](https://en.wikipedia.org/wiki/Literate_programming)

Programming paradigm by Donald Knuth (1984)

<small>
a computer program is given as an explanation of how it works
in a natural language, such as English,
interspersed (embedded) with snippets of macros
and traditional source code,
from which compilable source code can be generated.
</small>

Inspired:
- Jupyter NoteBook
- Quarto (RMarkdown)
- Nbdev
- ...
- [Nimib]()
"""
        speakerNote: """
- quote is from wikipedia. TODO: check original source

1. Weaving: Generating a comprehensive document about the program and its maintenance.
2. Tangling: Generating machine executable code

- Jupyter is more Interactive Computing
- N and B in Nimib come from NoteBook
- Nbdev closest to original literate programming
- Observable most important and not quoted
"""

template slideExplorable =
    slide:
        nbText: """### [Explorable Explanations]()

Essay by Bret Victor (2011)

<small>
"Explorable Explanations is my umbrella project for ideas
that enable and encourage truly active reading.
The goal is to change people's relationship with text.
People currently think of text as information to be consumed.
I want text to be used as an environment to think in."
</small>

See more at [explorabl.es](https://explorabl.es/)

**Goal**: make in [NimibLand]() better tools for explorable explanations.
"""
        speakerNote: """
- NimibLand concretely is a github organization where me and Hugo are
moving Nimib related projects
- The funny part is we decided on the name NimibLand
before knowing about DynamicLand and MathLand
(which I discovered about them this week)
"""

template slideNimibAsLiterate =
    slide:
        slide:
            nbText: "### Nimib as 'Literate Programming'"
            nbFile("hello.nim"): """
import nimib

nbInit

nbText: "A sample program with _Nimib_"

nbCode:
    echo "hello RC!"

nbSave
"""
            nbText: "`nim r hello`"
            speakerNote: """
"""
        slideIframe("hello.html")

template slideNimibAsExplorable =
    slide:
        slide:
            nbText: "### [🌱✨ Explorable Example with Nimib]()"
        slideIframeFromNblog("plant_app")

template slideFirstTask =
    slide:
        nbText: "### **FIRST TASK**\n[Groviglio](): wrapper for [Tangle.js]() for Nimib"
        speakerNote: """
- Tangle.js is a Javascript library by your very own Bret Victor for explorable explanations
- Discovered this week, does not seem very much known/used but looks like a good starting point
"""

template aChristmasTwist =
    slide:
        nbText: """
_something else happened during Christmas period..._
"""

template slideNimipPy =
    slide:
        slide:
            nbText: """### [Nimib.py]()
"""
            nbFile("hi.py"): """
import nimib as nb

nb.init()

nb.text("Welcome to `nimib.py`!")

message = "hello"

with nb.code():
    print(message)

nb.save()
"""
            nbText: "`python hi.py`"
        speakerNote: """
Thanks to advent of code
"""
        slideIframe("../../nimib.py/hi.html")

template slideEnterPyscript =
    slide:
        nbText: """### [Pyscript]()
- Python in the browser
- PyConUS 2022 (Peter Wang, Anaconda): "Python for the 99%"
- Started using Pyodide (Python in WASM): heavy asset (MBs), slow loading times (seconds)
- _recently_: added a **Micropython**🤯 backend: <200kb, <200ms
"""
        speakerNote: """
- Born in Anaconda but run as a community project
- Creation of Fabio Pliger
"""

template slideNimipPyscript =
    slide:
        slide:
            nbFile("bunny_meets_whaley.py"): """
import nimib as nb

nb.init(pyscript=True)

nb.text("## Bunny 🐰 meets Whaley 🐳!")
nb.text("Hello world example for pyscript with nimib.py.")

nb.html("<button id=\"click-me\">Click me! 🐰🐳</button><br/>")
nb.html("<div id=\"emoji-container\"></div>")

nb.text("This code adds functionality to the button (try block is a workaround):")
with nb.code(pyscript=True):
    try:
        from js import document

        def handler(e):
            output = document.createElement("span")
            output.innerHTML = "🐳"
            container = document.querySelector("div#emoji-container")
            container.appendChild(output)

        button = document.querySelector("button#click-me")
        button.addEventListener("click", handler)
    except ImportError:
        print("running pyscript block not in js")

nb.save()
"""
            nbText: "**TASK**: make it idiomatic"
            speakerNote """
- context manager cannot avoid yielding
- will change to decorators
"""
        slideIframe("../../nimib.py/bunny_meets_whaley.html")

template slideAboutNim =
    slide:
        nbText: """### THANKS FOR LISTENING 🙏
"""
        speakerNote: """
"""

when isMainModule:
    nbInit(theme = revealTheme)
    setSlidesTheme(Simple)

    when false:
        discard
    slideTitle
    slideLiterate
    slideNimibAsLiterate
    slideExplorable
    slideNimibAsExplorable
    slideFirstTask
    aChristmasTwist
    slideNimipPy
    slideEnterPyscript
    slideNimipPyscript
    slideAboutNim
    nbSave