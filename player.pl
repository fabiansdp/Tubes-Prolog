:- dynamic(player_lvl/1).   /* player_lvl(Level) */
:- dynamic(player_weapon/1).  /* player_weapon(weapon) */
:- dynamic(player_armor/1).  /* player_armor(armor) */
:- dynamic(player_hp/2).    /* player_hp(HP, MaxHP) */
:- dynamic(player_mana/2).  /* player_mana(Mana, MaxMana) */
:- dynamic(player_att/1).   /* player_att(Att) */
:- dynamic(player_def/1).   /* player_def(Def) */
:- dynamic(xp/2).           /* xp(XP, BatasXP) */
:- dynamic(gold/1).         /* gold(Gold) */

/* Fakta-fakta */
class(1, 'Swordsman').
class(2, 'Archer').
class(3, 'Magician').

/* Special Skill setiap class (class, namaskill) */
special_skill('Swordsman', 'Rage').
special_skill('Archer', 'Power Shot').
special_skill('Magician', 'Divine Light').

/* Default Weapon */
default_weapon('Swordsman', 'Beginner Sword').
default_weapon('Archer', 'Wooden Bow').
default_weapon('Magician', 'Magic Staff').

/* Default Armor */
default_armor('Swordsman', 'Beginner Armor').
default_armor('Archer', 'Beginner Cloth').
default_armor('Magician', 'Beginner Robe').

/* HP Default */
default_hp('Swordsman', 100, 100).
default_hp('Archer', 80, 80).
default_hp('Magician', 50, 50).

/* Pertambahan hp setiap level */
add_maxhp('Swordsman', 30).
add_maxhp('Archer', 20).
add_maxhp('Magician', 10).

/* Mana Default */
default_mana('Swordsman', 50, 50).
default_mana('Archer', 70, 70).
default_mana('Magician', 100, 100).

/* Pertambahan mana setiap level */
add_maxmana('Swordsman', 20).
add_maxmana('Archer', 30).
add_maxmana('Magician', 50).

/* Attack Default */
default_attack('Swordsman', 10).
default_attack('Archer', 15).
default_attack('Magician', 20).

add_att('Swordsman', 5).
add_att('Archer', 6).
add_att('Magician', 7).

/* Defense Default */
default_defense('Swordsman', 20).
default_defense('Archer', 10).
default_defense('Magician', 5).

/* Pertambahan defense setiap level */
add_def('Swordsman', 10).
add_def('Archer', 8).
add_def('Magician', 5).

/* Fungsi untuk set default stat pemain */
set_class(Class):-
    asserta(player_class(Class)), !.

set_lvl:-
    asserta(player_lvl(1)), !.

set_default_item(Class):-
    default_weapon(Class, Weapon),
    default_armor(Class, Armor),
    asserta(player_weapon(Weapon)),
    asserta(player_armor(Armor)), !.

set_hp(Class):-
    default_hp(Class, HP, MaxHP),
    asserta(player_hp(HP,MaxHP)), !.

set_mana(Class):-
    default_mana(Class, Mana, MaxMana),
    asserta(player_mana(Mana, MaxMana)), !.

set_att(Class):-
    default_attack(Class, Att),
    asserta(player_att(Att)), !.

set_def(Class):-
    default_defense(Class, Def),
    asserta(player_def(Def)), !.

set_xp:-
    asserta(xp(0,10)), !.

set_gold:-
    asserta(gold(0)), !.

set_player(Class):-
    set_class(Class),
    set_lvl,
    set_default_item(Class),
    set_hp(Class),
    set_mana(Class),
    set_att(Class),
    set_def(Class),
    set_xp,
    set_gold, !.

/* Membaca stat player */
player(Level, Class, Weapon, Armor, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold) :-
    player_class(Class),
    player_lvl(Level),
    player_weapon(Weapon),
    player_armor(Armor),
    player_hp(HP, MaxHP),
    player_mana(Mana, MaxMana),
    player_att(Att),
    player_def(Def),
    xp(XP, BatasXP),
    gold(Gold), !.

response_class(Class):-
    write('Kamu pilih '),
    write(Class),
    write(', misi kamu adalah mengalahkan naga!.'), nl, !.

/* Inisialisasi Player */
player_init :-
    write('Pilih Kelas: '),nl,
    write('1. Swordsman '),nl,
    write('2. Archer '),nl,
    write('3. Magician '),nl,
    read(X), nl,
    class(X, Class),
    set_player(Class),
    response_class(Class).


/* Commands */
status:-
    player(Level, Class, Weapon, Armor, HP, MaxHP, Mana, MaxMana, Att, Def, XP, BatasXP, Gold),
    write('Level: '), write(Level), nl,
    write('Class: '), write(Class), nl,
    write('Weapon: '), write(Weapon), nl,
    write('Armor: '), write(Armor), nl,
    write('HP: '), write(HP), write('/'), write(MaxHP), nl,
    write('Mana: '), write(Mana), write('/'), write(MaxMana), nl,
    write('Attack: '), write(Att), nl,
    write('Defense: '), write(Def), nl,
    write('XP: '), write(XP), write('/'), write(BatasXP), nl,
    write('Gold: '), write(Gold), nl, !.

write_xp :-
    xp(XP, BatasXP),
    write('XP: '), write(XP), write('/'), write(BatasXP), !.

level_up :-
    player(Level, _, _, _, _, MaxHP, _, MaxMana, Att, Def, XP, BatasXP, _),
    Levelup is Level + 1,
    XP1 is XP - BatasXP,
    BatasXP1 is BatasXP + round(BatasXP*0.2),
    add_maxhp(Class, Add_Max_HP),
    MaxHP1 is MaxHP + Add_Max_HP,
    add_maxmana(Class, Add_Max_Mana),
    MaxMana1 is MaxMana + Add_Max_Mana,
    add_att(Class, Add_Att),
    Att1 is Att + Add_Att,
    add_def(Class, Add_Def),
    Def1 is Def + Add_Def,
    asserta(player_lvl(Levelup)),
    asserta(player_hp(MaxHP1, MaxHP1)),
    asserta(player_mana(MaxMana1, MaxMana1)),
    asserta(player_att(Att1)),
    asserta(player_def(Def1)),
    asserta(xp(XP1, BatasXP1)),
    write('Selamat Anda naik ke level '), write(Levelup), nl,
    write_xp, !.

/* Operasi terhadap stat pemain */
check_dead :-
    player_hp(HP, _),
    HP =< 0,
    write('Kamu mati!'), nl.

decr_hp(X) :-
    player_hp(HP, MaxHP),
    HP1 is HP - X,
    asserta(player_hp(HP1, MaxHP)), 
    check_dead, !.

decr_mana(X) :-
    player_mana(Mana, MaxMana),
    \+ Mana = 0,
    Mana1 is Mana - X,
    asserta(player_mana(Mana1, MaxMana)), !.

check_levelup:-
    xp(XP, BatasXP),
    (XP >= BatasXP -> level_up ; write_xp), !.

add_xp(X):-
    xp(XP, BatasXP),
    XP1 is XP + X,
    asserta(xp(XP1, BatasXP)),
    check_levelup, !.

add_gold(X):-
    gold(Gold),
    Gold1 is Gold + X,
    asserta(gold(Gold1)), !.