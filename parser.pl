
:- use_module(library(dcg/basics)).

game --> commands, eos.

commands --> command, nl, commands.
commands --> command, nl.

command --> settings.
command --> update.
command --> move.
command --> ("settings"; "update"; "action"), string_without("\n", _).

settings --> "settings your_botid ", integer(Id),
	     {
		 visit_settings(your_botid, Id)
	     }.

update --> "update game field ", string_without("\n", Field),
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
