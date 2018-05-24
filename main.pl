
:- include(parser).

:- use_module(library(pio)).

:- dynamic current_player/1.

visit_settings(your_botid, Id) :-
    asserta(current_player(Id)).

visit_update(round, _Round).

visit_move(_Time).

moves([left, right, up, down]).

main :-
  phrase_from_stream(game, current_input).
