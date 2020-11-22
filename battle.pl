:- include('enemy.pl').
:- include('player.pl').

:- dynamic(enemy_hp/2). /* enemy_hp(HP, MaxHP) */
:- dynamic(enemy_att/1). /* enemy_att(Att) */
:- dynamic(enemy_def/1). /* enemy_def(Def) */
:- dynamic(enemy_name/1). /* enemy_name(Name) */
:- dynamic(turn/1). /* Turn(0) untuk player, turn(1) untuk enemy */
:- dynamic(battle_status/1). /*0 untuk battle selesai, 1 untuk battle berjalan*/
:- dynamic(skill_cd/1). /* Skill Cooldown yaitu 3 turn */
:- dynamic(effect_cd/1). /* Cooldown untuk effect special skill */
:- dynamic(normal_stat/2). /* Normal stat pemain sebelum efek skill normal_stat(Att,Def) */

/* Generate Musuh */
generate_enemy(1, 'Slime').
generate_enemy(2, 'Goblin').
generate_enemy(3, 'Wolf').

/* Setup enemy */
setup_enemy(Enemy):-
    retractall(enemy_hp(_)),
    retractall(enemy_att(_)),
    retractall(enemy_def(_)),
    retractall(enemy_name(_)),
    enemy(Enemy, _, HP, MaxHP, Att, Def, _, _),
    asserta(enemy_hp(HP, MaxHP)),
    asserta(enemy_att(Att)),
    asserta(enemy_def(Def)),
    asserta(enemy_name(Enemy)), !.

/* Fungsi-fungsi pemain */
enemy_hp_status :-
    enemy_name(Name),
    enemy_hp(HP, MaxHP),
    write(Name), write(':\n'),
    write('HP: '), write(HP), write('/'), write(MaxHP), nl, nl, !.

hp_status :-
    player_hp(HP, MaxHP),
    write('HP: '), write(HP), write('/'), write(MaxHP), nl, nl, !.

check_dead_enemy :-
    enemy_hp(HP,_),
    (HP =< 0 ->
        enemy_name(Enemy),
        enemy(Enemy,_,_,_,_,_,XP,Gold),
        write(Enemy),
        write(' telah mati!\n\n'),
        add_gold(Gold),
        add_xp(XP),
        asserta(battle_status(0))

    ; enemy_hp_status   
    ).

check_dead :-
    player_hp(HP, _),
    (HP =< 0 ->  
        write('Kamu mati!\n\n'),
        write('GAME OVER!!!\n\n'),
        asserta(battle_status(0))

    ; hp_status
    ).

decr_hp(X) :-
    write('HP kamu berkurang sebanyak '), write(X), nl,
    player_hp(HP, MaxHP),
    HP1 is HP - X,
    asserta(player_hp(HP1, MaxHP)), 
    check_dead, !.

add_hp(X) :-
    write('HP kamu bertambah sebanyak '), write(X), nl,
    player_hp(HP, MaxHP),
    HP1 is HP - X,
    (HP1 > MaxHP ->
        asserta(player_hp(MaxHP, MaxHP))
    ;
        asserta(player_hp(HP1, MaxHP))
    ).

decr_mana(X) :-
    player_mana(Mana, MaxMana),
    Mana1 is Mana - X,
    asserta(player_mana(Mana1, MaxMana)), !.

decr_cd :-
    skill_cd(CD),
    CD1 is CD - 1,
    (CD1 == 0 ->
        asserta(skill_cd(CD1)),
        write('Special Attack dapat dipakai lagi\n\n')

    ; asserta(skill_cd(CD1))    
    ).

normalize_stat('Rage') :-
    normal_stat(Att,Def),
    asserta(player_att(Att)),
    asserta(player_def(Def)).

decr_effect :-
    effect_cd(CD),
    CD1 is CD - 1,
    (CD1 == 0 ->
        asserta(effect_cd(CD1)),
        player_class(Class),
        special_skill(Class, Name),
        normalize_stat(Name),
        write('Efek spesial telah hilang\n\n')

    ; asserta(effect_cd(CD1))    
    ).

decr_enemy_hp(X) :-
    enemy_name(Name),
    write('HP '), write(Name), write(' berkurang sebanyak '), write(X), nl,
    enemy_hp(HP, MaxHP), 
    HP1 is HP - X,
    asserta(enemy_hp(HP1, MaxHP)),
    check_dead_enemy.

attack :-
    (battle_status(1) ->
        write('Kamu Menyerang!\n\n'),
        enemy_def(Def),
        player_att(Att),
        Damage is Att - Def*0.2,
        decr_enemy_hp(Damage),
        retractall(turn(_)),
        asserta(turn(0)),
        skill_cd(CD),
        (CD > 0 -> decr_cd ; true),
        effect_cd(Effect),
        (Effect > 0 -> decr_effect ; true),
        battle_mechanism

    ; write('Kamu tidak dalam battle!\n')
    ).

lari :-
    random(1,3,X),
    (X == 1 ->
        asserta(battle_status(0)),
        write('Kamu berhasil melarikan diri dari battle!\n\n'),
        battle_mechanism
    ; 
        write('Oops kamu ga berhasil melarikan diri!\n\n'),
        asserta(turn(0)),
        battle_mechanism
    ).

skill_effect('Rage') :-
    player_att(Att),
    player_def(Def),
    player_lvl(Level),
    player_mana(Mana, _),
    ManaDecr is (30 + 10*(Level-1)),
    Mana1 is Mana - ManaDecr,
    (Mana1 < 0 ->
        write('Mana tidak cukup!\n\n')

    ;
        decr_mana(ManaDecr),
        AttMod is Att * (0.5+0.01*(Level-1)),
        DefMod is Def * (0.5+0.01*(Level-1)),
        Att1 is Att + AttMod,
        Def1 is Def + DefMod,
        asserta(player_att(Att1)),
        asserta(player_def(Def1)),
        asserta(skill_cd(3)),
        asserta(effect_cd(2)),
        write('Rage!!!\n'), 
        write('Stat kamu bertambah untuk dua turn!\n\n'),
        asserta(turn(0))
    ).


skill_effect('Power Shot') :-
    player_att(Att),
    player_lvl(Level),
    player_mana(Mana, _),
    ManaDecr is (40 + 10*(Level-1)),
    Mana1 is Mana - ManaDecr,
    (Mana1 < 0 ->
        write('Mana tidak cukup!\n\n')

    ;
        decr_mana(ManaDecr),
        Damage is Att* (2 + 0.02*(Level-1)),
        write('Power Shot!!\n'),
        decr_enemy_hp(Damage),
        asserta(skill_cd(3)),
        asserta(turn(0))
    ).

skill_effect('Divine Light') :-
    player_hp(HP,_),
    player_att(Att),
    player_def(Def),
    player_lvl(Level),
    player_mana(Mana, _),
    ManaDecr is (50 + 20*(Level-1)),
    Mana1 is Mana - ManaDecr,
    (Mana1 < 0 ->
        write('Mana tidak cukup!\n\n')

    ;
        decr_mana(ManaDecr),
        write('Divine Light!!!\n'), 
        HPMod is HP * (0.4 + 0.01*(Level-1)),
        add_hp(HPMod),
        AttMod is 20 + 5*(Level-1),
        DefMod is 20 + 5*(Level-1),
        Att1 is Att + AttMod,
        Def1 is Def + DefMod,
        asserta(player_att(Att1)),
        asserta(player_def(Def1)),
        asserta(skill_cd(3)),
        asserta(effect_cd(2)),
        asserta(turn(0))
    ).

specialattack :-
    player_class(Class),
    special_skill(Class, Name),
    skill_effect(Name), !.

/* Fungsi Attack */
enemy_attack :-
    enemy_name(Name),
    write(Name),
    write(' menyerang!\n\n'),
    player_def(Def),
    enemy_att(Att),
    Damage is Att - Def*0.2,
    decr_hp(Damage),
    asserta(turn(1)),
    battle_mechanism, !.

/* Jalankan Command */
do('attack') :- attack.

do('lari') :- lari.

do('help') :-
    (battle_status(1) ->
        write('Daftar Command Battle:\n'),
        write('1. status\n'),
        write('2. attack\n'),
        write('3. specialattack\n'),
        write('4. lari\n\n'),
        battle_mechanism

    ; 
        write('Daftar Command:\n'),
        write('1. heal\n'),
        write('2. legend\n'),
        write('3. status\n'),
        write('4. inventory\n')
    ).

do('heal') :-
    (battle_status(1) ->
        write('Kamu tidak bisa heal di dalam battle!\n'),
        write('Gunakan potion yang kamu punya!\n\n'),
        battle_mechanism

    ; 
        heal
    ).

do('specialattack'):-
    battle_status(Status),
    (Status == 1 ->
        skill_cd(CD),
        (CD == 0 ->
            specialattack,
            battle_mechanism
        
        ; 
            write('Skill masih cooldown!\n\n'),
            battle_mechanism
        )

    ; 
        write('Kamu tidak di dalam battle!\n\n'), fail
    ).

do('status'):-
    (battle_status(1) ->
        status,
        battle_mechanism

    ; 
        status
    ).

/* Read Commands */
read_command :-
    write('Apa yang ingin kamu lakukan?\n'),
    read(X), nl,
    do(X), !.

/* Battle Mechanism */
battle_mechanism :-
    battle_status(Status),
    write(Status), write('Jancok'), nl,
    (Status == 1 ->
        turn(Turn),  
        (Turn == 1 -> 
            read_command, !
        
        ; enemy_attack
        ) 

    ;   
        player_class(Class),
        special_skill(Class, Name),
        normalize_stat(Name),
        write('Battle Selesai!')
    ), !.

/* Fungsi Battle */
battle(X) :-
    player_att(Att),
    player_def(Def),
    asserta(battle_status(1)),
    asserta(turn(1)),
    asserta(skill_cd(0)),
    asserta(effect_cd(0)),
    asserta(normal_stat(Att, Def)),
    generate_enemy(X, Enemy),
    setup_enemy(Enemy),
    enemy_name(Enemy), 
    enemy_hp(HP, MaxHP), nl,
    write('Musuhmu adalah '), 
    write(Enemy), nl, 
    write('HP: '), write(HP), write('/'), write(MaxHP), nl, nl,
    battle_mechanism, !.

