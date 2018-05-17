
:- initialization main.

moves([left, right, up, down, pass]).

main :-
  moves(Moves),
  forall(
    between(1, 40, _),
    (
      sleep(0.200),
      random_member(Move, Moves),
      format("~p~n", [Move])
    )
  ).
