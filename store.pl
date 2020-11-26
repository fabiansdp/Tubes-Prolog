:- dynamic(harga/3). /* harga(Item,Harga) */


/*=============================================================*/
                        /*FAKTA*/
/*Daftar harga yang ada di shop*/
harga(1, 'Gacha', 30).
harga(2, 'Red Potion', 15).
harga(3, 'Blue Potion', 15).
harga(4, 'Rage Potion', 10).
harga(5, 'Deffense Potion', 10).

/*Id tiap Item*/
itemId(1, 'Beginner Sword').
itemId(2, 'Great Sword').
itemId(3, 'Sword of Light').
itemId(4, 'Divine Sword').

itemId(5, 'Wooden Bow').
itemId(6, 'Sturdy Bow').
itemId(7, 'Great Bow').
itemId(8, 'Divine Bow').

itemId(9, 'Magic Staff').
itemId(10, 'Good Staff').
itemId(11, 'Staff of Wisdom').
itemId(12, 'Divine Staff').

itemId(13, 'Beginner Armor').
itemId(14, 'Great Armor').
itemId(15, 'Armor of Light').
itemId(16, 'Divine Armor').

itemId(17, 'Beginner Cloth').
itemId(18, 'Archer Cloth').
itemId(19, 'Cloth of Light').
itemId(20, 'Divine Cloth').

itemId(21, 'Beginner Robe').
itemId(22, 'Magician Robe').
itemId(23, 'Robe of Light').
itemId(24, 'Divine Robe').
/*=============================================================*/




/*=============================================================*/
                            /*COMMAND*/
/*untuk testing*/
/*
set_store :-  
    set_gold,
    add_gold(1000).
*/

/*Command untuk membuka shop*/
shop :- 
    write('Your Majesty, what do you need? '), nl,
    write('Input 1 to Gacha Item (30 Gold) '), nl,
    write('Input 2 to buy Red Potion (15 Gold)'), nl,
    write('Input 3 to buy Blue Potion (15 Gold)'), nl,
    write('Input 4 to buy Rage Potion (10 Gold)'), nl,
    write('Input 5 to buy Defense Potion (10 Gold)'), nl,
    write('Input 6 to Exit shop'), nl,
    read(X),
    input(X), !.
/*=============================================================*/


/*=============================================================*/
/*Exit shop*/
input(6) :-
    write('Thank you very much, I hope Your succesfull journey!'), nl, nl, game, !.
/*=============================================================*/



/*=============================================================*/
                            /*BELI ITEM*/
/*GOLD TIDAK CUKUP*/
input(X) :-
    gold(Gold),
    harga(X,_,Harga),
    (Harga > Gold),
    write('Not enough gold!\n'), nl, shop, !.

/*GOLD CUKUP*/
/*Item yang dibeli Gacha*/
input(1) :-
    harga(1,_,Harga),
    min_gold(Harga),
    random(1,25,Y),
    itemId(Y,RandomItem),
    write('GOTCHAAA, you obtained '), write(RandomItem), write('!!!'),nl, nl,
    addItemInv(RandomItem), shop, !.

/*Item yang dibeli bukan Gacha*/
input(X) :-
    harga(X,Item,Harga),
    min_gold(Harga),
    addItemInv(Item), shop, !.
/*=============================================================*/



/*=============================================================*/
                    /*FUNGSI TAMBAHAN*/
/*Untuk mengurangi Gold*/
min_gold(X):-
    gold(Gold),
    Gold1 is Gold - X,
    retract(gold(_)),
    asserta(gold(Gold1)), !.
/*=============================================================*/


