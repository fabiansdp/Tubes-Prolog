:-dynamic(statusquest/1).
%statusquest(1) maka sedang ada quest berjalan
%statusquest(0) maka tidak ada quest berjalan

:-dynamic(levelsekarang/1).
%levelsekarang(L) level quest yang sekarang sedang dijalankan (1-6)

:-dynamic(treasurestats/1).
%treasurestats(1) maka bonus quest sudah pernah diambil sebelumnya
%treasurestats(0) maka bonus quest belum pernah diambil sebelumnya

:-dynamic(killstats/3).
% killstats(slime,goblin,wolf)


/* quest(lvl,xp,gold) */
quest(1, 15, 75).
quest(2, 30, 100).
quest(3, 40, 150).
quest(4, 55, 250).
quest(5, 65, 400).
quest(6, 80, 600).

/* Jumlah kill untuk setiap kill quest_goal(lvl,slime,goblin,wolf)*/
quest_goal(1,3,0,0).
quest_goal(2,2,1,0).
quest_goal(3,3,2,0).
quest_goal(4,3,1,1).
quest_goal(5,3,2,1).
quest_goal(6,3,3,2).

% Init di awal game
quest_init:-
    asserta(statusquest(0)),
    asserta(treasurestats(0)).

startquest(A):-
    statusquest(0),
    retractall(statusquest(_)),
    retractall(levelsekarang(_)),
    retractall(killstats(_,_,_)),
    asserta(killstats(0,0,0)),
    asserta(statusquest(1)),
    asserta(levelsekarang(A)), !;

    statusquest(1),
    write('Selesaikan quest yang sudah ada dulu gan\n\n').

abandon :-
    statusquest(1),
    retractall(statusquest(_)),
    write('Anda telah menyerah pada quest ini\n'),
    asserta(statusquest(0)),!;

    statusquest(0), write('Tidak ada quest yang dijalankan!\n\n').

%bonusQuest
treasureQuest:-
    treasurestats(1),
    write('Harta karun sudah pernah diambil bos\n\n');

    treasurestats(0),
    write('Selamat Anda menemukan harta karun'),nl,
    write('1000 Gold telah ditambahkan\n\n'),
    add_gold(1000),
    retract(treasurestats(_)),
    asserta(treasurestats(1)), game.

check_completion :-
    levelsekarang(X),
    killstats(Slime,Goblin,Wolf),
    quest_goal(X, SGoal, GGoal, WGoal),
    (Slime == SGoal -> 
        (Goblin == GGoal ->
            (Wolf == WGoal ->
                write('Quest Selesai!\n'),
                retractall(statusquest(_)),
                asserta(statusquest(0)),
                quest(X, XP, Gold),
                add_xp(XP),
                add_gold(Gold)
            ;
                true
            )
        ;
            true
        )   
    ;
        true 
    ).

quest_tracker('Slime') :-
    killstats(Slime,Goblin,Wolf),
    Slime1 is Slime + 1,
    retract(killstats(_,_,_)),
    asserta(killstats(Slime1,Goblin,Wolf)),
    check_completion.

quest_tracker('Goblin') :-
    killstats(Slime,Goblin,Wolf),
    Goblin1 is Goblin + 1,
    retract(killstats(_,_,_)),
    asserta(killstats(Slime,Goblin1,Wolf)),
    check_completion.

quest_tracker('Wolf') :-
    killstats(Slime,Goblin,Wolf),
    Wolf1 is Wolf + 1,
    retract(killstats(_,_,_)),
    asserta(killstats(Slime,Goblin,Wolf1)),
    check_completion.

checkquest :-
    statusquest(1),
    levelsekarang(X),
    killstats(S,G,W),
    quest_goal(X, SGoal, GGoal, WGoal),
    write('Status Quest:\n'),
    write('Slime: '), write(S), write('/'), write(SGoal), nl,
    write('Goblin: '), write(G), write('/'), write(GGoal), nl,
    write('Wolf: '), write(W), write('/'), write(WGoal), nl, nl,
    game.

checkquest :-
    statusquest(0),
    write('Kamu tidak ada Quest!\n\n'), 
    game.