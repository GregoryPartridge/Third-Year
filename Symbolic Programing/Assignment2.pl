s --> u(X), [2], {reverse(X, Y)}, u(Y).
u([]) --> [].
u([0 |X]) --> [0], u(X).
u([1 |X]) --> [1], u(X).    

nbd --> h(Clr1,Lang1,Pet1), h(Clr2,Lang2,Pet2), h(Clr3,Lang3,Pet3),
{Clr1 \= Clr2,Clr1 \= Clr3,Clr3 \= Clr2,
  Lang1 \= Lang2,Lang1 \= Lang3,Lang3 \= Lang2,
  Pet1 \= Pet2,Pet1 \= Pet3,Pet3 \= Pet2}.

h(Clr,Lang,Pet) --> [h(Clr,Lang,Pet)],
    {clr(Clr), lang(Lang), pet(Pet)}.

clr(red).
clr(blue).
clr(green).
lang(english).
lang(spanish).
lang(japanese).
pet(jaguar).
pet(snail).
pet(zebra).

accept(L) :- steps(q0,L,F), final(F).
steps(Q,[],Q).
steps(Q,[H|T],Q2) :- tran(Q,H,Qn), steps(Qn,T,Q2).

tran(q0,0,q0).
tran(q0,1,q0).
tran(q0,1,q1).
tran(q1,0,q2).
tran(q1,1,q2).
tran(q2,0,q3).
tran(q2,1,q3).
final(q3).

q0 --> [0], q0.
q0 --> [1], q0.
q0 --> [1], q1.
q1 --> [0], q2.
q1 --> [1], q2.
q2 --> [0], q3.
q2 --> [1], q3.
q3 --> [].

numeral(0).
numeral(succ(X)) :- numeral(X).

l3(X,Y) :- p0(Y,X,[]).
p0(succ(Y)) --> [0], p0(Y).
p0(succ(Y)) --> [1], p0(Y).
p0(succ(Y)) --> [1], p1(Y).
p1(succ(Y)) --> [0], p2(Y).
p1(succ(Y)) --> [1], p2(Y).
p2(succ(Y)) --> [0], p3(Y).
p2(succ(0)) --> [1], p3(0).
p3(0) --> [].



