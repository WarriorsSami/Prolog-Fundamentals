list_length([], 0).
list_length([_|Xs], L) :- list_length(Xs, N), L is N + 1.

accLen([_|T], A, L) :- Anew is A + 1, accLen(T, Anew, L).
accLen([], A, A).