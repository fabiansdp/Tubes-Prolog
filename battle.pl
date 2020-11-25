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
generate_enemy(4, 'Ancient Black Dragon').

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
        retract(battle_status(_)),
        asserta(battle_status(0)),
        (statusquest(1) -> quest_tracker(Enemy) ; true),
        (enemy_name('Ancient Black Dragon') ->
            write('Kamu Telah Membasmi Naga Hitam!!\n\n'),
            retract(enginestats(_)),
            asserta(enginestats(0))
        ;
            true
        )

    ; enemy_hp_status   
    ).

check_dead :-
    player_hp(HP, _),
    (HP =< 0 ->  
        write('Kamu mati!\n\n'),
        write('GAME OVER!!!\n\n'),
        retract(battle_status(_)),
        retract(enginestats(_)),
        asserta(enginestats(0)),
        asserta(battle_status(0))

    ; hp_status
    ).

decr_hp(X) :-
    write('HP kamu berkurang sebanyak '), write(X), nl,
    player_hp(HP, MaxHP),
    HP1 is HP - X,
    retract(player_hp(_,_)),
    asserta(player_hp(HP1, MaxHP)), 
    check_dead, !.

add_hp(X) :-
    write('HP kamu bertambah sebanyak '), write(X), write('!'), nl,
    player_hp(HP, MaxHP),
    HP1 is HP + X,
    retract(player_hp(_,_)),
    (HP1 > MaxHP ->
        asserta(player_hp(MaxHP, MaxHP))
    ;
        asserta(player_hp(HP1, MaxHP))
    ),
    hp_status, !.

decr_mana(X) :-
    player_mana(Mana, MaxMana),
    Mana1 is Mana - X,
    retract(player_mana(_,_)),
    asserta(player_mana(Mana1, MaxMana)), !.

decr_cd :-
    skill_cd(CD),
    CD1 is CD - 1,
    retract(skill_cd(_)),
    (CD1 == 0 ->
        asserta(skill_cd(CD1)),
        write('Special Attack dapat dipakai lagi\n\n')

    ; asserta(skill_cd(CD1))    
    ).

normalize_stat :-
    normal_stat(Att,Def),
    retractall(skill_cd(_)),
    retractall(effect_cd(_)),
    retract(player_att(_)),
    retract(player_def(_)),
    asserta(player_att(Att)),
    asserta(player_def(Def)).

decr_effect :-
    effect_cd(CD),
    CD1 is CD - 1,
    retract(effect_cd(_)),
    (CD1 == 0 ->
        asserta(effect_cd(CD1)),
        normalize_stat,
        write('Efek spesial telah hilang\n\n')

    ; asserta(effect_cd(CD1))    
    ).

decr_enemy_hp(X) :-
    enemy_name(Name),
    write('HP '), write(Name), write(' berkurang sebanyak '), write(X), nl,
    enemy_hp(HP, MaxHP), 
    HP1 is HP - X,
    retract(enemy_hp(_,_)),
    asserta(enemy_hp(HP1, MaxHP)),
    check_dead_enemy.

attack :-
    (battle_status(1) ->
        write('Kamu Menyerang!\n\n'),
        enemy_def(Def),
        player_att(Att),
        Damage is Att - Def*0.2,
        (Damage < 0 -> decr_enemy_hp(0) ; decr_enemy_hp(Damage)),
        retract(turn(_)),
        asserta(turn(0)),
        skill_cd(CD),
        (CD > 0 -> decr_cd ; true),
        effect_cd(Effect),
        (Effect > 0 -> decr_effect ; true),
        battle_mechanism

    ; 
        write('Kamu tidak dalam battle!\n'), 
        game
    ).

lari :-
    random(1,3,X),
    (X == 1 ->
        retract(battle_status(_)),
        asserta(battle_status(0)),
        write('Kamu berhasil melarikan diri dari battle!\n\n'),
        battle_mechanism
    ; 
        write('Oops kamu ga berhasil melarikan diri!\n\n'),
        retract(turn(_)),
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
        retract(player_att(_)),
        retract(player_def(_)),
        retract(skill_cd(_)),
        retract(effect_cd(_)),
        asserta(player_att(Att1)),
        asserta(player_def(Def1)),
        asserta(skill_cd(3)),
        asserta(effect_cd(2)),
        write('Rage!!!\n'), 
        write('Stat kamu bertambah untuk dua turn!\n\n'),
        retract(turn(_)),
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
        retract(skill_cd(_)),
        retract(turn(_)),
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
        write('Stat kamu bertambah untuk 2 turn!\n'),
        HPMod is HP * (0.4 + 0.01*(Level-1)),
        add_hp(HPMod),
        AttMod is 20 + 5*(Level-1),
        DefMod is 20 + 5*(Level-1),
        Att1 is Att + AttMod,
        Def1 is Def + DefMod,
        retract(player_att(_)),
        retract(player_def(_)),
        retract(skill_cd(_)),
        retract(effect_cd(_)),
        retract(turn(_)),
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
    (Damage < 0 -> decr_hp(0) ; decr_hp(Damage)),
    retract(turn(_)),
    asserta(turn(1)),
    battle_mechanism, !.

/* Battle Mechanism */
battle_mechanism :-
    battle_status(Status),
    (Status == 1 ->
        turn(Turn),  
        (Turn == 1 -> 
            read_command, !
        
        ; enemy_attack
        ) 

    ;   
        normalize_stat,
        game
    ), !.

/* Fungsi Battle */
battle(X) :-
    player_att(Att),
    player_def(Def),
    retractall(battle_status(_)),
    retractall(turn(_)),
    retractall(skill_cd(_)),
    retractall(effect_cd(_)),
    retractall(normal_stat(_,_)),
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

boss_fight :-
    player_att(Att),
    player_def(Def),
    retractall(battle_status(_)),
    retractall(turn(_)),
    retractall(skill_cd(_)),
    retractall(effect_cd(_)),
    retractall(normal_stat(_,_)),
    asserta(battle_status(1)),
    asserta(turn(1)),
    asserta(skill_cd(0)),
    asserta(effect_cd(0)),
    asserta(normal_stat(Att, Def)),
    generate_enemy(4, Enemy),
    setup_enemy(Enemy),
    enemy_name(Enemy), 
    enemy_hp(HP, MaxHP), nl,
    write('=== BOSS FIGHT =====\n'),
    write('Kalahkan Naga Hitam!\n\n'),
    write('Musuhmu adalah '), 
    write(Enemy), nl, 
    write('HP: '), write(HP), write('/'), write(MaxHP), nl, nl,
    battle_mechanism, !.
