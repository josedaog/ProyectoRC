/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  Sudoku

  El sudoku tendrá esta estructura:  

    Problema introducido             Solución

    .  .  4 | 8  .  . | .  1  7     9  3  4 | 8  2  5 | 6  1  7	     
            |         |                     |         |
    6  7  . | 9  .  . | .  .  .     6  7  2 | 9  1  4 | 8  5  3
            |         |                     |         |
    5  .  8 | .  3  . | .  .  4     5  1  8 | 6  3  7 | 9  2  4
    --------+---------+--------     --------+---------+--------
    3  .  . | 7  4  . | 1  .  .     3  2  5 | 7  4  8 | 1  6  9
            |         |                     |         |
    .  6  9 | .  .  . | 7  8  .     4  6  9 | 1  5  3 | 7  8  2
            |         |                     |         |
    .  .  1 | .  6  9 | .  .  5     7  8  1 | 2  6  9 | 4  3  5
    --------+---------+--------     --------+---------+--------
    1  .  . | .  8  . | 3  .  6     1  9  7 | 5  8  2 | 3  4  6
            |         |                     |         |
    .  .  . | .  .  6 | .  9  1     8  5  3 | 4  7  6 | 2  9  1
            |         |                     |         |
    2  4  . | .  .  1 | 5  .  .     2  4  6 | 3  9  1 | 5  7  8

 A cada lugar del tablero le corresponte una línea (horizontal) y una
 columna (vertical) a la vez que una región 3x3.
 En la situación inicial nos encontramos con un tablero aún por rellenar
 con algunos digitos que van desde el 1 hasta el 9.
 El problema que surge a continuación es completar los huecos vacíos 
 con dígitos del 1 al 9 de manera que en cada línea, columna  y región
 aparezca un solo dígito.

 Para representar el Sudoku en Prolog lo haremos a través de una simple
 lista de 81 dígitos. La introduciremos con algunos dígitos y el programa
 deberá ser capaz de devolvernos las posibles soluciones. Es posible
 añadirle el sudoku a solicionar tanto a través de este código en el apartado
 de ejemplos como al ejecutar el programa.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- use_module(library(clpz)).
:- use_module(library(lists)).
:- use_module(library(format)).
:- use_module(library(dcgs)).
:- use_module(library(freeze)).
:- use_module(library(charsio)).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Constraint posting
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

sudoku(Rows) :-
        length(Rows, 9), maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns), maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
        blocks(As, Bs, Cs), blocks(Ds, Es, Fs), blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Animation.

   A frozen goal for each variable emits PostScript instructions to
   draw a number. On backtracking, the field is cleared.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

animate(Rows) :- animate(Rows, 1).

animate([], _).
animate([Row|Rows], N) :-
        animate(Row, 1, N),
        N1 #= N + 1,
        animate(Rows, N1).

animate([], _, _).
animate([C|Cs], Col, Row) :-
        freeze(C, label(Col, Row, C)),
        Col1 #= Col + 1,
        animate(Cs, Col1, Row).

label(Col, Row, N) :- format("(~w) ~w ~w num\n", [N,Col,Row]).
label(Col, Row, _) :- format("~w ~w clear\n", [Col,Row]), false.

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   PostScript definitions. Place a number N and clear a cell with:

   (N) Col Row num
   Col Row clear
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

postscript -->
        "/Palatino-Bold findfont 5 scalefont setfont \
        320 9 div dup scale 0 setlinewidth -0.9 -0.9 translate \
        /num { gsave 10 exch sub translate 0.5 0.25 translate 0.16 dup scale \
             dup stringwidth pop -2 div 0 moveto show grestore } bind def \
        /clear { gsave 10 exch sub translate 1 setgray 0.1 dup 0.8 \
             dup rectfill grestore } bind def \
        1 1 10 { gsave dup 1 moveto 10 lineto stroke grestore } for \
        1 1 10 { gsave dup 1 exch moveto 10 exch lineto stroke grestore } for \
        1 3 9 { 1 3 9 { 1 index gsave translate 0.05 setlinewidth \
             0 0 3 3 rectstroke grestore } for pop } for\n".

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Set up communication with gs.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

show(Options, Rows) :-
        sudoku(Rows),
        phrase(postscript, Ps),
        format("~s", [Ps]),
        append(Rows, Vs),
        animate(Rows),
        labeling(Options, Vs),
        get_single_char(_),
        false.
show(_, _) :- halt.

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Sample problems.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

problem(1, P) :- 
        P = [[1,_,_,8,_,4,_,_,_],
             [_,2,_,_,_,_,4,5,6],
             [_,_,3,2,_,5,_,_,_],
             [_,_,_,4,_,_,8,_,5],
             [7,8,9,_,5,_,_,_,_],
             [_,_,_,_,_,6,2,_,3],
             [8,_,1,_,_,_,7,_,_],
             [_,_,_,1,2,3,_,8,_],
             [2,_,5,_,_,_,_,_,9]].


problem(2, P) :-  
        P = [[_,_,2,_,3,_,1,_,_],
             [_,4,_,_,_,_,_,3,_],
             [1,_,5,_,_,_,_,8,2],
             [_,_,_,2,_,_,6,5,_],
             [9,_,_,_,8,7,_,_,3],
             [_,_,_,_,4,_,_,_,_],
             [8,_,_,_,7,_,_,_,4],
             [_,9,3,1,_,_,_,6,_],
             [_,_,7,_,6,_,5,_,_]].

problem(3, P) :-
        P = [[1,_,_,_,_,_,_,_,_],
             [_,_,2,7,4,_,_,_,_],
             [_,_,_,5,_,_,_,_,4],
             [_,3,_,_,_,_,_,_,_],
             [7,5,_,_,_,_,_,_,_],
             [_,_,_,_,_,9,6,_,_],
             [_,4,_,_,_,6,_,_,_],
             [_,_,_,_,_,_,_,7,1],
             [_,_,_,_,_,1,_,3,_]].

test(N) :- 
    problem(N, Rows),
    sudoku(Rows),
    maplist(label, Rows),
    maplist(portray_clause, Rows).
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Examples:

   ?- use_module(library(time)).
      true.

   ?- time((problem(1, Rows), sudoku(Rows),
      maplist(labeling([ff]), Rows), maplist(portray_clause, Rows))).
   [1,5,6,8,9,4,3,2,7].
   [9,2,8,7,3,1,4,5,6].
   [4,7,3,2,6,5,9,1,8].
   [3,6,2,4,1,7,8,9,5].
   [7,8,9,3,5,2,6,4,1].
   [5,1,4,9,8,6,2,7,3].
   [8,3,1,5,4,9,7,6,2].
   [6,9,7,1,2,3,5,8,4].
   [2,4,5,6,7,8,1,3,9].
      % CPU time: 8.585 seconds

   ?- show([ff], Rows).

   ?- problem(1, Rows), show([ff], Rows).

   Shell command:

   $ scryer-prolog -g 'problem(3,Rows),show([ff],Rows)' sudoku.pl | \
        gs -dNOPROMPT -g680x680 -dGraphicsAlphaBits=2 -r150 -q

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
