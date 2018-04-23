:- initialization(x).

initialposition([_|T], 1, X, [X|T]).
%% setting the initial position in the array 

initialposition([H|T], K, X, [H|R]):- 
	K > 0,
    S is K-1, 
    initialposition(T, S, X, R), !.
	initialposition(L, _, _, L).

%% Checks wether a queen can be placed in a position based on the previous positions

queen(N,Arr) :-
      limits(1,N,Ns),
      queen(Ns,[],Arr);
      write('impossible').

queen([],Arr,Arr).

queen(Notyetdone,Safequeen,Arr) :-
      selectedchoice(Notyetdone,PendingQueen,Q),
      notsafe(Safequeen,Q),
      queen(PendingQueen,[Q|Safequeen],Arr).

%% initialization recursion
notsafe(Xs,X) :-
      notsafe(Xs,X,1).

%% base
notsafe([],_,_) :- !.

%% recursion
notsafe([Y|Ys],X,N) :-
	X =\= Y+N, 
	X =\= Y-N,
	K is N+1,
	notsafe(Ys,X,K).

%% base
selectedchoice([X|Xs],Xs,X).
%% recursion
selectedchoice([Y|Ys],[Y|Zs],X) :- 
	selectedchoice(Ys,Zs,X).

limits(N,N,[N]) :- !.

limits(M,N,[M|Ns]) :-
	M < N,
	K is M+1,
	limits(K,N,Ns). 

%% printing reach row extracting each element of array
printing_row(X,Y,Z):-
	X<Y,X<Z,write('0 '),P is X+1,printing_row(P,Y,Z);
	X==Y,X<Z,write('1 '),P is X+1,printing_row(P,Y,Z);
	X > Y,X<Z,write('0 '),P is X+1,printing_row(P,Y,Z);
	X==Z.

%extracting each element of the array 
print_array([]).

print_array([H|T]):-
    printing_row(1,H,9),nl,
    print_array(T).

%%the main function 
x :- 
	 read_integer(Y),
	 read_integer(X),
	%% Z is X - Y,
	%% write(Z), 
	%% nl,halt;
	%% write('Not Integers'),
	%% nl,
	%% halt.
	X>0,
	X<9,
	Y>0,
	Y<9,
	Arr = [_,_,_,_,_,_,_,_],
	initialposition(Arr,X,Y,Arr),
	queen(8,Arr),
	print_array(Arr),
	halt;
	write('impossible'),
	halt.