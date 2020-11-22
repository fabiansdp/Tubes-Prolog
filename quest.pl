quest(Slime,Goblin,Wolf,Prize) :-
    Slime >= 15, Goblin >=13, Wolf >= 8, !, Prize is 6;
    Slime >= 12, Goblin >=13, Wolf >= 5, !, Prize is 5;
    Slime >= 7, Goblin >=5, Wolf >= 2, !, Prize is 4;
    Slime >= 5, Goblin >=3, Wolf >= 1, !, Prize is 3;
    Slime >= 3, Goblin >=1, Wolf >= 0, !, Prize is 2;
    Slime >= 1, Goblin >=0, Wolf >= 0, !, Prize is 1;

doquest(1,100,100).
doquest(2,200,200).
doquest(3,300,300).
doquest(4,400,400).
doquest(5,500,500).
doquest(6,600,600).
doquest(PrizeCode,Exp,Gold) :-
    doquest(PrizeCode,a,b),
    Exp is a,
    Gold is b.