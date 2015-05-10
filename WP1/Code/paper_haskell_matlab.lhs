\documentclass{article}

\title{Calculating fault propagation in functional programs} 

\date{March 2013}

\author{   {Daniel R. Murta \& Jos\'e N. Oliveira} \\
           HASLab --- High Assurance Software Laboratory,\\
	    INESC TEC and University of Minho, \\ 4700 Braga, Portugal \\
           {pg23205@@alunos.uminho.pt \& jno@@di.uminho.pt}
}

\usepackage{url}
\usepackage{a4}
%------ lhs2tex ---------------------------
%include polycode.fmt
%format inN = "\inN "
%format inL = "\inN "
%format and = "\land "
%format N0 = "\N_0"
%format (const a) = "\underline{" a "}"
%format (either a b) = "[" a "," b "]"
%format (mean f) = "\mean{" f "}"
%format (meither a b) = "[" a "|" b "]"
%format pmeither (a) (b) = "[" a "|" b "]"
%format (msplit a b) = "\msplit{" a "}{" b "}"
%format pmsplit (a) (b) = "\msplit{" a "}{" b "}"
%format kr a b = "{" a "}\kr{" b "}"
%format (split (x) (y)) = "\conj{" x "}{" y "}"
%format (sub x y) = "{" x "}_{" y "}"
%format -|- = "+"
%format .! = " \kcomp "
%format <>  = " \not= "
%format ><  = " \times "
%format cons = "{\mathsf{cons}}"
%format nil = "{\mathsf{nil}}"
%format QED = "\Box"
%format pSum (v) (p) (q) = "\rcb\sum{" v "}{" p "}{" q "}"
%format Sum v p q = "\rcb\sum{" v "}{" p "}{" q "}"
%format Sum_ v q = "\rcb\sum{" v "}{}{" q "}"
%format Sum_ v (q) = "\rcb\sum{" v "}{}{" q "}"
%format bang = "{!}"
%format cata x = "\mathopen{(\!|}" x "\mathclose{|\!)}"
%format conv r = "\conv{" r "}"
%format crflx p = " \crflx{" p "}"
%format delta = " \delta "
%format exp x y = "{" x "}^{" y "}"
%format f1 = "f_1"
%format f2 = "f_2"
%format fi = "f_i"
%format for = "\mathsf{for}"
%format fold = "\mathsf{fold}"
%format foldr = "\mathsf{foldr}"
%format F = "\mathsf{F}"
%format foldr = "\mathsf{foldr}"
%format map k = "\map{" k "}"
%format g1 = "g_1"
%format g2 = "g_2"
%format gi = "g_i"
%format kron a b = a "\otimes " b
%format mblock m n o p = "\mblock{" m "}{" n "}{" o "}{" p "}"
%format mcond p q r = " \mcond{" p "}{" q "}{" r "}"
%format power n m = "{" n "}^{" m "}"
%format oplus m n = m "\oplus " n
%format otimes m n = m "\otimes " n
%format or = " \mathbin\vee "
%format pmean (f) = "\mean{" f "}"
%format schoice q f g = "{" f "}\choice{" q "}{" g "}"
%format succ = " \succ "
%format . = " \comp "
%------------------------------------------
\urldef{\mailsa}\path||jno@@di.uminho.pt||
\urldef{\mailsb}\path||danielrpmurta@@gmail.com||
%def\matlab{\textsc{Matlab}}
\def\kr{\mathbin{\hbox{\tiny${}^\vartriangle$}}}
\def\kcomp{\mathbin{\bullet}}
\def\succ{\mathsf{succ}}
\def\inN{\mathsf{in}}
\def\N{\mathbb{N}\index{Números naturais ($I\!\!N$)}}
%def\msplit#1#2{\left[\frac{#1}{#2}\right]} % Split
%let\iso=\cong
\let\kons=\underline
%def\mblock#1#2#3#4{\left[\begin{array}{c||c}#1&#2\\\hline#3&#4\end{array}\right]}

%def\had{*}
\def\for#1#2{\mathsf{for}\ #1 \ #2}
\def\map#1{\mathsf{map}\ #1}
\def\choice#1{\mathbin{_{#1}\diamond}}
%def\ap#1#2{#1(#2)}
%def\wider#1{~ #1 ~}
\def\meither#1#2{\left[#1||#2\right]}        % Either
\def\msplit#1#2{\left[\frac{#1}{#2}\right]} % Split
\def\xarrayin#1{\begin{array}{ccccccc}#1\end{array}}
\def\rcb#1#2#3#4{\def\nothing{}\def\range{#3}\mathopen{\langle}#1 \ #2 \ \ifx\range\nothing::\else: \ #3 :\fi \ #4\mathclose{\rangle}}
\def\comp{\mathbin{\cdot}}
\def\conj#1#2{\mathopen{\langle} #1, #2 \mathclose{\rangle}}
\def\conv#1{#1^\circ}
\def\crflx#1{\Phi_{#1}}
\def\mcond#1#2#3{#1 \rightarrow #2 , #3}
\def\just#1#2{\\ &#1& \rule{2em}{0pt} \{ \mbox{\rule[-.7em]{0pt}{1.8em} \small #2 \/} \} \nonumber\\ && }
\def\longjust#1#2{\\ &#1& \rule{2em}{0pt}
\left\{\begin{tabular}{l}#2\end{tabular} \right\} \nonumber\\ && }
\def\implied{\mathbin\Leftarrow}
% -----------------------------------------

\def\imports{
\begin{code}
import Cp
import Qais
import Faulty
import Data.List
import Probability
import System.Cmd
import System.Time

mcond = Cp.cond
\end{code}
}

\begin{document}

\maketitle

\begin{abstract}
This file is a Haskell executable.
It contains the experimental part of the homonym paper (submitted).
Please unzip \verb!website.zip! first and then move to the
just created directory \verb!website!.
For the Haskell part run
\begin{quote}
\begin{verbatim}
ghci -XNPlusKPatterns paper_haskell_matlab
\end{verbatim}
\end{quote}
and follow the examples in part I below.
For the MATLAB part, open MATLAB in the \verb!website/matlab! directory,
where all the executables can be found and run the scripts of part II.

Both parts follow the structure of the homonym paper.
\end{abstract}

\part{Haskell}

\section{Introduction}
\section{Motivation}
\section{Mutual recursion}
Fibonacci:
\begin{code}
fib 0 = 0
fib 1 = 1
fib(n+2) = fib n + fib(n+1)
\end{code}
Mutually-recursive equivalent:
\begin{code}
fib' 0 = 0
fib'(n+1) = f n

f 0 = 1
f(n+1) = fib' n + f n
\end{code}
For-loop combinator:
\begin{code}
for b i 0 = i
for b i (n+1) = b(for b i n)
\end{code}
Linear Fibonacci:
\begin{code}
fibl n =
    let (x,y) = for loop (0,1) n
        loop(x,y) = (y, x + y)
    in x
\end{code}
Linear square:
\begin{code}
sql n =
   let (s,o) = for loop (0,1) n
       loop(s,o)=(s+o, o+2)
    in s
\end{code}

\section{Going probabilistic}
Start with:
\begin{code}
mfib 0 = return 0
mfib 1 = return 1
mfib(n+2) =
  do { x <-  mfib n ; y <- mfib(n+1) ; return (x+y) }
\end{code}
Define:
\begin{code}
loop(x,y) = do { z <- fadd 0.1 x y ; return (y,z) }
\end{code}
Re-define:
%format mfib' = "\mathit{mfib}"
\begin{code}
mfib' 0 = return 0
mfib' 1 = return 1
mfib'(n+2) = do { x <-  mfib' n ; y <- mfib'(n+1) ; fadd 0.1 x y }
\end{code}
Run |mfib' 4|:
\begin{quote}\small
\begin{verbatim}
3  81.0%
2  18.0%
1   1.0%
\end{verbatim}
\end{quote}
Define
\begin{code}
mfibl n =
    do { (x,y) <-  mfor loop (0,1) n ; return x }
    where loop(x,y) = return (y, x + y)
\end{code}
where
\begin{code}
mfor b i 0 = return i
mfor b i (n+1) = do {x <- mfor b i n ; b x}
\end{code}
Run |mfib' 5| and |mfibl 5| and then |mfib' 6| and |mfibl' 6|,
to obtain the table in the paper --- table \ref{tab1} below.

Then define
\begin{code}
msq 0 = return 0
msq (n + 1) = do { m <- msq n ; fadd 0.1 m (2*n+1) }
\end{code}
and
\begin{code}
msql n =
   do { (s,o) <- mfor loop (0,1) n ; return s }
      where loop(s,o)=
               do { z <- fadd 0.1 s o ; return (z, o+2) }
\end{code}
Run |msq n| and |msql n| for |n=1..| to check their
probabilistic equality, as in the table (table \ref{tab2} below).

\section{Probabilistic |for|-loops in the LAoP}
Define
\begin{code}
ftwice = mfor (fadd 0.1 2) 0
\end{code}
Run |ftwice 4|:
\begin{quote}\small
\begin{verbatim}
*Main> ftwice 4
8  65.6%
6  29.2%
4   4.9%
2   0.4%
0   0.0%
\end{verbatim}
\end{quote}
Define
\begin{code}
mfibl' n =
    do { (x,y) <-  mfor loop (0,1) n ; return x }
\end{code}
Run |mfibl' 5|:
\begin{quote}\small
\begin{verbatim}
*Main> mfibl' 5
5  72.9%
3  16.2%
4   8.1%
2   2.7%
1   0.1%
\end{verbatim}
\end{quote}

\section{Probabilistic mutual recursion in the LAoP}
%format ff = "f "
%format gg = "g "
Function |ff|:
\begin{code}
ff 1 = uniform [1..2]
ff 2 = D [(1,0.3),(2,0.7)]
ff 3 = return 2
ff 4 = D [(1,0.75),(2,0.25)]
\end{code}
Function |gg|:
\begin{code}
gg 1 = D [(1,0.3),(2,0.7)]
gg 2 = D [(1,0.4),(2,0.2),(3,0.4)]
gg 3 = D [(1,0.1),(2,0.2),(3,0.7)]
gg 4 = return 2
\end{code}
Function |k|:
\begin{code}
k 1 = D( [((1,1),0.24),((1,2),0.08),((1,3),0.08)] ++ [((2,1),0.36),((2,2),0.12),((2,3),0.12)])
\end{code}
Checking column |1|:
\begin{code}
k1 = k 1 == (kr (mfst.k)(msnd . k)) 1
\end{code}
\begin{verbatim}
(2,1)  36.0%
(1,1)  24.0%
(2,2)  12.0%
(2,3)  12.0%
(1,2)   8.0%
(1,3)   8.0%
\end{verbatim}
\section{Asymmetric Khatri-Rao product}
\section{Probabilistic mutual recursion resumed}
\begin{code}
msqlo n =
   do { (s,o) <- mfor loop (0,1) n ; return o }
      where loop(s,o)=
               do { z <- fadd 0.1 s o ; return (z, o+2) }
\end{code}
\begin{code}
odd' 0 = return 1
odd'(n+1) = do { x <- odd' n ; fadd 0.1 2 x}
\end{code}
\begin{code}
msq' 0 = return 0
msq' (n + 1) = do { m <- msq' n ; x <- odd' n ; fadd 0.1 m x }
\end{code}
\begin{code}
msql' n =
   do { (s,o) <- mfor loop (0,1) n ; return s } where
       loop(s,o)= do {
           z <- fadd 0.1 s o ; x <- fadd 0.1 2 o ;
           return (z, x) }
\end{code}
\section{Generalizing to other fault propagation patterns}
Define
\begin{code}
fcat = mfold (schoice 0.1 snd cons) (return [])
\end{code}
where
\begin{code}
mfold :: Monad m => ((a, b) -> m b) -> m b -> [a] -> m b
mfold f d [] = d
mfold f d (h:t) = do { x <- mfold f d t ; f(h, x) }
\end{code}
Run |fcat "abc"| to obtain:
\begin{quote}\small
\begin{verbatim}
*Main> fcat "abc"
"abc"  72.9%
 "ab"   8.1%
 "ac"   8.1%
 "bc"   8.1%
  "a"   0.9%
  "b"   0.9%
  "c"   0.9%
   ""   0.1%
\end{verbatim}
\end{quote}
Define
\begin{code}
fcount = mfold ((schoice 0.15 id succ).snd) (return 0)
\end{code}
Run |fcount "abc"|:
\begin{quote}\small
\begin{verbatim}
*Main> fcount "abc"
3  61.4%
2  32.5%
1   5.7%
0   0.3%
\end{verbatim}
\end{quote}
Define
\begin{code}
pipe = fcount .! fcat
\end{code}
Run |pipe "abc"|:
\begin{quote}\small
\begin{verbatim}
*Main> pipe "abc"
3  44.8%
2  41.3%
1  12.7%
0   1.3%
\end{verbatim}
\end{quote}
Fusion --- define
\begin{code}
ffcount = mfold (mix 0.1 0.15) (return 0)
          where mix p q = (choice p return (schoice q id succ)).snd
\end{code}
and run:
\begin{verbatim}
*Main> ffcount "abc"
3  44.8%
2  41.3%
1  12.7%
0   1.3%
\end{verbatim}

\subsubsection*{Auxiliary}
\begin{code}
cons(h,t)=h:t
nil _ = []

add(x,y)=x+y
zero = const 0
one  = const 1
\end{code}

\part{MATLAB}

\setcounter{section}{0}

\section{Introduction}
\section{Motivation}
\section{Mutual recursion}

To run the recursive version of \textit{fib}, without injecting any faulty behaviour, run for instance:

\begin{verbatim}
 >> execFibr(@nfAdd,5,10,4)

ans =

     1     0     0     0     0
     0     1     1     0     0
     0     0     0     1     0
     0     0     0     0     1
     0     0     0     0     0
     0     0     0     0     0
     0     0     0     0     0
     0     0     0     0     0
     0     0     0     0     0
     0     0     0     0     0
\end{verbatim}

The first parameter of the command is, basically, the \textit{add} function the command will use to calculate its result. In this case we are passing a \textit{non-faulty} add (nfAdd), since we want a sharp Fibonacci. The next two parameters are the numbers of columns and rows, respectively, of the result matrix. In order to calculate (to see) \textit{fib 4}, for example, one has to force, at least, 5 columns, because the first one corresponds to zero (\textit{fib 0}). The last parameter corresponds to the actual input number we want to pass to the Fibonacci function. If $matrix(3,4)=1$ (\textit{matrix(line,column) with indexes beginning at 1}) then $fib (4-1)=(3-1)$ or $fib 3 = 2$. Thus, observing the matrix, we can see that \textit{fib 0 = 0}, \textit{fib 1 = 1}... as it was supposed.

To run the linear version of \textit{fib}, without injecting any faulty behaviour, run for instance:

\begin{verbatim}
 >> execFibl(@nfAdd,6,10,5)

ans =

     1     0     0     0     0     0
     0     1     1     0     0     0
     0     0     0     1     0     0
     0     0     0     0     1     0
     0     0     0     0     0     0
     0     0     0     0     0     1
     0     0     0     0     0     0
     0     0     0     0     0     0
     0     0     0     0     0     0
     0     0     0     0     0     0
\end{verbatim}

Please note that, in this case, we increased the number of rows to 6 so that we could see the result of \textit{fib} for 5.

To run the linear version of \textit{sq}, without injecting any faulty behaviour, run for instance:

\begin{verbatim}
 >> execSql(@nfAdd,4,10,3)

ans =

     1     0     0     0
     0     1     0     0
     0     0     0     0
     0     0     0     0
     0     0     1     0
     0     0     0     0
     0     0     0     0
     0     0     0     0
     0     0     0     0
     0     0     0     1
\end{verbatim}

Please note that, in this case, we used 10 for the number of columns of the result matrix, simply, because we know that \textit{sq 3 = 9}, so we must have at least 10 rows to
visualize 9 as result.

\section{Going probabilistic}

In this section we intend to inject some faults in the \textit{sq} and \textit{fib} functions. To do this, instead of using a non-faulty add function as the first parameter of the commands in the previous section, we can use faulty ones.

To obtain the results displayed in table \ref{tab1} presented in section 4 of the article run:

\begin{table}
\begin{center}
\begin{tabular}{c||c||c}
|n| & |mfib n| & |mfibl n|
\\\hline
	5
&
	\begin{minipage}{30em}
\begin{verbatim}
5  65.6%
4  21.9%
3  10.5%
2   1.9%
1   0.1%
\end{verbatim}
	\end{minipage}
&
	\begin{minipage}{30em}
\begin{verbatim}
5  72.9%
3  16.2%
4   8.1%
2   2.7%
1   0.1%
\end{verbatim}
	\end{minipage}
\\\hline
	6
&
	\begin{minipage}{30em}
\begin{verbatim}
8  47.8%
7  26.6%
6  11.8%
5   9.8%
4   2.7%
3   1.1%
2   0.2%
1   0.0%
\end{verbatim}
	\end{minipage}
&
	\begin{minipage}{30em}
\begin{verbatim}
8  65.6%
5  14.6%
6  14.6%
3   2.4%
4   2.4%
2   0.4%
1   0.0%
\end{verbatim}
	\end{minipage}
\end{tabular}
\end{center}
\caption{Faulty Fibonacci (recursive and linear)}
\label{tab1}
\end{table}

\begin{verbatim}
 >> mfib(7,12)

ans =

    1.0000         0         0         0         0         0         0
         0    1.0000    1.0000    0.1000    0.0100    0.0010    0.0001
         0         0         0    0.9000    0.1800    0.0189    0.0019
         0         0         0         0    0.8100    0.1053    0.0109
         0         0         0         0         0    0.2187    0.0266
         0         0         0         0         0    0.6561    0.0984
         0         0         0         0         0         0    0.1181
         0         0         0         0         0         0    0.2657
         0         0         0         0         0         0    0.4783
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
\end{verbatim}

and

\begin{verbatim}
 >> mfibl(7,14)

ans =

    1.0000         0         0         0         0         0         0
         0    1.0000    1.0000    0.1000    0.0100    0.0010    0.0001
         0         0         0    0.9000    0.1800    0.0270    0.0036
         0         0         0         0    0.8100    0.1620    0.0243
         0         0         0         0         0    0.0810    0.0243
         0         0         0         0         0    0.7290    0.1458
         0         0         0         0         0         0    0.1458
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.6561
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
\end{verbatim}

The last two columns of each result matrix present the results displayed in table \ref{tab1}.

To obtain the results displayed in table \ref{tab2} also present in section 4 of the article run:

\begin{table}
\begin{center}
\begin{tabular}{c||c||c}
|n| & |msq n| & |msql n|
\\\hline
	0
&
	\begin{minipage}{30em}
\begin{verbatim}
0 100.0%
\end{verbatim}
	\end{minipage}
&
	\begin{minipage}{30em}
\begin{verbatim}
0 100.0%
\end{verbatim}
	\end{minipage}
\\\hline
	1
&
	\begin{minipage}{30em}
\begin{verbatim}
1 100.0%
\end{verbatim}
	\end{minipage}
&
	\begin{minipage}{30em}
\begin{verbatim}
1 100.0%
\end{verbatim}
	\end{minipage}
\\\hline
	2
&
	\begin{minipage}{30em}
\begin{verbatim}
4  90.0%
3  10.0%
\end{verbatim}
	\end{minipage}
&
	\begin{minipage}{30em}
\begin{verbatim}
4  90.0%
3  10.0%
\end{verbatim}
	\end{minipage}
\\\hline
	3
&
	\begin{minipage}{30em}
\begin{verbatim}
9  81.0%
5  10.0%
8   9.0%
\end{verbatim}
	\end{minipage}
&
	\begin{minipage}{30em}
\begin{verbatim}
9  81.0%
5  10.0%
8   9.0%
\end{verbatim}
	\end{minipage}
\\\hline
	\vdots
&
	\vdots
&
	\vdots
\\\hline
	6
&
	\begin{minipage}{30em}
\begin{verbatim}
36  59.0%
11  10.0%
20   9.0%
27   8.1%
32   7.3%
35   6.6%
\end{verbatim}
	\end{minipage}
&
	\begin{minipage}{30em}
\begin{verbatim}
36  59.0%
11  10.0%
20   9.0%
27   8.1%
32   7.3%
35   6.6%
\end{verbatim}
	\end{minipage}
\\\hline
	\vdots
&
	\vdots
&
	\vdots
\end{tabular}
\end{center}
\label{tab2}
\caption{Faulty square (recursive and linear)}
\end{table}

\begin{verbatim}
 >> msq(7,40)

ans =

    1.0000         0         0         0         0         0         0
         0    1.0000         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0    0.1000         0         0         0         0
         0         0    0.9000         0         0         0         0
         0         0         0    0.1000         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0    0.1000         0         0
         0         0         0    0.0900         0         0         0
         0         0         0    0.8100         0    0.1000         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.1000
         0         0         0         0    0.0900         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0    0.0810         0         0
         0         0         0         0    0.7290    0.0900         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.0900
         0         0         0         0         0    0.0810         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0    0.0729         0
         0         0         0         0         0    0.6561         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.0810
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.0729
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.0656
         0         0         0         0         0         0    0.5905
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
\end{verbatim}

and

\begin{verbatim}
 >> msql(7,40)

ans =

    1.0000         0         0         0         0         0         0
         0    1.0000         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0    0.1000         0         0         0         0
         0         0    0.9000         0         0         0         0
         0         0         0    0.1000         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0    0.1000         0         0
         0         0         0    0.0900         0         0         0
         0         0         0    0.8100         0    0.1000         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.1000
         0         0         0         0    0.0900         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0    0.0810         0         0
         0         0         0         0    0.7290    0.0900         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.0900
         0         0         0         0         0    0.0810         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0    0.0729         0
         0         0         0         0         0    0.6561         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.0810
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.0729
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0    0.0656
         0         0         0         0         0         0    0.5905
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
         0         0         0         0         0         0         0
\end{verbatim}

\section{Probabilistic |for|-loops in the LAoP}
\section{Probabilistic mutual recursion in the LAoP}

To obtain the results displayed in first diagram of section 6 in the paper run:

\begin{verbatim}
 >> f = [0.5 0.3 0 0.75;0.5 0.7 1 0.25];
 >> g = [0.3 0.4 0.1 0;0.7 0.2 0.2 1;0 0.4 0.7 0];
 >> kr(f,g)

ans =

    0.1500    0.1200         0         0
    0.3500    0.0600         0    0.7500
         0    0.1200         0         0
    0.1500    0.2800    0.1000         0
    0.3500    0.1400    0.2000    0.2500
         0    0.2800    0.7000         0

 >> fst(2,3)

ans =

     1     1     1     0     0     0
     0     0     0     1     1     1

 >> snd(2,3)

ans =

     1     0     0     1     0     0
     0     1     0     0     1     0
     0     0     1     0     0     1
\end{verbatim}

\section{Asymmetric Khatri-Rao product}
\section{Probabilistic mutual recursion resumed}

In this section we injected two faults to the \textit{square} functions. They were called \textit{sq'} and \textit{sql'} in the paper. To obtain the results displayed in table \ref{tab3} present in section 8 of the paper, run the following commands:

\begin{verbatim}
 >> msq2(4,12)

ans =

    1.0000         0         0         0
         0    1.0000    0.0100    0.0010
         0         0    0.0900    0.0001
         0         0    0.0900    0.0188
         0         0    0.8100    0.0024
         0         0         0    0.1029
         0         0         0    0.0219
         0         0         0    0.1968
         0         0         0    0.0656
         0         0         0    0.5905
         0         0         0         0
         0         0         0         0
\end{verbatim}

and

\begin{verbatim}
 >> msql2(4,12)

ans =

    1.0000         0         0         0
         0    1.0000    0.0100    0.0010
         0         0    0.0900    0.0009
         0         0    0.0900    0.0261
         0         0    0.8100    0.0081
         0         0         0    0.1539
         0         0         0    0.0081
         0         0         0    0.0729
         0         0         0    0.0729
         0         0         0    0.6561
         0         0         0         0
         0         0         0         0
\end{verbatim}

\begin{table}
\begin{center}
\begin{tabular}{c||c||c}
|n| & |msq' n| & |msql' n|
\\\hline
	3
&
	\begin{minipage}{30em}
\begin{verbatim}
9  59.0%
7  19.7%
5  10.3%
8   6.6%
6   2.2%
3   1.9%
4   0.2%
1   0.1%
2   0.0%
\end{verbatim}
	\end{minipage}
&
	\begin{minipage}{30em}
\begin{verbatim}
9  65.6%
5  15.4%
7   7.3%
8   7.3%
3   2.6%
4   0.8%
6   0.8%
1   0.1%
2   0.1%
\end{verbatim}
	\end{minipage}
\end{tabular}
\end{center}
\caption{Double faulty \textit{square} functions}
\label{tab3}
\end{table}

\section{Generalizing to other fault propagation patterns}

This section was conceived so that we could extend faulty behaviour to functions
with types other than the Naturals. In this case we opted for the Sequences
type, and to do that we presented two particular functions over sequences
which are the $count$ and $cat$. The $cat$ function is the identity of sequences
and the $count$ counts the number of elements of a sequence. These functions
were also implemented with Matlab, however their output is bit more difficult
to understand because, by the time we start dealing with sequences, the cardinality
of the types grows very much.

To obtain the results of $fcat "abc"$ run the following command:

\begin{verbatim}
 >> faultyCat(3,3,3)
\end{verbatim}

Prompting the command, you realize that the output given is somewhat extensive - a matrix $40 \times 40$. The reason for this is very simple. $faultyCat$ receives:
\begin{enumerate}
\item The number of different elements that can constitute the sequence. If you choose 3, like in this case, you can imagine a sequence only with 1, 2 and 3 as possible elements;
\item The maximum length of the sequences. If you choose 3, like in this case, you can imagine sequences with 0, 1, 2 or 3 as length;
\item The number of iterations the function is supposed to run.
\end{enumerate}

When we pass to $faultyCat$ those parameters we've just passed, it generates all the sequences possible respecting the parameters: 3 different elements and 3 as maximum length.
There are 3 different lists with one element only, 9 with two elements and 27 with three elements and, lastly, the empty list. Doing the math, we have $1+3+9+27 = 40$ different sequences, and that's were the dimension of the result matrix comes from.

In order to easily understand the result matrix, scrolling up the screen is possible to visualize that a matrix called ``columns'' was calculated - this matrix indicates the order of the result matrix. So, to see, for instance what is the result given by $faultyCat$ for a the sequence \textit{``abc''}, like in the paper, firstly you need to count the position of the sequence in the \textit{columns} matrix, and then you need to look up, in the result matrix, the column with the number you got first. Thus, for the sequence \textit{``abc''}, looking it up in the \textit{columns} matrix, we realize it stands in the $35^{th}$ line, which is the sequence $[1 2 3 0]$. Then, the $35^{th}$ column in the result matrix is the following:

\begin{verbatim}
    0.0010
    0.0090
    0.0090
    0.0090
         0
         0
         0
    0.0810
         0
         0
    0.0810
    0.0810
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
    0.7290
         0
         0
         0
         0
         0
\end{verbatim}

This column is the result of $faultyCat "abc"$, just like in the paper. To interpret this column, once again we have to rely on the \textit{columns} matrix. The first row of $faultyCat "abc"$ is $0.0010$ and the first row the \textit{columns} matrix is $0 0 0 0$, which corresponds to the empty sequence ($[]$). This means that $faultyCat "abc" = []$ with $0.1$ per cent of probability. The same `line of though'' is applied to the remaining lines, which allow us to obtain the same result displayed in the paper:

\begin{verbatim} 
"abc"  72.9%
"ab"    8.1%
"ac"    8.1%
"bc"    8.1%
"a"     0.9%
"b"     0.9%
"c"     0.9%
""      0.1%
\end{verbatim} 

To execute $fcount "abc"$ prompt the following command in matlab:

\begin{verbatim}
 >> faultyCount(3,3,3)
\end{verbatim}

This function has the same parameters $faultyCat$ has, however, in this case, we are calculating the length of sequences, which means that the output type is Naturals, not Sequences as it was before. This means that the result matrix does not have to be as large as it was with $faultyCat$. The $35^{th}$ column of the result displays $faultyCount "abc"$:

\begin{verbatim}
    0.0034
    0.0574
    0.3251
    0.6141
\end{verbatim}

To execute \textit{fcount . fcat "abc"}:

\begin{verbatim} 
 >> count = faultyCount(3,3,3);
 >> cat = faultyCat(3,3,3);
 >> result = count*cat;
 >> result(1:4,35)

ans =

    0.0130
    0.1267
    0.4126
    0.4477
\end{verbatim} 

\section*{Acknowledgements}
This research was carried out in the 
QAIS (Quantitative analysis of interacting systems) % : foundations and algorithms)
project funded by the ERDF through the Programme COMPETE and by the Portuguese 
Government through FCT (Foundation for Science and Technology)
contract PTDC/EIA-CCO/122240/2010.

Daniel Murta holds grant
{\small\verb!BI1-2012_PTDC/EIA-CCO/122240/2010_UMINHO/!}
awarded by FCT (Portuguese Foundation for Science and Technology).

\end{document}

Next in the queue:
\begin{code}
msql''' n =
   do { (s,o) <- mfor loop' (0,1) n ; return o }

loop'(s,o)= do {
           z <- fadd 0.1 s o ; x <- fadd 0.1 2 o ;
           return (z, x) }
\end{code}
cf.
\begin{verbatim}
*Main> odd' 5
11  59.0%
 9  32.8%
 7   7.3%
 5   0.8%
 3   0.0%
 1   0.0%

*Main> msql''' 5
11  59.0%
 9  32.8%
 7   7.3%
 5   0.8%
 3   0.0%
 1   0.0%
\end{verbatim}


---+ Project PTDC/EIA-CCO/122240/2010


---++ Grant BI1-2012_PTDC/EIA-CCO/122240!/2010_UMINHO


---+++ WP1 - Calculating fault propagation in functional programs


This site contains the experimental part of the homonym paper.

Please unzip [[website.zip]] first and then move to the
just created directory <u>website</u>.

For the Haskell part run 

ghci -XNPlusKPatterns paper_haskell_matlab

and follow the examples in Part I of [[paper_haskell_matlab.pdf]]

For the MATLAB part, open MATLAB in the same directory,
where all the executables can be found, and run Part II of [[paper_haskell_matlab.pdf]]

Please report comments, bugs etc to Daniel Murta (danielrpmurta@gmail.com) or
Jose Oliveira (jno@di.uminho.pt).



