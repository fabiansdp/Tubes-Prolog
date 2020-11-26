read_command :-
    write('What you want to do, My Lord?\n'),
    read(X), nl,
    do(X), !.

/* Command Battle */
do('attack') :- attack.

do('flee') :- lari.

do('help') :-
    write('Battle action list:\n'),
    write('1. status\n'),
    write('2. attack\n'),
    write('3. specialattack\n'),
    write('4. flee\n'),
    write('5. redpotion\n'),
    write('6. bluepotion\n'),
    write('7. enragepotion\n'),
    write('8. defensepotion\n'),
    battle_mechanism.

do('heal') :-
    (battle_status(1) ->
        write('You cant use heal in the battle!\n'),
        write('Use your potion, My Lord!\n\n'),
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
            write('Skill is in cooldown!\n\n'),
            battle_mechanism
        )

    ; 
        write('You are not in battle, My Lord!\n\n'),
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

do(_) :-
    write('I think that is not an option, My Lord'), nl,
    battle_mechanism, !.

/* Command Exploration */
help :-
    write('Command list:\n'),
    write('1. w (Forward)\n'),
    write('2. a (Left)\n'),
    write('3. s (Backward)\n'),
    write('4. d (Right)\n'),
    write('5. heal (Replenish HP and mana\n'),
    write('6. legend (Show map and map legend)\n'),
    write('7. status (Show player stats)\n'),
    write('8. inventory (Open inventory)\n'),
    write('9. equip(Insert item name)\n'),
    write('10. checkquest (Check quest status)\n\n'),
    write('What you want to do, My Lord?\n\n'). 