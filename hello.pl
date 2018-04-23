:- initialization(main).

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

queens(N,Qs) :-
      range(1,N,Ns),
      queens(Ns,[],Qs);
      write('impossible').
      queens([],Qs,Qs).

queens(UnplacedQs,SafeQs,Qs) :-
      myselect(UnplacedQs,UnplacedQs1,Q),
      not_attack(SafeQs,Q),
      queens(UnplacedQs1,[Q|SafeQs],Qs).

printingarray(X,Y,Z):-
	X<Y,X<Z,write(X),X is X+1,nl,printingarray(X,Y,Z);
	X==Y,X<Z,write(X),X is X+1,nl,printingarray(X,Y,Z);
	X > Y,X<Z,write(X),X is X+1,nl,printingarray(X,Y,Z);
	 X==Z,write('fuck').
	

%% Checks whether the queen can plaved in a position based on previous placed queens

%% initialization recursion
not_attack(Xs,X) :-
      not_attack(Xs,X,1).

%% base
not_attack([],_,_) :- !.

%% recursion
not_attack([Y|Ys],X,N) :-
	X =\= Y+N, 
	X =\= Y-N,
	N1 is N+1,
	not_attack(Ys,X,N1).

%% base
myselect([X|Xs],Xs,X).
%% recursion
myselect([Y|Ys],[Y|Zs],X) :- 
	myselect(Ys,Zs,X).

range(N,N,[N]) :- !.

range(M,N,[M|Ns]) :-
	M < N,
	M1 is M+1,
	range(M1,N,Ns). 

main :- 
	 read_integer(X),
	 read_integer(Y),
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
	Qs = [_,_,_,_,_,_,_,_],
	replace(Qs,X-1,Y,Qs),printingarray(3,3,8),
	queens(8,Qs),write(Qs),
	nl,halt;
	write('impossible'),halt.