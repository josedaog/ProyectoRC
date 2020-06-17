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

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Cada fila (Row) está compuesta por 9 dígitos, la representaremos con una lista
   de 9 elementos, el tablero será pues una lista de estas listas de líneas.

   Para representarlo usamos el siguiente predicado "Sudoku" que definirá si el tablero
   introducido es un tablero válido. 
   Para ello, usamos el predicado length para asegurarnos que la fila está compuesta por
   9 elementos,para asegurarnos que esto se cumple, usamos el meta-predicado maplist() 
   que nos asegura que cada fila tiene el mismo numero de elementos.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

sudoku(Rows) :-
        length(Rows, 9), maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9,                             % De esta forma nos aseguramos que cada elemento de la línea sea un numero entre 1 y 9.
        maplist(all_distinct, Rows),                               % Haciendo uso el predicado all_distinct especificamos que cada elemento debe ser distinto del otro
        transpose(Rows, Columns), maplist(all_distinct, Columns),  % Volvemos ha hacer lo mismo para las columnas, para ello usamos el predicado transpose para convertir las filas en columnas
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],                       % Especificamos las variables de cada fila
        blocks(As, Bs, Cs), blocks(Ds, Es, Fs), blocks(Gs, Hs, Is).% Dividimos cada fila en regiones

blocks([], [], []).                                                % Caso base de 3 bloques vacíos
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-          % Haciendo uso de [Cabeza|Resto] hacemos que cada bloque tenga a lo sumo 3 elementos
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),                % No debe haber elementos repetidos
        blocks(Ns1, Ns2, Ns3).                                     % Debe darse el mismo caso para la segunda y tercera region


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Problemas a resolver, para introducir un nuevo tablero bastaría con
   copiar y pegar la siguiente estructura, añadiendole un numero o letra que lo 
   identifique y rellenando los huecos con el numero que desee.

   Estructura:

problem(numero,P) :- 
        P = [[_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_]].

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

problem(4,P) :-
        P = [[1,_,_,_,_,9,_,_,4],
             [_,_,_,_,_,_,7,_,_],
             [5,_,_,3,_,_,2,_,_],
             [_,8,_,_,_,_,5,_,6],
             [_,_,_,_,8,_,_,_,_],
             [6,9,1,_,_,_,_,8,_],
             [_,_,7,_,_,4,_,_,2],
             [_,_,2,_,_,_,_,_,_],
             [3,_,_,5,_,_,_,7,1]].

% Problema con un error ya que el 5 aparece dos veces en la región superior izquierda,
% otro error podría ser cambiar una x por un numero o viceversa.

problem(e1,P) :- 
        P = [[5,_,2,_,_,3,_,_,_],
             [4,6,5,_,7,_,9,_,_],
             [_,_,3,4,_,_,_,_,_],
             [9,5,_,_,6,_,_,_,_],
             [_,4,_,_,_,_,_,9,_],
             [_,_,_,_,9,_,_,1,7],
             [_,_,_,_,_,7,2,_,_],
             [_,_,9,_,4,_,_,3,5],
             [_,_,_,3,_,_,7,_,6]].

problem(5,P) :- 
        P = [[1,2,3,4,5,6,7,8,9],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,_]].

/* ----------------------------------------------------------------------------------------
        El predicado test(N) es el único que se necesita para resolver el problema, 
        si introduce test(4), resolverá el problema 4. Si introduce test(N) irá resolviendo
        todos los problemas uno a uno con todas las posibles soluciones, para ello
        solo debe presionar ";" y si desea parar ".".
----------------------------------------------------------------------------------------*/

test(N) :- 
        problem(N, Rows),
        sudoku(Rows),
        maplist(label, Rows),
        maplist(portray_clause, Rows).

