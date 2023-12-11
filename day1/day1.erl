-module(day1).
-export([
    part1/1,
    part2/1
]).

readfile(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").

part1(FileName) ->
    Lines = readfile(FileName),
    Numbers = [number(filter_digits(Line)) || Line <- Lines],
    Sum = lists:sum(Numbers),
    io:format("~p~n", [Sum]).

filter_digits(Line) -> [X || X <- Line, X >= 48, X < 58].

% gets the required number from list of digits
number([H | T]) when T =/= [] ->
    [R | _] = lists:reverse(T),
    {N, _} = string:to_integer([H, R]),
    N;
number([H]) ->
    {N, _} = string:to_integer([H, H]),
    N.

part2(FileName) ->
    Lines = readfile(FileName),
    Numbers = [filter_digits_pro(Line) || Line <- Lines],
    Sum = lists:sum(Numbers),
    io:format("~p~n", [Sum]).

filter_digits_pro(Line) ->
    {FNo, ok} = first_number(Line),
    {LNo, ok} = last_number(lists:reverse(Line)),
    FNo * 10 + LNo.

first_number([X | _]) when X >= 48, X < 58 -> {X - 48, ok};
first_number("one" ++ _) -> {1, ok};
first_number("two" ++ _) -> {2, ok};
first_number("three" ++ _) -> {3, ok};
first_number("four" ++ _) -> {4, ok};
first_number("five" ++ _) -> {5, ok};
first_number("six" ++ _) -> {6, ok};
first_number("seven" ++ _) -> {7, ok};
first_number("eight" ++ _) -> {8, ok};
first_number("nine" ++ _) -> {9, ok};
first_number([_ | T]) -> first_number(T).

last_number([X | _]) when X >= 48, X < 58 -> {X - 48, ok};
last_number("eno" ++ _) -> {1, ok};
last_number("owt" ++ _) -> {2, ok};
last_number("eerht" ++ _) -> {3, ok};
last_number("ruof" ++ _) -> {4, ok};
last_number("evif" ++ _) -> {5, ok};
last_number("xis" ++ _) -> {6, ok};
last_number("neves" ++ _) -> {7, ok};
last_number("thgie" ++ _) -> {8, ok};
last_number("enin" ++ _) -> {9, ok};
last_number([_ | T]) -> last_number(T).
