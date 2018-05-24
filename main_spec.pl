
:- include(main).
:- use_module(library(plspec)).

game_phrase(String) :-
    string_to_list(String, List),
    phrase(game, List).

:- describe(main).

it("should not fail on unrecognized lines") :-
    game_phrase("settings invalid\nupdate invalid\action invalid\n").

it("should parse botid setting") :-
    game_phrase("settings your_botid 999\n"),
    current_player(999).

it("should parse field updates") :-
    game_phrase("update game field xxxx\n"),
    current_field([120, 120, 120, 120]).

it("should not keep multiple current_field/1") :-
    game_phrase("update game field xxxx\n"),
    game_phrase("update game field yyyy\n"),
    aggregate(count, Field, current_field(Field), 1).

it("should parse round updates") :-
    game_phrase("update game round 1\n"),
    current_round(1).

it("should not keep multiple current_round/1") :-
    game_phrase("update game round 1\n"),
    game_phrase("update game round 2\n"),
    aggregate(count, Round, current_round(Round), 1).

:- end(main).
