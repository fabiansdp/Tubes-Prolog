read_command :-
    write('Apa yang ingin kamu lakukan?\n'),
    read(X), nl,
    do(X), !.

/* Command Battle */
do('attack') :- attack.

do('lari') :- lari.

do('help') :-
    write('Daftar Command Battle:\n'),
    write('1. status\n'),
    write('2. attack\n'),
    write('3. specialattack\n'),
    write('4. lari\n'),
    write('5. redpotion\n'),
    write('6. bluepotion\n'),
    write('7. enragepotion\n'),
    write('8. defensepotion\n'),
    battle_mechanism.

do('heal') :-
    (battle_status(1) ->
        write('Kamu tidak bisa heal di dalam battle!\n'),
        write('Gunakan potion yang kamu punya!\n\n'),
        battle_mechanism

    ; 
        heal
    ).

do('specialattack'):-
    (battle_status(1) ->
        skill_cd(CD),
        (CD == 0 ->
            specialattack,
            battle_mechanism
        
        ; 
            write('Skill masih cooldown!\n\n'),
            battle_mechanism
        )

    ; 
        write('Kamu tidak di dalam battle!\n\n'),
        game
    ).

do('status'):-
    status.

do('redpotion'):-
    use_potion('Red Potion'),
    battle_mechanism, !.

do('bluepotion'):-
    use_potion('Blue Potion'),
    battle_mechanism, !.

do('enragepotion'):-
    use_potion('Enrage Potion'),
    battle_mechanism, !.

do('defensepotion'):-
    use_potion('Defense Potion'),
    battle_mechanism, !.

/* Command Exploration */
help :-
    write('Daftar Command:\n'),
    write('1. w (Maju)\n'),
    write('2. a (Kiri)\n'),
    write('3. s (Mundur)\n'),
    write('4. d (Kanan)\n'),
    write('5. heal (Pulihkan HP dan Mana)\n'),
    write('6. legend (Lihat legend map)\n'),
    write('7. status (Lihat Stat)\n'),
    write('8. inventory (Lihat Inventory)\n'),
    write('9. equip(Insert nama item)\n'),
    write('10. checkquest (Check Status Quest)\n\n'),
    write('Apa yang ingin kamu lakukan?\n\n'). 