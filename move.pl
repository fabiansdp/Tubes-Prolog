w :-
    \+ enginestats(1),
    write('Mulai sek mas'), nl,
    game, !.

w :-
    player_position(_,Y),
    Y is 1, write('Duar tembok'), nl,
    game, !.

w :-
    player_position(X,Y),
    Y2 is Y-1,
    is_obstacle(X,Y2),
    write('Nabrak euy, tiati bang'), nl,
    game, !.
    
w :-
    player_position(X,Y),
    Y2 is Y-1,
    is_fence(X,Y2),
    write('Duar pager'), nl,
    game, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Ada musuh bos'), nl,
    encounter, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your majesty, there is a quest for you'), nl,
    game, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Waw ada harta karun'), nl,
    game, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Dziingg, teleport nih'), nl,
    teleport,
    game, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Wah ada toko nih, bang beli bang!'), nl, !.
    
w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your Majesty, the dungeon boss ahead!'), nl,
    boss_fight, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    game, !.

a :-
    \+ enginestats(1),
    write('Mulai sek mas'), nl,
    game, !.

a :-
    player_position(X,_),
    X is 1, write('Duar tembok'), nl,
    game, !.

a :-
    player_position(X,Y),
    X2 is X-1,
    is_obstacle(X2,Y), 
    write('Nabrak euy, tiati bang'), nl,
    game, !.

a :-
    player_position(X,Y),
    X2 is X-1,
    is_fence(X2,Y), 
    write('Duar pager'), nl,
    game, !.
    
a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Ada musuh bos'), nl,
    encounter, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your majesty, there is a quest for you'), nl,
    game, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('waw ada harta karun'), nl,
    game, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Dziingg, teleport nih'), nl,
    teleport,
    game, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('wah ada toko nih, bang beli bang!'), nl,
    game, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your Majesty, the dungeon boss ahead!'), nl,
    boss_fight, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    game, !.

s :-
    \+ enginestats(1),
    write('Mulai sek mas'), nl,
    game, !.

s :-
    player_position(_,Y),
    map_height(YY),
    Y is YY, write('Duar tembok'), nl,
    game, !.

s :-
    player_position(X,Y),
    Y2 is Y+1,
    is_obstacle(X,Y2), 
    write('Nabrak euy, tiati bang'), nl,
    game, !.
    
s :-
    player_position(X,Y),
    Y2 is Y+1,
    is_fence(X,Y2), 
    write('Duar pager'), nl,
    game, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('wah ada toko nih, bang beli bang!'), nl, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your Majesty, the dungeon boss ahead!'), nl,
    boss_fight, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Ada musuh bos'), nl,
    encounter, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your majesty, there is a quest for you'), nl,
    game, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Waw ada harta karun'), nl,
    game, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Dziingg, teleport nih'), nl,
    teleport,
    game, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    game, !.

d :-
    \+ enginestats(1),
    write('Mulai sek mas'), nl,
    game, !.

d :-
    player_position(X,_),
    map_width(XX),
    X is XX, write('Duar tembok'), nl,
    game, !.

d :-
    player_position(X,Y),
    X2 is X+1,
    is_obstacle(X2,Y), 
    write('Nabrak euy, tiati bang'), nl,
    game, !.

d :-
    player_position(X,Y),
    X2 is X+1,
    is_fence(X2,Y), 
    write('Duar pager'), nl,
    game, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('wah ada toko nih, bang beli bang!'), nl, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your Majesty, the dungeon boss ahead!'), nl,
    boss_fight, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Ada musuh bos'), nl,
    encounter, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your majesty, there is a quest for you'), nl,
    game, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Waw ada harta karun'), nl,
    game, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Dziingg, teleport nih'), nl,
    teleport,
    game, !.
    
d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    game, !.


teleport :-
    player_position(X,Y),
    gate1_position(A,B),
    gate2_position(C,D),
    X =:= A, Y =:= B,
    retract(player_position(X,Y)),
    asserta(player_position(C,D)), !.

teleport :-
    player_position(X,Y),
    gate1_position(A,B),
    gate2_position(C,D),
    X =:= C, Y =:= D,
    retract(player_position(X,Y)),
    asserta(player_position(A,B)), !.

encounter :-
    player_position(_,Y),
    Y < 6, battle(1), !.

encounter :-
    player_position(_,Y),
    Y > 6, Y < 12, battle(2), !.

encounter :-
    player_position(_,Y),
    Y > 12, battle(3), !.

obtain_treasure :-
    treasure_status(1).
