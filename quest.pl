:- include('map.pl').

:- dynamic(level/3).
%level(tingkat kesulitan,exp,gold).

:-dynamic(statusquest/1).
%statusquest(1) maka sedang ada quest berjalan
%statusquest(0) maka tidak ada quest berjalan

:-dynamic(levelsekarang/1).
%levelsekarang(L) level yang sekarang sedang dijalankan (1-6)

:-dynamic(treasurestats/1).
%treasurestats(1) maka bonus quest sudah pernah diambil sebelumnya
%treasurestats(0) maka bonus quest belum pernah diambil sebelumnya

quest(Slime,Goblin,Wolf) :-
    Slime >= 0, Goblin >=3, Wolf >= 2, !, retractall(level(_,_,_)), asserta(level(6,600,600));
    Slime >= 1, Goblin >=1, Wolf >= 2, !, retractall(level(_,_,_)), asserta(level(5,500,500));
    Slime >= 1, Goblin >=1, Wolf >= 1, !, retractall(level(_,_,_)), asserta(level(4,400,400));
    Slime >= 2, Goblin >=1, Wolf >= 0, !, retractall(level(_,_,_)), asserta(level(3,300,300));
    Slime >= 1, Goblin >=1, Wolf >= 0, !, retractall(level(_,_,_)), asserta(level(2,200,200));
    Slime >= 1, Goblin >=0, Wolf >= 0, !, retractall(level(_,_,_)), asserta(level(1,100,100)).


getprize(Exp,Gold) :-
    level(_,AB,AC),
    Exp is AB,
    Gold is AC.

statusquest(0).
startquest(A):-
    statusquest(0),
    retractall(statusquest(_)),
    retractall(levelsekarang(_)),
    asserta(statusquest(1)),
    asserta(levelsekarang(A)),

    !;
    statusquest(1),
    write('selesaikan quest yang sudah ada dulu gan').


pantauQuest(S,G,W):-
    statusquest(1),
    quest(S,G,W),
    level(Now,_,_),
    levelsekarang(A),
    Now =:= A,
    write('selamat quest ke- '),
    write(A),write(' sudah selesai, hadiah sudah otomatis terklaim'),
    getprize(Exp,Emas),
    %tambah skema untuk penambahan exp dan emas.
    retractall(statusquest(_)),
    asserta(statusquest(0)),!;
    
    statusquest(1),
    progressquest(S,G,W),!;

    statusquest(0),!, write('tidak ada quest yang dipantau').

abandon :-
    statusquest(1),
    retractall(statusquest(_)),
    write('anda telah menyerah pada quest ini'),
    asserta(statusquest(0)),!;
    statusquest(0), write('tidak ada quest yang dijalankan!').

%bonusQuest
treasurestats(0).
bonusQuest:-
    statusquest(1),!,
    write('selesaikan quest yang sudah ada dulu gan');
    treasurestats(1),!,
    write('harta karun sudah pernah diambil bosq');
    statusquest(0),treasurestats(0),!,
    %skema penambahan exp dan gold
    write('selamat anda mendapat harta karun'),nl,
    write('xx EXP telah ditambahkan'),nl,
    write('yy Gold telah ditambahkan'),
    retractall(statusquest(_)),  
    asserta(treasurestats(1)).

%progressquest
progressquest(S,G,W):-
    levelsekarang(Now),
    Now =:= 1,
    write('quest stats'),nl,
    write('Now playing on Level '),write(Now),nl,
    write(S),write('/1 Slime to pass'),nl,!;

    levelsekarang(Now),
    Now =:= 2,
    write('quest stats'),nl,
    write('Now playing on Level '),write(Now),nl,
    write(S),write('/1 Slime to pass'),nl,
    write(G),write('/1 Goblin to pass'),nl,!;

    levelsekarang(Now),
    Now =:= 3,
    write('quest stats'),nl,
    write('Now playing on Level '),write(Now),nl,
    write(S),write('/2 Slime to pass'),nl,
    write(G),write('/1 Goblin to pass'),nl,!;

    levelsekarang(Now),
    Now =:= 4,
    write('quest stats'),nl,
    write('Now playing on Level '),write(Now),nl,
    write(S),write('/1 Slime to pass'),nl,
    write(G),write('/1 Goblin to pass'),nl,
    write(W),write('/1 Wolf to pass'),nl,!;

    levelsekarang(Now),
    Now =:= 5,
    write('quest stats'),nl,
    write('Now playing on Level '),write(Now),nl,
    write(S),write('/1 Slime to pass'),nl,
    write(G),write('/1 Goblin to pass'),nl,
    write(W),write('/2 Wolf to pass'),nl,!;

    levelsekarang(Now),
    Now =:= 6,
    write('quest stats'),nl,
    write('Now playing on Level '),write(Now),nl,
    write(G),write('/3 Goblin to pass'),nl,
    write(W),write('/2 Wolf to pass'),nl,!.
