\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}
\LoadClassWithOptions{report}

\directlua{pdf.setminorversion(7)}
\RequirePackage[a-3u, allxmp, pdf17]{pdfx}
\pdfminorversion=7

\RequirePackage[backend = biber, style = alphabetic, sorting = nyt, sortcites = true, maxnames = 9]{biblatex}
\RequirePackage[font = small, labelfont = bf, textfont = it, singlelinecheck = false]{caption}
\RequirePackage[inner = 2.5cm, outer = 2.5cm, top = 2.5cm, bottom = 2.5cm]{geometry}
\RequirePackage[leftmargin = 12pt, rightmargin = 12pt, font = itshape]{quoting}
\RequirePackage[locale = PL]{siunitx}

\RequirePackage[autostyle]{csquotes}
\RequirePackage[chapter]{tocbibind}
\RequirePackage[section]{placeins}
\RequirePackage[polish]{babel}

\RequirePackage{unicode-math}
\RequirePackage{indentfirst}
\RequirePackage{longtable}
\RequirePackage{emptypage}
\RequirePackage{floatrow}
\RequirePackage{interval}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{fontspec}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{totcount}
\RequirePackage{multirow}
\RequirePackage{enumitem}
\RequirePackage{textcomp}
\RequirePackage{lmodern}
\RequirePackage{tocloft}
\RequirePackage{parskip}
\RequirePackage{gensymb}
\RequirePackage{comment}
\RequirePackage{xpatch}
\RequirePackage{xurl}

\DeclareSIUnit[quantity-product=-]\bitOwych{bitowych}
\DeclareSIUnit[quantity-product=-]\bitOwego{bitowego}
\DeclareSIUnit[quantity-product=-]\bitOwaa{bitową}
\DeclareSIUnit[quantity-product=-]\bitOwa{bitowa}
\DeclareSIUnit[quantity-product=-]\bitOwe{bitowe}
\DeclareSIUnit[quantity-product=-]\bitOwy{bitowy}
\DeclareSIUnit[quantity-product=-]\bitOw{bitów}
\DeclareSIUnit[quantity-product=-]\bitY{bity}
\DeclareSIUnit[quantity-product=-]\bit{bit}

\DeclareSIUnit[quantity-product=-]\numTej{tej}
\DeclareSIUnit[quantity-product=]\percent{\char"0025}
\DeclareSIUnit\degreeCelsius{\char"2103}

\DefineBibliographyStrings{polish}{
	urlseen = {dostęp},
	in      = {}
}

\babelprovide[transforms = oneletter.nobreak]{polish}
\babelprovide[justification = unhyphenated]{polish}

\hypersetup{hidelinks, breaklinks = true}

\floatsetup[table]{style = plain, position = top}
\floatsetup[figure]{style = plain, position = bottom}

\titleformat{name = \chapter, numberless}[block]{\normalfont\bfseries\huge}{}{0pt}{}
\titleformat{name = \chapter}[block]{\normalfont\bfseries\huge}{}{0pt}{\thechapter.~}
\titleformat{name = \section}[block]{\normalfont\bfseries\large}{}{0pt}{\thesection.~}

\xpatchcmd{\interval}{interval,}{interval,scaled,}{}{}

\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}

\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftsecaftersnum}{.}
\renewcommand{\arraystretch}{1.30}

\renewcommand{\floatpagefraction}{0.85}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.35}
\renewcommand{\textfraction}{0.25}

\renewcommand{\bibsetup}{\flushbottom}

\newcommand{\hugelinespacing}{\renewcommand{\baselinestretch}{1.60} \normalsize}

\newcommand{\normallinespacing}{\renewcommand{\baselinestretch}{1.30} \normalsize}
\newcommand{\mediumlinespacing}{\renewcommand{\baselinestretch}{1.00} \normalsize}
\newcommand{\narrowlinespacing}{\renewcommand{\baselinestretch}{0.70} \normalsize}

\newcommand{\makecaption}[2]{\caption{\label{#1}#2}}
\newcommand{\emb}[1]{\left(#1\right)}

\setlength{\parskip}{12pt plus 5pt minus 2pt}
\setlength{\floatsep}{16pt plus 3pt minus 3pt}
\setlength{\intextsep}{16pt plus 3pt minus 3pt}
\setlength{\itemsep}{6pt plus 2pt minus 1pt}
\setlength{\bibitemsep}{5pt plus 1pt minus 1pt}
\setlength{\textfloatsep}{16pt plus 3pt minus 3pt}
\setlength{\abovecaptionskip}{10pt plus 2pt minus 1pt}
\setlength{\belowcaptionskip}{0pt plus 2pt minus 0pt}

\setlength{\parindent}{32pt}
\setlength{\headheight}{16pt}
\setlength{\tabcolsep}{6pt}
\setlength{\itemsep}{6pt}
\setlength{\jot}{6pt}

\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\counterwithin{equation}{chapter}

\setlist{leftmargin = \parindent}
\setenumerate{noitemsep}
\setitemize{noitemsep}

\fancyhead{}
\fancyhead[EL]{\nouppercase{\small\leftmark}}
\fancyhead[OR]{\nouppercase{\small\@title}}

\def\maketitle
{
	\begin{titlepage}
		\includegraphics[height = 3.5cm]{obrazki/polsl_logo}
		\vskip 32pt
		{\Large Wydział Elektryczny \\ Katedra Metrologii, Elektroniki i Automatyki}
		\vskip 96pt
		{\Huge \bf Rozprawa Doktorska}
		\vskip 32pt
		{\Large \@title}
		\vskip 128pt
		\normallinespacing
		\begin{tabular}[c]{r @{~:~} l}
		\textbf{Autor}        & \fullauthor   \\
		\textbf{Promotor}     & \fullpromoter \\
		\end{tabular}
		\vskip 48pt
		{\large \fulldate}
		\vfill
	\end{titlepage}
}

\def\titlepage
{
	\newpage
	\hugelinespacing
	\pagestyle{empty}
	\pagenumbering{alph}
	\centering
	\normalsize
	\vbox to \vsize
	\bgroup\bgroup
}

\def\endtitlepage
{
	\par
	\kern 0pt
	\egroup
	\vss
	\egroup
	\cleardoublepage
	\normallinespacing
}

\def\preface
{
	\pagenumbering{roman}
	\pagestyle{plain}
	\hugelinespacing
	\tableofcontents
	\normallinespacing
}

\def\appendix
{
	\cleardoublepage
	\mediumlinespacing
	\pagestyle{plain}
	\printbibliography[heading = bibintoc]
}

\def\body
{
	\cleardoublepage
	\normallinespacing
	\pagenumbering{arabic}
	\pagestyle{fancy}
}

\sisetup
{
	retain-explicit-plus = true,
	reset-text-family    = false,
	reset-text-series    = false,
	reset-text-shape     = false,
	space-before-unit    = true,
	tight-spacing        = true,
	use-xspace           = true,
	per-mode             = fraction,
	inline-per-mode      = symbol,
	list-exponents       = combine-bracket,
	list-units           = single,
	range-exponents      = combine-bracket,
	range-units          = bracket,
	range-phrase         = \,;\,,
	quantity-product     = ~,
	exponent-product     = \cdot,
	mode                 = match
}

\intervalconfig
{
	left closed fence    = [,
	right closed fence   = ],
	left open fence      = (,
	right open fence     = ),
	separator symbol     = ;
}

% to allow break long gathers
\allowdisplaybreaks[1]
% --------------------

% to avoid widows and clubs
\widowpenalty=10000
\clubpenalty=10000
% --------------------

% to count chapters
\regtotcounter{chapter}
% --------------------

% for wider matrices
\setcounter{MaxMatrixCols}{15}
% --------------------

% for delimiters size
\delimitershortfall=3pt
\delimiterfactor=900
% --------------------

\flushbottom
