
:- include(main).
:- use_module(library(plspec)).

game_phrase(String) :-
    string_to_list(String, List),
    phrase(game, List).

assert_example_field :-
    example_field(Field),
    retractall(current_field(_)),
    asserta(current_field(Field)).

example_field(Field) :-
    Field = [
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", "0", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", "x", "x", "x", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", "x", ".", ".", "x", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", "1", "x", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", "x", "x", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
	".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."
    ].

:- describe(main).

it("should not fail on unrecognized lines") :-
    game_phrase("settings invalid\nupdate invalid\action invalid\n").

it("should parse botid setting") :-
    game_phrase("settings your_botid 999\n"),
    current_player(999).

it("should parse field updates") :-
    game_phrase("update game field x,x,x,x\n"),
    current_field(["x", "x", "x", "x"]).

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

it("should calculate current player position") :-
    assert_example_field,

    retractall(current_player(_)),
    asserta(current_player(0)),
    current_position(6:4),

    retractall(current_player(_)),
    asserta(current_player(1)),
    current_position(9:8).

:- end(main).
