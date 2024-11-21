% ---------------------------------List Product--------------------------------

list_prod([], 0).

list_prod([X], X) :- X \= 0.

list_prod([0|_], 0).  % If any element is 0, the product is 0.
list_prod([X|Rest], Product) :-
    list_prod(Rest, RestProduct),
    Product is X * RestProduct.

% ---------------------------------isPrime--------------------------------------

% Helper predicate to check if a number X is divisible by Y
divisible(X, Y) :-
    0 is X mod Y.

% 0 and 1 are not prime numbers
is_prime(0) :- false.
is_prime(1) :- false.

% 2 is a prime number
is_prime(2) :- true.

%Check if N is not divisible by any number from 2 to sqrt(N)
is_prime(N) :-
    N > 2,
    \+ has_divisor(N, 2).

% Helper predicate to check for divisors from the current number to sqrt(N)
has_divisor(N, Current) :-
    Current * Current =< N,    
    divisible(N, Current).

has_divisor(N, Current) :-
    Current * Current =< N,
    Next is Current + 1,
    has_divisor(N, Next).

% ---------------------------------Second Minimum--------------------------------

% check if an element is a number
is_number(X) :- number(X).

% remove duplicates from a list
remove_duplicates([], []).
remove_duplicates([H|T], Result) :-
    member(H, T),
    remove_duplicates(T, Result).
remove_duplicates([H|T], [H|Result]) :-
    \+ member(H, T),
    remove_duplicates(T, Result).

% find the minimum in a list
min_in_list([Min], Min).
min_in_list([H|T], Min) :-
    min_in_list(T, TempMin),
    Min is min(H, TempMin).

%find the second minimum
secondMin(List, Min2) :-
    (member(X, List), \+ is_number(X) ->
        writeln(['ERROR:', X, 'is not a number.']), fail
    ;
        % Remove duplicates from the list
        remove_duplicates(List, UniqueList),
        % Check if the list has fewer than two unique elements
        (length(UniqueList, Length), Length < 2 ->
            writeln('ERROR: List has fewer than two unique elements.'), fail
        ;
            % Otherwise, proceed to find the second minimum
            min_in_list(UniqueList, Min1),
            select(Min1, UniqueList, Rest),
            min_in_list(Rest, Min2)
        )
    ).

% ---------------------------------Classify--------------------------------

% Predicate to check if a number is even
even(X) :- 
    0 is X mod 2.

classify(_, [], [], []).

classify(Pred, [H|T], [H|List1], List2) :-
    call(Pred, H),          % If H satisfies Pred, add H to List1
    classify(Pred, T, List1, List2).

classify(Pred, [H|T], List1, [H|List2]) :-
    \+ call(Pred, H),       % If H does not satisfy Pred, add H to List2
    classify(Pred, T, List1, List2).

% ---------------------------------Bookends--------------------------------

% check if Prefix is a prefix of List3 and Suffix is a suffix of List3
bookends(Prefix, Suffix, List3) :-
    % Check if Prefix is a prefix of List3
    append(Prefix, _, List3),
    % Check if Suffix is a suffix of List3
    append(_, Suffix, List3).

% ---------------------------------Subslice---------------------------------

% subslice/2: Check if Sub is a contiguous subsequence of List
subslice([], _).
subslice(Sub, List) :-
    append(_, SubSuffix, List),
    append(Sub, _, SubSuffix). 

% ---------------------------------Rotate---------------------------------

% calculate positive effective shift regardless of sign and list length
effective_shift(InputList, N, Shift) :-
    length(InputList, Len),
    TempShift is N mod Len,
    Shift is (TempShift + Len) mod Len.

rotate(InputList, N, RotatedList) :-
    effective_shift(InputList, N, Shift),
    length(Prefix, Shift),      
    append(Prefix, Suffix, InputList),
    append(Suffix, Prefix, RotatedList).

% ---------------------------------Luhn Algorithm---------------------------------
luhn(Number) :-
    number_codes(Number, DigitsCodes),
    maplist(code_to_digit, DigitsCodes, Digits),
    reverse(Digits, Reversed), 
    double_alternate(Reversed, 1, Doubled),
    sum_digits(Doubled, Sum),
    Sum mod 10 =:= 0.

code_to_digit(Code, Digit) :-
    Digit is Code - 48.

double_alternate([], _, []).
double_alternate([H|T], Pos, [D|DoubledTail]) :-
    (   Pos mod 2 =:= 0 ->  
    	Temp is H * 2,
        (   Temp > 9 ->  D is Temp - 9 ; D = Temp )
    ;    D = H
    ),
    Pos1 is Pos + 1,
    double_alternate(T, Pos1, DoubledTail).

sum_digits([], 0).
sum_digits([H|T], Total) :-
    sum_digits(T, RestSum),
    Total is H + RestSum.

% ---------------------------------Zebra Puzzle---------------------------------

% Helper predicates

immediately_right_of(A, B, List) :-
    append(_, [B, A | _], List).

next_to(A, B, List) :-
    immediately_right_of(A, B, List);
    immediately_right_of(B, A, List).

% Zebra Puzzle Solution
zebra_puzzle(Houses) :-
    Houses = [
        house(norwegian, _, _, _, _),  % Norwegian lives in the first house (Rule 9)
        _, _, _, _,
        house(_, _, milk, _, _)        % Milk is drunk in the middle house (Rule 8)
    ],

    % There are five houses (already represented as a list of length 5)

    % Rule 2: The Englishman lives in the red house.
    member(house(englishman, red, _, _, _), Houses),

    % Rule 3: The Spaniard owns the dog.
    member(house(spaniard, _, _, _, dog), Houses),

    % Rule 4: Coffee is drunk in the green house.
    member(house(_, green, coffee, _, _), Houses),

    % Rule 5: The Ukrainian drinks tea.
    member(house(ukrainian, _, tea, _, _), Houses),

    % Rule 6: The green house is immediately to the right of the ivory house.
    immediately_right_of(house(_, green, _, _, _), house(_, ivory, _, _, _), Houses),

    % Rule 7: The Old Gold smoker owns snails.
    member(house(_, _, _, old_gold, snails), Houses),

    % Rule 10: Kools are smoked in the yellow house.
    member(house(_, yellow, _, kools, _), Houses),

    % Rule 11: The man who smokes Chesterfields lives in the house next to the man with the fox.
    next_to(house(_, _, _, chesterfields, _), house(_, _, _, _, fox), Houses),

    % Rule 12: Kools are smoked in the house next to the house where the horse is kept.
    next_to(house(_, _, _, kools, _), house(_, _, _, _, horse), Houses),

    % Rule 13: The Lucky Strike smoker drinks orange juice.
    member(house(_, _, orange_juice, lucky_strike, _), Houses),

    % Rule 14: The Japanese smokes Parliaments.
    member(house(japanese, _, _, parliaments, _), Houses),

    % Rule 15: The Norwegian lives next to the blue house.
    next_to(house(norwegian, _, _, _, _), house(_, blue, _, _, _), Houses).

% Queries

% Determine which house is associated with the color black.
black(HouseNumber) :-
    zebra_puzzle(Houses),
    nth0(HouseNumber, Houses, house(_, black, _, _, _)).

% Determine which house belongs to Denmark.
denmark(HouseNumber) :-
    zebra_puzzle(Houses),
    nth0(HouseNumber, Houses, house(denmark, _, _, _, _)).
