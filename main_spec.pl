
:- include(main).
:- use_module(library(plspec)).

:- describe(main).

it("should parse arbitrary settings") :-
    string_to_list("settings key value\n", List),
    phrase(game, List),
    settings(key:Value),
    Value = "value".

it("should parse botid setting") :-
    string_to_list("settings your_botid 999\n", List),
    phrase(game, List),
    current_player(999).

:- end(main).
