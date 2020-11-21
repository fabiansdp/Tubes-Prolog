:- include('enemy.pl').
:- include('player.pl').

:- dynamic(enemy_hp/2). /* enemy_hp(HP, MaxHP) */
:- dynamic(enemy_att/1). /* enemy_att(Att) */
:- dynamic(enemy_def/1). /* enemy_def(Def) */
:- dynamic(enemy_name/1). /* enemy_name(Name) */
:- dynamic(turn/1). /* Turn(0) untuk player, turn(1) untuk enemy */
:- dynamic(battle_status/1). /*0 untuk battle selesai, 1 untuk battle berjalan*/


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
    write('HP: '), write(HP), write('/'), write(MaxHP), nl, !.

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
    player_hp(HP, MaxHP),
    HP1 is HP - X,
    asserta(player_hp(HP1, MaxHP)), 
    check_dead, !.

decr_mana(X) :-
    player_mana(Mana, MaxMana),
    Mana1 is Mana - X,
    (Mana1 =< 0 ->
        write('Mana tidak cukup!!!!\n\n'), fail
    ;
        asserta(player_mana(Mana1, MaxMana))
    ).

decr_enemy_hp(X) :-
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

skill_effect(Skill) :-
    Skill == 'Power Shot',
    player_att(Att),
    player_mana(Mana, _),
    Damage is Att*2,
    Mana1 is Mana - 40,
    decr_mana(Mana1),
    decr_enemy_hp(Damage),
    write('Power Shot!!\n\n'), !.

specialattack :-
    player_class(Class),
    special_skill(Class, Name),
    skill_effect(Name),
    asserta(turn(0)), !.

/* Fungsi Attack */
enemy_attack :-
    write('Musuh menyerang!\n\n'),
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
        heal,
        write('Semua lukamu hilang!\n\n')
    ).

do('specialattack'):-
    (battle_status(1) ->
        specialattack,
        battle_mechanism

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
    (Status == 1 ->
        turn(Turn),  

        (Turn == 1 -> 
            read_command, !
        
        ; enemy_attack
        ) 

    ; write('Battle selesai!')
    ), !.

/* Fungsi Battle */
battle :-
    asserta(battle_status(1)),
    asserta(turn(1)),
    random(1, 4, X),
    generate_enemy(X, Enemy),
    setup_enemy(Enemy),
    enemy_name(Enemy), 
    enemy_hp(HP, MaxHP), nl,
    write('Musuhmu adalah '), 
    write(Enemy), nl, 
    write('HP: '), write(HP), write('/'), write(MaxHP), nl, nl,
    battle_mechanism, !.

