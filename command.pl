read_command :-
    write('Apa yang ingin kamu lakukan?\n'),
    read(X), nl,
    do(X), !.

/* Jalankan Command */
do('attack') :- attack.

do('lari') :- lari.

do('help') :-
    (enginestats(0) ->
        write('Game belum dimulai!\n\n')
    ;
        (battle_status(1) ->
            write('Daftar Command Battle:\n'),
            write('1. status\n'),
            write('2. attack\n'),
            write('3. specialattack\n'),
            write('4. lari\n\n'),
            battle_mechanism

        ; 
            write('Daftar Command:\n'),
            write('1. w (Maju)\n'),
            write('2. a (Kiri)\n'),
            write('3. s (Mundur)\n'),
            write('4. d (Kanan)\n'),
            write('5. heal (Pulihkan HP dan Mana)\n'),
            write('6. legend\n'),
            write('7. status (Lihat Stat)\n'),
            write('8. inventory (Lihat Inventory)\n\n'),
            game
        )
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
    (battle_status(1) ->
        status,
        battle_mechanism

    ; 
        status, 
        game
    ).

do('inventory'):-
    inventory,
    game.

do('quit'):-
    quit.