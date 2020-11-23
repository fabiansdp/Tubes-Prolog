:- include('fixedmap.pl').

w :-
    player_position(_,Y),
    Y is 1, write('duar tembok'), nl, !.

w :-
    player_position(X,Y),
    Y2 is Y-1,
    is_obstacle(X,Y2),
    write('nabrak euy, tiati bang'), nl, !.
    
w :-
    player_position(X,Y),
    Y2 is Y-1,
    is_fence(X,Y2),
    write('duar pager'), nl, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('ada musuh bos'), nl, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your majesty, there is a quest for you'), nl, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('waw ada harta karun'), nl, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('dziingg, teleport nih'), nl,
    teleport,
    print_all, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('wah ada toko nih, bang beli bang!'), nl, !.
    
w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your Majesty, the dungeon boss ahead!'), nl, !.

w :-
    player_position(X,Y),
    map_height(YY),
    Y < YY+1,
    Y2 is Y-1,
    X2 is X,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    print_all, !.

a :-
    player_position(X,_),
    X is 1, write('duar tembok'), nl, !.

a :-
    player_position(X,Y),
    X2 is X-1,
    is_obstacle(X2,Y), 
    write('nabrak euy, tiati bang'), nl, !.

a :-
    player_position(X,Y),
    X2 is X-1,
    is_fence(X2,Y), 
    write('duar pager'), nl, !.
    
a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('ada musuh bos'), nl, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your majesty, there is a quest for you'), nl, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('waw ada harta karun'), nl, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('dziingg, teleport nih'), nl,
    teleport,
    print_all, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_shop(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('wah ada toko nih, bang beli bang!'), nl, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    is_boss(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your Majesty, the dungeon boss ahead!'), nl, !.

a :-
    player_position(X,Y),
    map_width(XX),
    X < XX+1,
    X2 is X-1,
    Y2 is Y,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    print_all, !.

s :-
    player_position(_,Y),
    map_height(YY),
    Y is YY, write('duar tembok'), nl, !.

s :-
    player_position(X,Y),
    Y2 is Y+1,
    is_obstacle(X,Y2), 
    write('nabrak euy, tiati bang'), nl, !.
    
s :-
    player_position(X,Y),
    Y2 is Y+1,
    is_fence(X,Y2), 
    write('duar pager'), nl, !.

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
    write('Your Majesty, the dungeon boss ahead!'), nl, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('ada musuh bos'), nl, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your majesty, there is a quest for you'), nl, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('waw ada harta karun'), nl, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('dziingg, teleport nih'), nl,
    teleport,
    print_all, !.

s :-
    player_position(X,Y),
    Y > 0,
    Y2 is Y+1,
    X2 is X,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    print_all, !.

d :-
    player_position(X,_),
    map_width(XX),
    X is XX, write('duar tembok'), nl, !.

d :-
    player_position(X,Y),
    X2 is X+1,
    is_obstacle(X2,Y), 
    write('nabrak euy, tiati bang'), nl, !.

d :-
    player_position(X,Y),
    X2 is X+1,
    is_fence(X2,Y), 
    write('duar pager'), nl, !.

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
    write('Your Majesty, the dungeon boss ahead!'), nl, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_enemy(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('ada musuh bos'), nl, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_quest(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('Your majesty, there is a quest for you'), nl, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_treasure(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('waw ada harta karun'), nl, !.

d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    is_gate(X2,Y2),
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    write('dziingg, teleport nih'), nl,
    teleport,
    print_all, !.
    
d :-
    player_position(X,Y),
    X > 0,
    X2 is X+1,
    Y2 is Y,
    retract(player_position(X,Y)),
    asserta(player_position(X2,Y2)),
    print_all, !.


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