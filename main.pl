
:- use_module(library(dcg/basics)).
:- use_module(library(pio)).

game --> commands, eos.

commands --> command, commands.
commands --> command.

command --> settings.
command --> update.
command --> move.

settings --> "settings", string_without("\n", _), "\n".

update   --> "update", string_without("\n", _), "\n".

move     -->  "action move ", integer(_Time), "\n",
  {
    moves(Moves),
    random_member(Move, Moves),
    format("~p~n", [Move])
  }.

moves([left, right, up, down, pass]).

main :-
  phrase_from_stream(game, current_input).
