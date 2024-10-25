\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{slides}
\LoadClassWithOptions{beamer}

\directlua{pdf.setminorversion(7)}

\RequirePackage[backend = biber, style = numeric, sortcites = true, maxnames = 9]{biblatex}
\RequirePackage[locale = PL]{siunitx}
\RequirePackage[autostyle]{csquotes}
\RequirePackage[polish]{babel}

\RequirePackage{unicode-math}
\RequirePackage{interval}
\RequirePackage{setspace}
\RequirePackage{ragged2e}
\RequirePackage{textcomp}
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{lmodern}
\RequirePackage{gensymb}
\RequirePackage{comment}
\RequirePackage{xpatch}
\RequirePackage{calc}

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

\babelprovide[transforms = oneletter.nobreak]{polish}
\babelprovide[justification = unhyphenated]{polish}
\hypersetup{hidelinks}

\usetheme{boxes}
\usecolortheme{seahorse}
\useinnertheme{rectangles}
\usefonttheme{professionalfonts}

\xpatchcmd{\interval}{interval,}{interval,scaled,}{}{}

\newcommand\itemref[1]{{\renewcommand{\insertenumlabel}{\ref{#1}}\usebeamertemplate{enumerate item}}}
\newcommand{\lastpage}{\usebeamertemplate{last page}}
\newcommand{\makecaption}[2]{\caption{\label{#1}#2}}
\newcommand{\emb}[1]{\left(#1\right)}
\newcommand{\bsigma}{\char"1D6D4}
\newcommand{\newsection}[2]{\section{#2}}

\renewcommand{\arraystretch}{1.30}

\setlength{\parskip}{3pt}
\setlength{\floatsep}{6pt}
\setlength{\intextsep}{6pt}
\setlength{\textfloatsep}{6pt}
\setlength{\abovecaptionskip}{0pt}
\setlength{\belowcaptionskip}{0pt}

\setlength{\headheight}{6pt}
\setlength{\tabcolsep}{6pt}
\setlength{\jot}{6pt}

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
	inline-per-mode      = fraction,
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

\setbeamertemplate{title page}
{
	\vbox{}
	\vfill
	\begingroup
		\centering
		\usebeamertemplate{title}
		\vskip 1em \par
		\usebeamertemplate{author}
		\usebeamertemplate{institute}
		\usebeamertemplate{date}
		\vskip 1em \par
		\usebeamertemplate{titlegraphic}
	\endgroup
	\vfill
}

\setbeamertemplate{last page}
{
	\vbox{}
	\vfill
	\begingroup
		\centering
		\begin{beamercolorbox}[sep = 8pt, center]{title}
			\usebeamerfont{title}Dziękuję za uwagę
		\end{beamercolorbox}
		\vskip 3em \par
		\usebeamertemplate{author}
		\usebeamertemplate{institute}
		\vskip 1em \par
		\usebeamertemplate{titlegraphic}
	\endgroup
	\vfill
}

\setbeamerfont{subsection in toc}{size = \scriptsize}

\beamertemplatenavigationsymbolsempty
\setbeamertemplate{caption}[numbered]
\setbeamertemplate{footline}[frame number]
\setbeamertemplate{frametitle continuation}{}
