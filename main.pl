
:- include(parser).

:- use_module(library(pio)).

:- dynamic current_player/1.
:- dynamic current_field/1.
:- dynamic current_round/1.

visit_settings(your_botid, Id) :-
    asserta(current_player(Id)).

visit_update(round, Round) :-
    retractall(current_round(_)),
    asserta(current_round(Round)).

visit_update(field, Field) :-
    retractall(current_field(_)),
    asserta(current_field(Field)).

visit_move(_Time) :-
    moves(Moves),
    random_member(Move, Moves),
    format("~p~n", [Move]).

moves([left, right, up, down]).

main :-
  phrase_from_stream(game, current_input).
