% 2 lists => which one is the list with the most elements?

length_list([], 0).
length_list([_ | Xs], N) :-
    length(Xs, N1),
    N is N1 + 1.

longest_list(L1, L2, L1) :-
    length(L1, N1),
    length(L2, N2),
    N1 >= N2.
longest_list(L1, L2, L2) :-
    length(L1, N1),
    length(L2, N2),
    N1 < N2.

% 1 list => list with the elements on even positions

drop_even_positions([], _, []).
drop_even_positions([X | Xs], CurrentIndex, [X | Rs]) :-
    CurrentIndex mod 2 =:= 0,
    NewCurrentIndex is CurrentIndex + 1,
    drop_even_positions(Xs, NewCurrentIndex, Rs).
drop_even_positions([_ | Xs], CurrentIndex, Rs) :-
    NewCurrentIndex is CurrentIndex + 1,
    drop_even_positions(Xs, NewCurrentIndex, Rs).

% 1 list, x, y => check if x and y are consecutive elements of the list

are_consecutive([Y, X | _], X, Y).
are_consecutive([X, Y | _], X, Y).
are_consecutive([_ | Xs], X, Y) :-
    are_consecutive(Xs, X, Y).

% 1 list => check if the list can be considered as a set

is_in(X, [X | _]).
is_in(X, [_ | Xs]) :-
    is_in(X, Xs).

is_set([]).
is_set([X | Xs]) :-
    not(member(X, Xs)),
    is_set(Xs).

% 1 list => turn a list into a set

% unordered set
make_set([], []).
make_set([X | Xs], [X | Rs]) :-
    not(member(X, Xs)),
    make_set(Xs, Rs).
make_set([_ | Xs], Rs) :-
    make_set(Xs, Rs).

% quick sort
sort_list(List, Sorted) :- 
    q_sort(List, [], Sorted).

q_sort([], Acc, Acc).
q_sort([X | Xs], Acc, Sorted):-
    pivoting(X, Xs, L1, L2),
    % greater than the pivot
    q_sort(L2, Acc, Sorted1),
    % lesser than the pivot
    q_sort(L1, [X | Sorted1], Sorted).

% detach elements in corresponding lists of
% smaller and greater than the pivot
pivoting(_, [], [], []).
% attach to the list with lesser elements
pivoting(H, [X | T], [X | L], G):-
    X =< H,
    pivoting(H, T, L, G).
% attach to the list with greater elements
pivoting(H, [X | T], L, [X | G]):-
    X > H,
    pivoting(H, T, L, G).

% ordered set
make_ordered_set(L, Sorted) :-
    make_set(L, L1),
    sort_list(L1, Sorted).

% 2 lists => check if the first is a prefix of the second

is_prefix([], _).
is_prefix([X | Xs], [X | Ys]) :-
    is_prefix(Xs, Ys).

% 2 lists => check if the first is a suffix of the second

is_suffix(L, L).
is_suffix(L1, [_ | L2]) :-
    is_suffix(L1, L2).

% 2 lists => check if the first is a sublist of the second

is_sublist(L1, L2) :-
    is_prefix(L, L2),
    is_suffix(L1, L).

% 2 lists => scalar product of the two lists

scalar_product(L1, L2, Result) :-
    length(L1, N1),
    length(L2, N2),
    N1 = N2,
    compute_scalar_product(L1, L2, Result).

compute_scalar_product([], [], 0).
compute_scalar_product([X | Xs], [Y | Ys], Result) :-
    compute_scalar_product(Xs, Ys, Result1),
    Result is X * Y + Result1.
