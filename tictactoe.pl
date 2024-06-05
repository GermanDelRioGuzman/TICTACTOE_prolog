
:- dynamic o/1.
:- dynamic x/1.

% the various combinations of a successful horizontal, vertical_or diagonal line 

ordered_line(1,2,3).
ordered_line(4,5,6).
ordered_line(7,8,9).
ordered_line(1,4,7).
ordered_line(2,5,8).
ordered_line(3,6,9).
ordered_line(1,5,9).
ordered_line(3,5,7).

%line predicate to complete lines

line(A,B,C) :- ordered_line(A,B,C).
line(A,B,C) :- ordered_line(A,C,B).
line(A,B,C) :- ordered_line(B,A,C).
line(A,B,C) :- ordered_line(B,C,A).
line(A,B,C) :- ordered_line(C,A,B).
line(A,B,C) :- ordered_line(C,B,A).


full(A) :- x(A).
full(A) :- o(A).

empty(A) :- not(full(A)).

all_full :- full(1),full(2),full(3),full(4),full(5),
full(6),full(7),full(8),full(9).


done :- ordered_line(A,B,C), x(A), x(B), x(C), write('Player 2 win.'),nl.

done :- ordered_line(A,B,C), o(A), o(B), o(C), write('Player 1 win.'),nl.

done :- all_full, write('Draw.'), nl.

move1 :- write('Player 1 (o) enter a move: '), read(X), between(1,9,X),  
empty(X), assert(o(X)).
move1:-all_full.
move2 :-  write('Player 2 (x) enter a move: '), read(X), between(1,9,X),  
empty(X),assert(x(X)).
move2:- all_full.
printsquare(N) :- o(N), write(' o ').
printsquare(N) :- x(N), write(' x ').
printsquare(N) :- empty(N), write('   ').

printboard :- printsquare(1),printsquare(2),printsquare(3),nl,
          printsquare(4),printsquare(5),printsquare(6),nl,
          printsquare(7),printsquare(8),printsquare(9),nl.

clear :- x(A), retract(x(A)), fail.
clear :- o(A), retract(o(A)), fail.

play :- not(clear), repeat, move1, printboard, move2,printboard, done.

