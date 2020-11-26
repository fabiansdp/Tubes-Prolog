:- dynamic(enginestats/1).

:- include('player.pl').
:- include('battle.pl').
:- include('enemy.pl').
:- include('item.pl').
:- include('inventory.pl').
:- include('command.pl').
:- include('map.pl').
:- include('move.pl').
:- include('store.pl').
:- include('quest.pl').

enginestats(0).

game :-
    enginestats(1),
    print_all,
    write('What you want to do, My Lord?\n'), nl,
    write('(Write "help" to show command list)\n'), !.

game :-
    enginestats(0),
    write('=======THE END=======\n\n').

start :-
    retract(enginestats(_)),
    asserta(enginestats(1)),
    asserta(battle_status(0)),
    write('=======WELCOME, WARRIOR!======='),nl,
    write('Our people have been terrorized by the Ancient Black Dragon for ages'),nl,
    write('Please, help us to slain the Dragon!'), nl,nl,
    quest_init,
    set_invent,
    map_init,
    player_init,
    game.

quit:-
    retractall(enginestats(_)),
    asserta(enginestats(0)),
    write('Thanks for playing!'),nl,
    write('arigatouuu'),nl.