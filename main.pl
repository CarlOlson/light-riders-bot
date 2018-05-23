
:- use_module(library(dcg/basics)).
:- use_module(library(pio)).

:- dynamic settings/1.

game --> commands, eos.

commands --> command, commands.
commands --> command.

command --> settings.
command --> update.
command --> move.

settings --> "settings ", string(List), " ", value(Value), "\n",
	     {
		 atom_codes(Key, List),
		 asserta(settings(Key:Value))
	     }.

update   --> "update", string_without("\n", _), "\n".

move     -->  "action move ", integer(_Time), "\n",
	      {
		  moves(Moves),
		  random_member(Move, Moves),
		  format("~p~n", [Move])
	      }.

value(Value) --> integer(Value);
		 string(List), { string_to_list(Value, List) }.

current_player(Id) :-
    settings(your_botid:Id).

moves([left, right, up, down, pass]).

main :-
  phrase_from_stream(game, current_input).
