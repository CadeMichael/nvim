-- Keymappings

-- Snippets
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("tex", {
  s("tex!", fmt([[
\documentclass[a4paper]{article}
\usepackage{amsmath} % Required for some math elements
\usepackage{amssymb} % Required for some math symbols
\usepackage{mathpartir} % Required for logical symbols
\usepackage{upgreek} % Required for Greek letters
\usepackage{listings} % Required for including code

\title{<>}
\author{<>}
\date{<>}

\pdfsuppresswarningpagegroup=1

\begin{document}

\maketitle

\section{Introduction}

\end{document}
  ]], {
    i(1),
    i(2),
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("S*", fmt([[
\section*{<>}
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("S", fmt([[
\section{<>}
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("b", fmt([[
\textbf{<>}
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("$", fmt([[
${}$
  ]], {
    i(0),
  })),
  s("$$", fmt([[
$$
{}
$$
  ]], {
    i(0),
  })),
  s("BA*", fmt([[
\begin{align*}
<>
\end{align*}
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("it", fmt([[
\item {}
  ]], {
    i(0),
  })),
  s("BI", fmt([[
\begin{itemize}
<>
\end{itemize}
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("lst", fmt([[
\begin{{lstlisting}}
{}
\end{{lstlisting}}
  ]], {
    i(0),
  })),
  s("bmat", fmt([[
\begin{{bmatrix}}
<>
\end{{bmatrix}}
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("set", fmt([[
\{<>\}<>
  ]], {
    i(1),
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("in", fmt([[
\in {}
  ]], {
    i(0),
  })),
  s("ni", fmt([[
\notin {}
  ]], {
    i(0),
  })),
  s("->", fmt([[
\to {}
  ]], {
    i(0),
  })),
  s("!>", fmt([[
\mapsto {}
  ]], {
    i(0),
  })),
  s("===", fmt([[
\equiv {}
  ]], {
    i(0),
  })),
  s("|=", fmt([[
\models {}
  ]], {
    i(0),
  })),
  s("ex", fmt([[
\exists {}
  ]], {
    i(0),
  })),
  s("fa", fmt([[
\forall {}
  ]], {
    i(0),
  })),
  s("l", fmt([[
\lambda {}
  ]], {
    i(0),
  })),
  s("|-", fmt([[
\vdash {}
  ]], {
    i(0),
  })),
  s("^", fmt([[
^{<>}<>
  ]], {
    i(1),
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("__", fmt([[
_{<>}<>
  ]], {
    i(1),
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("!==", fmt([[
\neg <>
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("!=", fmt([[
\ne <>
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  -- Math letters
  s("p.", fmt([[
\upvarrho <>
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("t.", fmt([[
\uptau <>
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("g.", fmt([[
\mathcal{G} <>
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("E.", fmt([[
\mathcal{E} <>
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("V.", fmt([[
\mathcal{V} <>
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
  s("G.", fmt([[
\Gamma<>
  ]], {
    i(0),
  }, {
    delimiters = "<>"
  })),
})
