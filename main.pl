
:- use_module(library(dcg/basics)).
:- use_module(library(pio)).

:- dynamic current_player/1.

game --> commands, eos.

commands --> command, "\n", commands.
commands --> command, "\n".

command --> settings.
command --> update.
command --> move.

settings --> "settings ", string(List), " ", value(Value),
	     {
		 atom_codes(Key, List),
		 visit_settings(Key, Value)
	     }.

update --> "update game field ", string(Field),
           { visit_update(field, Field) }.
update --> "update game round ", integer(Round),
           { visit_update(round, Round) }.

move --> "action move ", integer(Time),
         { visit_move(Time) }.

value(Value) --> integer(Value);
		 string(List), { string_to_list(Value, List) }.

visit_settings(your_botid, Id) :-
    asserta(current_player(Id)).
visit_settings(_, _).

moves([left, right, up, down]).

main :-
  phrase_from_stream(game, current_input).
