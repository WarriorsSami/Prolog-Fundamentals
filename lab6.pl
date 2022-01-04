% check if C is divisor for N in prolog
isDivisor(N, C) :-
    N mod C =:= 0.

writeDivisor(N, C) :-
    isDivisor(N, C),
    write(C),
    write(' ').
writeDivisor(_, _).

% generate divisors of given number using recursive predicate in prolog
% and print them to the terminal in ascending order using isDivisor predicate
findDivisorsForN(N, N) :-
    write(N),
    write(' ').
findDivisorsForN(N, Curr) :-
    writeDivisor(N, Curr),
    Curr1 is Curr + 1,
    findDivisorsForN(N, Curr1).

% test if N has divisors other than 1 and itself
divisible(X, Y) :- 0 is X mod Y, !.
divisible(X, Y) :- X > Y + 1, divisible(X, Y + 1).

isPrime(2).
isPrime(X) :- X > 1, not(divisible(X, 2)).

writePrime(C) :-
    isPrime(C),
    write(C),
    write(' ').
writePrime(_).

findPrimesForN(N, N) :-
    writePrime(N).
findPrimesForN(N, Curr) :-
    writePrime(Curr),
    Curr1 is Curr + 1,
    findPrimesForN(N, Curr1).