-module(day1).
-export([
    part1/1
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
