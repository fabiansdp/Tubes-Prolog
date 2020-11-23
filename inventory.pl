:- dynamic(itemInv/2). /* itemInv(Item,Jumlah) */
:- dynamic(maxInventory/1). /*max inventory*/


/*Fungsi set inventory awal*/
set_invent :-
    addItemInv('Red Potion'),
    addItemInv('Red Potion'),
    addItemInv('Red Potion'),
    addItemInv('Red Potion'),
    addItemInv('Red Potion'),
    asserta(maxInventory(100)). /*max inventory = 100*/


/*Menghitung jumlah item yang ada di dalam Inventory*/
banyakItemInventory(Item, Jml) :-
    findall(Item,itemInv(Item, _),ListInvent),
	length(ListInvent,Jml).



/*MEMASUKAN ITEM KE DALAM INVENTORY*/
/*Inventori tidak muat*/
addItemInv(_) :-
    banyakItemInventory(_, Jumlah),
    maxInventory(Max),
    (Jumlah >= Max),
    write("Inventory penuh!"), nl, !, fail.


/*Inventori muat*/
/* Belom ada item yang sama */
addItemInv(Item) :-
    item(_, _, Item, _, _),
    \+itemInv(Item,_),
    asserta(itemInv(Item,1)),!.

/* Sudah ada item yang sama */
addItemInv(Item) :-
    itemInv(Item, X),
    Y is X + 1,
    retract(itemInv(Item,X)),
    asserta(itemInv(Item,Y)), !.



/*MEMBUANG ATAU MENGGUNAKAN ITEM DARI DALAM INVENTORY*/
/*Item tidak ada di Inventory*/
delItemInv(Item) :-
    \+itemInv(Item,_), !, fail.

/*Item ada di Inventory*/
/* Jumlah item yang akan di delete ada 1 */
delItemInv(Item) :-
    itemInv(Item,X),
    X =:= 1,
    retract(itemInv(Item,X)), !.

/* Jumlah item yang akan di delete lebih dari 1 */
delItemInv(Item) :-
    itemInv(Item,X),
    Y is X - 1,
    retract(itemInv(Item,X)),
    asserta(itemInv(Item,Y)), !.



/* Commands */
inventory :-
    write('Your Inventory: '), nl,
    itemInv(Item,Jml),
    write(Jml), write(' '),write(Item), nl, fail.