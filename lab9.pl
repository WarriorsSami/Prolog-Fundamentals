% 2 ordered lists => merge them into one list

merge([], L, L).
merge(L, [], L).
merge([H1 | T1], [H2 | T2], [H1 | T]) :-
    H1 =< H2,
    merge(T1, [H2 | T2], T).
merge([H1 | T1], [H2 | T2], [H2 | T]) :-
    H1 >= H2,
    merge([H1 | T1], T2, T).

% 1 list => split it into two lists: one of odd numbers, one of even numbers

split_value([], [], []).
split_value([H | T], [H | T1], T2) :-
    0 is H mod 2,
    split_value(T, T1, T2).
split_value([H | T], T1, [H | T2]) :-
    1 is H mod 2,
    split_value(T, T1, T2).

% 1 list => split it into two lists: one of numbers from even positions, one of numbers from odd positions

split_position([], _, [], []).
split_position([H | T], Count, [H | T1], T2) :-
    0 is Count mod 2,
    NewCount is Count + 1,
    split_position(T, NewCount, T1, T2).
split_position([H | T], Count, T1, [H | T2]) :-
    1 is Count mod 2,
    NewCount is Count + 1,
    split_position(T, NewCount, T1, T2).

% 1 value, 1 list => append the value to the list

last_append([], X, [X]).
last_append([H | T], X, [H | T1]) :-
    last_append(T, X, T1).

% 1 position, 1 list => return the value at the position in the list

get_value(0, [H | _], H).
get_value(N, [_ | T], X) :-
    N > 0,
    NewN is N - 1,
    get_value(NewN, T, X).

% 1 value, 1 list => return the position of the value in the list

get_position(X, [X | _], 0).
get_position(X, [_ | T], N) :-
    get_position(X, T, NewN),
    N is NewN + 1.

% generate list of prime numbers until given value

:- [lab6].

generate_prime_list(N, N, [N]) :-
    isPrime(N).
generate_prime_list(N, N, []).
generate_prime_list(N, M, [N | T]) :-
    isPrime(N),
    N1 is N + 1,
    generate_prime_list(N1, M, T).
generate_prime_list(N, M, T) :-
    N1 is N + 1,
    generate_prime_list(N1, M, T).

generate_list(N, N, [N]).
generate_list(N, M, [N | T]) :-
    N1 is N + 1,
    generate_list(N1, M, T).

% 2 sets => union of the sets

:- [lab8].

make_union_util([], L, L).
make_union_util(L, [], L).
make_union_util([H1 | T1], [H2 | T2], [H1, H2 | T]) :-
    make_union_util(T1, T2, T).

make_union(L1, L2, L) :-
    make_union_util(L1, L2, Lt),
    sort_list(Lt, L).

% 2 sets => intersection of the sets

make_intersection_util([], _, []).
make_intersection_util([H1 | T1], L2, [H1 | T]) :-
    member(H1, L2),
    make_intersection_util(T1, L2, T).
make_intersection_util([_ | T1], L2, T) :-
    make_intersection_util(T1, L2, T).

make_intersection(L1, L2, L) :-
    make_intersection_util(L1, L2, Lt),
    sort_list(Lt, L).

% 2 sets => difference of the sets

make_difference_util([], _, []).
make_difference_util([H1 | T1], L2, [H1 | T]) :-
    not(member(H1, L2)),
    make_difference_util(T1, L2, T).
make_difference_util([_ | T1], L2, T) :-
    make_difference_util(T1, L2, T).

make_difference(L1, L2, L) :-
    make_difference_util(L1, L2, Lt),
    sort_list(Lt, L).
