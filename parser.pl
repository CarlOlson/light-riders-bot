
:- use_module(library(dcg/basics)).

game --> commands, eos.

commands --> command, nl, commands.
commands --> command, nl.
commands --> string_without("\n", _), nl.

command --> settings.
command --> update.
command --> move.

settings --> "settings your_botid ", integer(Id),
	     {
		 visit_settings(your_botid, Id)
	     }.

update --> "update game field ", string(Field),
           {
	       visit_update(field, Field)
	   }.

update --> "update game round ", integer(Round),
           {
	       visit_update(round, Round)
	   }.

move --> "action move ", integer(Time),
         {
	     visit_move(Time)
	 }.

nl --> "\n".
