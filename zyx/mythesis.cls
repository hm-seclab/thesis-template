\providecommand{\mylanguage}{en}
\providecommand{\mywip}{false}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{./zyx/mythesis}[2016/12/31 My Thesis Template]

%% Pass page layout to the underlying layout class
\DeclareOption{oneside}{
  \PassOptionsToClass{\CurrentOption}{scrbook}
}
\DeclareOption{twoside}{
  \PassOptionsToClass{\CurrentOption}{scrbook}
}

\DeclareOption{de}{
  \renewcommand{\mylanguage}{de}
}

\DeclareOption{wip}{
  \renewcommand{\mywip}{true}
}

%% Fallback
\DeclareOption*{
  \ClassWarning{mythesis}{Unknown option '\CurrentOption'}
}

% Process given options
\ProcessOptions\relax

% Load base class
\LoadClass[fontsize=11pt,a4paper,listof=totoc,bibliography=totoc]{scrbook}
\setkomafont{disposition}{\normalfont\bfseries} % use serif font for headings
\linespread{1.05} % adjust line spread for mathpazo font

% Fix figure numbering
% https://tex.stackexchange.com/questions/35953/running-figure-numbering
\KOMAoptions{numbers=noendperiod}

% Remove spacing before chapter title
\renewcommand{\chapterheadstartvskip}{}

% Load additional packages and commands.
\RequirePackage[headsepline,footsepline,plainfootsepline]{scrlayer-scrpage}

% Load all user config variables
\usepackage{./myconfig}

% Read information from the git directory
\usepackage[\myGitRoot]{./zyx/gitinfo}

% scr compatibility with KOMA script
\usepackage[listings=false]{scrhack}
\usepackage{./zyx/mypackages}

%% Adding the git shorttag print on every page in work in progress mode
\ifthenelse{\boolean{\mywip}}{
\ifoot[\normalfont\texttt{\color{gray}{\gitshort}}]{\normalfont\texttt{\color{gray}{\gitshort}}}
}{}


% Store config values into title and author of the document
\title{\myTitle}
\author{\myAuthor}
\hypersetup{pdfsubject={\myThesisType}}

% Generate glossaries
\makeglossaries

\endinput
