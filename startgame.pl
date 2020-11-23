:- dynamic(enginestats/1).

:- include('player.pl').
:- include('battle.pl').
:- include('enemy.pl').
:- include('item.pl').
:- include('inventory.pl').
:- include('command.pl').

enginestats(0).

game :-
    enginestats(1),
    read_command.

game :-
    enginestats(0),
    write('The End\n\n').

start :-
    retract(enginestats(_)),
    asserta(enginestats(1)),
    write('SELAMAT DATANG!!'),nl,
    write('Masyarakat kami sudah bertahun-tahun takut dengan kekuatan Naga Hitam'),nl,
    write('Tolong bantulah kami untuk membasmi Naga Hitam!'), nl,nl,
    set_invent,
    player_init,
    read_command.

quit:-
    retractall(enginestats(_)),
    asserta(enginestats(0)),
    write('Terima kasih sudah bermain!'),nl,
    write('arigatouuu'),nl.