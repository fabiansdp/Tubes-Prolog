:- dynamic(player_position/2).

/* =============== */
%  GAMBAR MAP EUYY  %
/* =============== */
map_height(20).
map_width(20).
fence(15,6).
fence(2,12).
shop_position(15,2).
enemy(10,2).
enemy(5,5).
enemy(15,7).
enemy(4,7).
enemy(10,19).
enemy(17,15).
enemy(17,13).
boss_position(20,20).
gate1_position(3,7).
gate2_position(10,20).
quest_position(15,1).
quest_position(2,5).
quest_position(1,8).
quest_position(10,11).
quest_position(1,20).
quest_position(5,13).
obstacle1(4,4).
obstacle2(14,2).
obstacle3(3,8).
obstacle4(12,9).
obstacle5(19,14).
obstacle6(16,16).
obstacle7(4,15).
obstacle8(3,19).
treasure_position(20,13).

/* ============================ */
/* TAROK DULU PEMAIN DI POJOKAN */
/* ============================ */
map_init :-
    asserta(player_position(1,1)), !.


% ========================== %
% FUNGSI IS-IS GITU POKOKNYA %
% ========================== %
left_border(X,_) :- X =:= 0, !.

top_border(_,Y) :- Y =:= 0, !.

right_border(X,_) :-
    map_width(A),
    Xrigth is A+1,
    X =:= Xrigth, !.

bottom_border(_,Y) :-
    map_height(A),
    Ybot is A+1,
    Y =:= Ybot, !.

is_quest(X,Y) :-
    quest_position(A,B),
    X =:= A, Y =:= B, !.

is_shop(X,Y) :-
    shop_position(A,B),
    X =:= A, Y =:= B, !.

is_boss(X,Y) :-
    boss_position(A,B),
    X =:= A, Y =:= B, !.

is_gate(X,Y) :-
    gate1_position(A,B),
    X =:= A, Y =:= B, !.

is_gate(X,Y) :-
    gate2_position(A,B),
    X =:= A, Y =:= B, !.

is_fence(X,Y) :-
    fence(A,B),
    X =\= A, X =\= A-1,X =\= A+1, Y =:= B, !.

is_enemy(X,Y) :-
    enemy(A,B), X =:= A, Y =:= B, !.

is_treasure(X,Y) :-
    treasure_position(A,B), X =:= A, Y =:= B, !.

/* ========================== */
%  OBSTACLE 1 YA, BIAR CANTEQ  %
/* ========================== */
is_obstacle(X,Y) :-
    obstacle1(A,B), X =:= A, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle1(A,B), X =:= A-1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle1(A,B), X =:= A-2, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle1(A,B), X =:= A+1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle1(A,B), X =:= A+2, Y =:= B, !.

/* =========================== */
%  OBSTACLE 2 YA, BIAR GAMTENK  %
/* =========================== */
is_obstacle(X,Y) :-
    obstacle2(A,B), X =:= A, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle2(A,B), X =:= A, Y =:= B-1, !.
is_obstacle(X,Y) :-
    obstacle2(A,B), X =:= A, Y =:= B+1, !.
is_obstacle(X,Y) :-
    obstacle2(A,B), X =:= A, Y =:= B+2, !.
is_obstacle(X,Y) :-
    obstacle2(A,B), X =:= A+1, Y =:= B+2, !.

/* ============================== */
%  OBSTACLE 3 BUAT NYUDUTIN ORANG  %
/* ============================== */
is_obstacle(X,Y) :-
    obstacle3(A,B), X =:= A, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle3(A,B), X =:= A-1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle3(A,B), X =:= A+1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle3(A,B), X =:= A+2, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle3(A,B), X =:= A-1, Y =:= B+1, !.
is_obstacle(X,Y) :-
    obstacle3(A,B), X =:= A-1, Y =:= B+2, !.

/* ============================= */
%  OBSTACLE 4 YA, BIAR GA KOSONG  %
/* ============================= */
is_obstacle(X,Y) :-
    obstacle4(A,B), X =:= A, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle4(A,B), X =:= A-1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle4(A,B), X =:= A-2, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle4(A,B), X =:= A+1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle4(A,B), X =:= A+2, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle4(A,B), X =:= A, Y =:= B-1, !.
is_obstacle(X,Y) :-
    obstacle4(A,B), X =:= A, Y =:= B-2, !.

/* =========================== */
%  OBSTACLE 5 BUAT BIKIN JALUR  %
/* =========================== */
is_obstacle(X,Y) :-
    obstacle5(A,B), X =:= A, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle5(A,B), X =:= A-1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle5(A,B), X =:= A+1, Y =:= B, !.

/* =========================== */
%  OBSTACLE 6 BUAT BIKIN JALUR  %
/* =========================== */
is_obstacle(X,Y) :-
    obstacle6(A,B), X =:= A, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle6(A,B), X =:= A, Y =:= B-1, !.
is_obstacle(X,Y) :-
    obstacle6(A,B), X =:= A, Y =:= B-2, !.
is_obstacle(X,Y) :-
    obstacle6(A,B), X =:= A, Y =:= B-3, !.
is_obstacle(X,Y) :-
    obstacle6(A,B), X =:= A+1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle6(A,B), X =:= A+2, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle6(A,B), X =:= A+3, Y =:= B, !.

/* ============================= */
%  OBSTACLE 7 BUAT MOJOKIN ORANG  %
/* ============================= */
is_obstacle(X,Y) :-
    obstacle7(A,B), X =:= A, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle7(A,B), X =:= A, Y =:= B-1, !.
is_obstacle(X,Y) :-
    obstacle7(A,B), X =:= A, Y =:= B-2, !.
is_obstacle(X,Y) :-
    obstacle7(A,B), X =:= A, Y =:= B+1, !.
is_obstacle(X,Y) :-
    obstacle7(A,B), X =:= A+1, Y =:= B-1, !.
is_obstacle(X,Y) :-
    obstacle7(A,B), X =:= A+2, Y =:= B-1, !.
is_obstacle(X,Y) :-
    obstacle7(A,B), X =:= A+3, Y =:= B-1, !.
is_obstacle(X,Y) :-
    obstacle7(A,B), X =:= A+4, Y =:= B-1, !.

/* ============================= */
%  OBSTACLE 8 BUAT MOJOKIN ORANG  %
/* ============================= */
is_obstacle(X,Y) :-
    obstacle8(A,B), X =:= A, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle8(A,B), X =:= A-1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle8(A,B), X =:= A-2, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle8(A,B), X =:= A+1, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle8(A,B), X =:= A+2, Y =:= B, !.
is_obstacle(X,Y) :-
    obstacle8(A,B), X =:= A+3, Y =:= B, !.



/* ================== */
/* GAMPET GAMBAR PETA */
/* ================== */
print_map(X,Y) :-
    player_position(X,Y), !, write('P').
print_map(X,Y) :-
    is_shop(X,Y), !, write('S').
print_map(X,Y) :-
    is_quest(X,Y), !, write('Q').
print_map(X,Y) :-
    is_boss(X,Y), !, write('D').
print_map(X,Y) :-
    is_gate(X,Y), !, write('G').
print_map(X,Y) :-
    is_enemy(X,Y), !, write('E').
print_map(X,Y) :-
    is_treasure(X,Y), !, write('T').
print_map(X,Y) :-
    is_obstacle(X,Y), !, write('#').
print_map(X,Y) :-
    top_border(X,Y), !, write('#').
print_map(X,Y) :-
    left_border(X,Y), !, write('#').
print_map(X,Y) :-
    right_border(X,Y), !, write('#').
print_map(X,Y) :-
    bottom_border(X,Y), !, write('#').
print_map(X,Y) :-
    is_fence(X,Y), !, write('#').
print_map(_,_) :-
	write('-').

print_all :-
    map_width(X), map_height(Y),
    XB is X+1, YB is Y+1,
    forall(between(0,YB,Yn),
        (forall(between(0,XB,Xn),
            print_map(Xn,Yn)
        ), nl)
    ), !.
