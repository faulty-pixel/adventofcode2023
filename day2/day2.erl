-module(day2).
-export([
         part1/1
        ]).

readfile(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").

part1(FileName) ->
	Lines = readfile(FileName),
	Games = [parse(Line) || "Game " ++ Line <- Lines],
	lists:sum(get_valid(Games)).

parse(Line) -> [N, S] = string:tokens(Line, ":"),
	       {G, Subsets} = {to_num(N),string:tokens(S, ";")},
	       {G,[bla(Subset) || Subset <- Subsets]}.

bla(Nthos) -> [paapa(N) || N <- string:tokens(Nthos, ",")].

paapa(N) ->
	case string:reverse(N) of
		"der " ++ R -> {r, to_num(string:reverse(R))};
		"neerg " ++ G -> {g, to_num(string:reverse(G))};
		"eulb " ++ B -> {b, to_num(string:reverse(B))}
	end.

to_num(N) -> list_to_integer(string:strip(N)).

get_valid([]) -> ok;
get_valid(Games) -> get_valid([], Games).
get_valid(Valids, []) -> Valids;
get_valid(Valids, [{G, Subsets} | T]) ->
	case lists:any(fun invalid_subset/1, Subsets) of
		false -> get_valid(Valids ++ [G], T);
		true -> get_valid(Valids, T)
	end.

invalid_subset(Subset) ->lists:any(fun check/1, Subset).

check({r, R}) when R > 12 -> true;
check({g, G}) when G > 13 -> true;
check({b, B}) when B > 14 -> true;
check(_) -> false.


