incr(null, f1(null)).
incr(f0(X), f1(X)).
incr(f1(Y), f0(X)):-incr(Y, X).

legal(f0(null)).
legal(P):-legal(P1),incr(P1,P).

incR(X,Y):-legal(X),incr(X,Y).

add(X, f0(null), X).
add(X,Y,Z):-incr(X,X1),incr(Y1,Y),add(X1,Y1,Z).

mult(_, f0(null), f0(null)).
mult(X,Y,Z):-mult(X,Y,Z,X).
mult(_,f1(null),Z,Z).
mult(X,Y,Z,X1):-incr(Y1,Y),add(X,X1,X2),mult(X,Y1,Z,X2).

revers(f0(null),null).
revers(X,Y):-revers(X,Y,null).
revers(null,Y,Y).
revers(f0(X),Y,Y1):-revers(X,Y,f0(Y1)).
revers(f1(X),Y,Y1):-revers(X,Y,f1(Y1)).

normalize(null, f0(null)).
normalize(X,Y):-revers(X,X1), normalize(X1,Y,null).
normalize(f0(X),Y,Z):-Z=null,normalize(X,Y,Z).
normalize(f0(X),Y,Z):-Z\=null,normalize(X,Y,f0(Z)).
normalize(f1(X),Y,Z):-normalize(X,Y,f1(Z)).
normalize(f0(null),f0(Z),Z).
normalize(f1(null),f1(Z),Z).





% test add inputting numbers N1 and N2
testAdd(N1,N2,T1,T2,Sum,SumT) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
add(T1,T2,SumT), pterm2numb(SumT,Sum).

% test mult inputting numbers N1 and N2
testMult(N1,N2,T1,T2,N1N2,T1T2) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
mult(T1,T2,T1T2), pterm2numb(T1T2,N1N2).
% test revers inputting list L
testRev(L,Lr,T,Tr) :- ptermlist(T,L), revers(T,Tr), ptermlist(Tr,Lr).
% test normalize inputting list L
testNorm(L,T,Tn,Ln) :- ptermlist(T,L), normalize(T,Tn), ptermlist(Tn,Ln).
% make a pterm T from a number N numb2term(+N,?T)
numb2pterm(0,f0(null)).
numb2pterm(N,T) :- N>0, M is N-1, numb2pterm(M,Temp), incr(Temp,T).
% make a number N from a pterm T pterm2numb(+T,?N)
pterm2numb(null,0).
pterm2numb(f0(X),N) :- pterm2numb(X,M), N is 2*M.
pterm2numb(f1(X),N) :- pterm2numb(X,M), N is 2*M +1.
% reversible ptermlist(T,L)
ptermlist(null,[]).
ptermlist(f0(X),[0|L]) :- ptermlist(X,L).
ptermlist(f1(X),[1|L]) :- ptermlist(X,L).