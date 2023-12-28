-module(day2).
-export([
         part1/1
        ]).

readfile(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").

part1(FileName) ->
	Lines = readfile(FileName),
	[parse(Line) || "Game " ++ Line <- Lines].

parse(Line) -> [N | ": " ++ S] = Line,
	       {list_to_integer([N]),string:tokens(S, ";")}.
