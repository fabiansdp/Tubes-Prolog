w :-
    \+ enginestats(1),
    write('The Game havent started yet, My Lord'), nl, !.

w :-
    battle_status(1),
    write('We are currently in battle, My Lord'), nl, !.

w :-
    player_position(_,Y),
    Y is 1, write('This is the end of the map, My Lord'), nl,
    game, !.

w :-
    player_position(X,Y),
    Y2 is Y-1,
    is_obstacle(X,Y2),
    write('You cant go that way, My Lord'), nl,
    game, !.
    
w :-
    player_position(X,Y),
    Y2 is Y-1,
    is_fence(X,Y2),
    write('There is a fence ahead, My Lord, cant go that way'), nl,
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
    write('My Lord, Enemies ahead!'), nl,
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
    write('My Lord, there is a quest for you'), nl,
    showquest,
    write('Write "takequest" to accept the quest'), !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    treasureQuest, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    teleportsigns, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Look, there is a shop!'), nl, shop, !.
    
w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('My Lord, the dungeon boss is ahead!'), nl,
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
    write('The Game havent started yet, My Lord'), nl, !.

a :-
    battle_status(1),
    write('We are currently in battle, My Lord'), nl, !.

a :-
    player_position(X,_),
    X is 1, write('This is the end of the map, My Lord'), nl,
    game, !.

a :-
    player_position(X,Y),
    X2 is X-1,
    is_obstacle(X2,Y), 
    write('You cant go that way, My Lord'), nl,
    game, !.

a :-
    player_position(X,Y),
    X2 is X-1,
    is_fence(X2,Y), 
    write('There is a fence ahead, My Lord, cant go that way'), nl,
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
    write('My Lord, Enemies ahead!'), nl,
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
    write('My Lord, there is a quest for you'), nl,
    showquest,
    write('Write "takequest" to accept the quest'), !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    treasureQuest, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    teleportsigns, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Look, there is a shop!'), nl, shop, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('My Lord, the dungeon boss is ahead!'), nl,
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
    write('The Game havent started yet, My Lord'), nl, !.

s :-
    battle_status(1),
    write('We are currently in battle, My Lord'), nl, !.

s :-
    player_position(_,Y),
    map_height(YY),
    Y is YY, write('This is the end of the map, My Lord'), nl,
    game, !.

s :-
    player_position(X,Y),
    Y2 is Y+1,
    is_obstacle(X,Y2), 
    write('You cant go that way, My Lord'), nl,
    game, !.
    
s :-
    player_position(X,Y),
    Y2 is Y+1,
    is_fence(X,Y2), 
    write('There is a fence ahead, My Lord, cant go that way'), nl,
    game, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Look, there is a shop!'), nl, shop, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('My Lord, the dungeon boss is ahead!'), nl,
    boss_fight, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('My Lord, Enemies ahead!'), nl,
    encounter, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('My Lord, there is a quest for you'), nl,
    showquest,
    write('Write "takequest" to accept the quest'), !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    treasureQuest, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    teleportsigns, !.

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
    write('The Game havent started yet, My Lord'), nl, !.

d :-
    battle_status(1),
    write('We are currently in battle, My Lord'), nl, !.

d :-
    player_position(X,_),
    map_width(XX),
    X is XX, write('This is the end of the map, My Lord'), nl,
    game, !.

d :-
    player_position(X,Y),
    X2 is X+1,
    is_obstacle(X2,Y), 
    write('You cant go that way, My Lord'), nl,
    game, !.

d :-
    player_position(X,Y),
    X2 is X+1,
    is_fence(X2,Y), 
    write('There is a fence ahead, My Lord, cant go that way'), nl,
    game, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Look, there is a shop!'), nl, shop, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('My Lord, the dungeon boss is ahead!'), nl,
    boss_fight, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('My Lord, Enemies ahead!'), nl,
    encounter, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('My Lord, there is a quest for you'), nl,
    showquest,
    write('Write "takequest" to accept the quest'), !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    treasureQuest, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    teleportsigns, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    game, !.

teleportsigns:-
    player_position(18,2),
    write('There is a teleport gate here'), nl,
    write('Write "teleport1" to teleport to zone 2 (middle zone)'), nl,
    write('Write "teleport2" to teleport to zone 3 (bottom zone)'), nl, !.

teleportsigns:-
    player_position(3,7),
    write('There is a teleport gate here'), nl,
    write('Write "teleport1" to teleport to zone 1 (upper zone)'), nl,
    write('Write "teleport2" to teleport to zone 3 (bottom zone)'), nl, !.

teleportsigns:-
    player_position(10,20),
    write('There is a teleport gate here'), nl,
    write('Write "teleport1" to teleport to zone 1 (upper zone)'), nl,
    write('Write "teleport2" to teleport to zone 2 (middle zone)'), nl, !.

teleport1 :-
    player_position(3,7),
    gate1_position(A,B),
    retract(player_position(_,_)),
    asserta(player_position(A,B)),
    write('Teleport gate succesfully activated!\n'),
    game, !.

teleport1 :-
    player_position(10,20),
    gate1_position(A,B),
    retract(player_position(_,_)),
    asserta(player_position(A,B)),
    write('Teleport gate succesfully activated!\n'),
    game, !.

teleport1 :-
    player_position(_,_),
    write('There is no teleport gate nearby or you are already in destination position\n'), !.

teleport2 :-
    player_position(18,2),
    gate2_position(A,B),
    retract(player_position(_,_)),
    asserta(player_position(A,B)),
    write('Teleport gate succesfully activated!\n'), 
    game, !.

teleport2 :-
    player_position(10,20),
    gate2_position(A,B),
    retract(player_position(_,_)),
    asserta(player_position(A,B)),
    write('Teleport gate succesfully activated!\n'), 
    game, !.

teleport2 :-
    player_position(_,_),
    write('There is no teleport gate nearby or you are already in destination position\n'), !.

teleport3 :-
    player_position(18,2),
    gate3_position(A,B),
    retract(player_position(_,_)),
    asserta(player_position(A,B)),
    write('Teleport gate succesfully activated!\n'),
    game, !.

teleport3 :-
    player_position(3,3),
    gate3_position(A,B),
    retract(player_position(_,_)),
    asserta(player_position(A,B)),
    write('Teleport gate succesfully activated!\n'),
    game, !.

teleport3 :-
    player_position(_,_),
    write('There is no teleport gate nearby or you are already in destination position\n'), !.

encounter :-
    player_position(_, Y),
    Y < 6, battle(1), !.

encounter :-
    player_position(_, Y),
    Y > 6, Y < 12, battle(2), !.

encounter :-
    player_position(_, Y),
    Y > 12, battle(3), !.

takequest :-
    player_position(2, 5),
    startquest(1), !.
takequest :-
    player_position(15, 1),
    startquest(2), !.
takequest :-
    player_position(1, 8),
    startquest(3), !.
takequest :-
    player_position(10, 11),
    startquest(4), !.
takequest :-
    player_position(1, 20),
    startquest(5), !.
takequest :-
    player_position(5, 13),
    startquest(6), !.
takequest :-
    player_position(_,_),
    write('There is no quest nearby, My Lord'), nl, !.

showquest :-
    player_position(2, 5),
    printquest(1), !.
showquest :-
    player_position(15, 1),
    printquest(2), !.
showquest :-
    player_position(1, 8),
    printquest(3), !.
showquest :-
    player_position(10, 11),
    printquest(4), !.
showquest :-
    player_position(1, 20),
    printquest(5), !.
showquest :-
    player_position(5, 13),
    printquest(6), !.

legend :-
    print_all,
    write('P = Player\n'),
    write('E = Enemy\n'),
    write('G = Teleport\n'),
    write('S = Shop\n'),
    write('D = Boss\n'),
    write('Q = Quest\n'),
    write('T = ?????\n'),
    write('What you want to do, My Lord?\n\n').