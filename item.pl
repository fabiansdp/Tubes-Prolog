/* Untuk potion: Item(class, type, nama, harga, +effect) */
item(_, 'Potion', 'Red Potion', 15, 30).
item(_, 'Potion', 'Blue Potion', 15, 40).
item(_, 'Potion', 'Enrage Potion', 10, 30).
item(_, 'Potion', 'Defense Potion', 10, 20).

/* Item(class, type, nama, minlvl, +effect) */
item('Swordsman', 'Weapon', 'Beginner Sword', 0, 0).
item('Swordsman', 'Weapon', 'Great Sword', 5, 30).
item('Swordsman', 'Weapon', 'Sword of Light', 12, 50).
item('Swordsman', 'Weapon', 'Divine Sword', 20, 100).

item('Archer', 'Weapon', 'Wooden Bow', 0, 0).
item('Archer', 'Weapon', 'Sturdy Bow', 5, 30).
item('Archer', 'Weapon', 'Great Bow', 12, 50).
item('Archer', 'Weapon', 'Divine Bow', 20, 100).

item('Magician', 'Weapon', 'Magic Staff', 0, 0).
item('Magician', 'Weapon', 'Good Staff', 5, 30).
item('Magician', 'Weapon', 'Staff of Wisdom', 12, 50).
item('Magician', 'Weapon', 'Divine Staff', 20, 100).

item('Swordsman', 'Armor', 'Beginner Armor', 0, 0).
item('Swordsman', 'Armor', 'Great Armor', 5, 30).
item('Swordsman', 'Armor', 'Armor of Light', 12, 50).
item('Swordsman', 'Armor', 'Divine Armor', 20, 100).

item('Archer', 'Armor', 'Beginner Cloth', 0, 0).
item('Archer', 'Armor', 'Archer Cloth', 5, 30).
item('Archer', 'Armor', 'Cloth of Light', 12, 50).
item('Archer', 'Armor', 'Divine Cloth', 20, 100).

item('Magician', 'Armor', 'Beginner Robe', 0, 0).
item('Magician', 'Armor', 'Magician Robe', 5, 30).
item('Magician', 'Armor', 'Robe of Light', 12, 50).
item('Magician', 'Armor', 'Divine Robe', 20, 100).

/* Fungsi-fungsi Use Potion */
use_potion('Red Potion'):-
    \+itemInv('Red Potion', _),
    write('Tidak punya Red potion!\n'),
    battle_mechanism.

use_potion('Red Potion'):-
    itemInv('Red Potion', _),
    delItemInv('Red Potion'),
    player_hp(HP, MaxHP),
    HP1 is HP + 30,
    retract(player_hp(_,_)),
    retract(turn(_)),
    (HP1 > MaxHP -> 
        asserta(player_hp(MaxHP, MaxHP)), ! 
    ; 
        asserta(player_hp(HP1, MaxHP)), !
    ),
    asserta(turn(0)),
    write('Kamu memakai Red Potion\n\n').

use_potion('Blue Potion'):-
    \+itemInv('Blue Potion',_),
    write('Tidak punya Blue potion!\n'),
    battle_mechanism.

use_potion('Blue Potion'):-
    itemInv('Blue Potion',_),
    delItemInv('Blue Potion'),
    player_mana(Mana, MaxMana),
    Mana1 is Mana + 40,
    retract(player_mana(_,_)),
    retract(turn(_)),
    (Mana1 > MaxMana -> 
        asserta(player_mana(MaxMana, MaxMana)), ! 
    ; 
        asserta(player_mana(Mana1, MaxMana)), !
    ),
    asserta(turn(0)),
    write('Kamu memakai Blue Potion\n\n'), !.

use_potion('Enrage Potion'):-
    \+itemInv('Enrage Potion',_),
    write('Tidak punya enrage potion!\n\n'),
    battle_mechanism.

use_potion('Enrage Potion'):-
    itemInv('Enrage Potion',_),
    delItemInv('Enrage Potion'),
    player_att(Att),
    Att1 is Att + 30,
    retract(player_att(_)),
    retract(turn(_)),
    asserta(player_att(Att1)),
    asserta(turn(0)),
    write('Kamu memakai Enrage Potion\n\n'), !.

use_potion('Defense Potion'):- 
    \+itemInv('Defense Potion',_),
    write('Tidak punya defense potion!\n'),
    battle_mechanism.

use_potion('Defense Potion'):-   
    itemInv('Defense Potion',_),
    delItemInv('Defense Potion'),
    player_def(Def),
    Def1 is Def + 20,
    retract(player_def(_)),
    retract(turn(_)),
    asserta(player_def(Def1)),
    asserta(turn(0)),
    write('Kamu memakai Defense Potion\n\n'), !.


/* Fungsi-fungsi Equip Item */
check_required_class(Name):-
    player_class(Class),
    item(ItemClass,_,Name,_,_),
    (ItemClass == Class ->
        true
    ;
        write('Item bukan untuk Class kamu!\n\n'), !, fail
    ).


check_required_lvl(Name):-
    player_lvl(Level),
    item(_, _, Name, MinLvl, _),
    Level >= MinLvl, !.

check_required_lvl(Name):-
    player_lvl(Level),
    item(_, _, Name, MinLvl, _),
    Level < MinLvl,
    write('Level Tidak Mencukupi!'), nl, !, fail.

unequip_weapon :-
    player_class(Class),
    player_weapon(Name),
    player_att(Att),
    default_weapon(Class, DefaultWeapon),
    item(_, _, Name, _, ItemAtt),
    Att1 is Att - ItemAtt,
    retract(player_att(_)),
    retract(player_weapon(_)),
    asserta(player_att(Att1)),
    asserta(player_weapon(DefaultWeapon)), !.

unequip_armor:-
    player_class(Class),
    player_armor(Name),
    player_def(Def),
    default_armor(Class, DefaultArmor),
    item(_, _, Name, _, ItemDef),
    Def1 is Def - ItemDef,
    retract(player_def(_)),
    retract(player_armor(_,_)),
    asserta(player_def(Def1)),
    asserta(player_armor(DefaultArmor)), !.

set_item('Weapon', Name):-
    check_required_class(Name),
    check_required_lvl(Name),
    unequip_weapon,
    player_att(Att1),
    item(_, _, Name, _, Att),
    Att2 is Att + Att1,
    retract(player_att(_)),
    retract(player_weapon(_)),
    asserta(player_att(Att2)),
    asserta(player_weapon(Name)), !.

set_item('Armor', Name):-
    check_required_class(Name),
    check_required_lvl(Name),
    unequip_armor,   
    player_def(Def1),
    item(_, _, Name, _, Def),
    Def2 is Def + Def1,
    retract(player_def(_)),
    retract(player_armor(_)),
    asserta(player_def(Def2)),
    asserta(player_armor(Name)), !.

equip_item(Name):-
    item(_, Type, Name, _, _),
    set_item(Type, Name), 
    write(Name), write(' berhasil di-equip!\n\n'), !.