:- dynamic(player/12). /* player(Level, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold) */

class(1, 'Swordsman').
class(2, 'Archer').
class(3, 'Magician').

set_class('Swordsman').
set_class('Archer').
set_class('Magician').

default_item('Swordsman', 'Beginner Sword').
default_item('Archer', 'Wooden Bow').
default_item('Magician', 'Magic Staff').

default_hp('Swordsman', 100, 100).
default_hp('Archer', 80, 80).
default_hp('Magician', 50, 50).

default_mana('Swordsman', 50, 50).
default_mana('Archer', 70, 70).
default_mana('Magician', 100, 100).

default_attack('Swordsman', 10).
default_attack('Archer', 15).
default_attack('Magician', 20).

default_defense('Swordsman', 20).
default_defense('Archer', 10).
default_defense('Magician', 5).

set_player(Class):-
    default_item(Class, Item),
    default_hp(Class, HP, MaxHP),
    default_mana(Class, Mana, MaxMana),
    default_attack(Class, Att),
    default_defense(Class, Def),
    asserta(player(1, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, 0, 10, 0)), !.

response_class(Class):-
    write('Kamu pilih '),
    write(Class),
    write(', misi kamu adalah mengalahkan naga!.'), nl, !.

player_init :-
    write('Pilih Kelas: '),nl,
    write('1. Swordsman '),nl,
    write('2. Archer '),nl,
    write('3. Magician '),nl,
    read(X), nl,
    class(X, Class),
    set_player(Class),
    response_class(Class).

set_maxhp('Swordsman', 30).
set_maxhp('Archer', 20).
set_maxhp('Magician', 10).

set_maxmana('Swordsman', 20).
set_maxmana('Archer', 30).
set_maxmana('Magician', 50).

set_att('Swordsman', 5).
set_att('Archer', 6).
set_att('Magician', 7).

set_def('Swordsman', 10).
set_def('Archer', 8).
set_def('Magician', 5).


/* Commands */

start:- player_init.

status:-
    player(Level, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold),
    write('Level: '), write(Level), nl,
    write('Class: '), write(Class), nl,
    write('Item: '), write(Item), nl,
    write('HP: '), write(HP), write('/'), write(MaxHP), nl,
    write('Mana: '), write(Mana), write('/'), write(MaxMana), nl,
    write('Attack: '), write(Att), nl,
    write('Defense: '), write(Def), nl,
    write('XP: '), write(XP), write('/'), write(BatasXP), nl,
    write('Gold: '), write(Gold), nl, !.

level_up :-
    player(Level, Class, Item, _, MaxHP, _, MaxMana, Att, Def, _, BatasXP, Gold),
    Levelup is Level + 1,
    BatasXP1 is BatasXP + round(BatasXP*0.4),
    set_maxhp(Class, Add_Max_HP),
    MaxHP1 is MaxHP + Add_Max_HP,
    set_maxmana(Class, Add_Max_Mana),
    MaxMana1 is MaxMana + Add_Max_Mana,
    set_att(Class, Add_Att),
    Att1 is Att + Add_Att,
    set_def(Class, Add_Def),
    Def1 is Def + Add_Def,
    asserta(player(Levelup, Class, Item, MaxHP1, MaxHP1, MaxMana1, MaxMana1, Att1, Def1, 0, BatasXP1, Gold)), !.

decr_hp(X) :-
    player(Level, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold),
    HP1 is HP - X,
    asserta(player(Level, Class, Item, HP1, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold)), !.

decr_mana(X) :-
    player(Level, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold),
    Mana1 is Mana - X,
    asserta(player(Level, Class, Item, HP, MaxHP, Mana1, MaxMana, Att, Def, XP, BatasXP, Gold)), !.

add_xp(X):-
    player(Level, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold),
    XP1 is XP + X,
    asserta(player(Level, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, XP1, BatasXP, Gold)), !.

add_gold(X):-
    player(Level, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold),
    Gold1 is Gold + X,
    asserta(player(Level, Class, Item, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold1)), !.

changeItem(NewItem):-
    player(Level, Class, _, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold),
    asserta(player(Level, Class, NewItem, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold)), !.