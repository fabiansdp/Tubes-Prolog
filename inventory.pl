:- dynamic(itemInv/5). /* Item(class, type, nama, minlvl, +effect) atau Untuk potion: Item(class, type, nama, harga, +effect) */
:- dynamic(maxInventory/1). /*max inventory*/


/*Fungsi set inventory awal*/
set_invent :-
    asserta(maxInventory(100)). /*max inventory = 100*/


/*Menghitung jumlah item yang ada di dalam Inventory*/
banyakItemInventory(Item, Jml) :-
    findall(Item,itemInv(_, _, Item, _, _),ListInvent),
	length(ListInvent,Jml).



/*MEMASUKAN ITEM KE DALAM INVENTORY*/
/*Inventori tidak muat*/
addItemInv(_) :-
    banyakItemInventory(_, Jumlah),
    maxInventory(Max),
    (Jumlah >= Max),
    write("Inventory penuh!"), nl, !, fail.


/*Inventori muat*/
addItemInv(Item) :-
    item(_, _, Item, _, _),
    asserta(itemInv(_, _, Item, _, _)), !.



/*MEMBUANG ATAU MENGGUNAKAN ITEM DARI DALAM INVENTORY*/
/*Item tidak ada di Inventory*/
delItem(Item) :-
    \+itemInv(_, _, Item, _, _), !, fail.

/*Item ada di Inventory*/
delItem(Item) :-
    itemInv(_, _, Item, _, _),
    retract(itemInv(_, _, Item, _, _)), !.


/* Commands */
inventory :-
    write('Your Inventory: '), nl,!,
    itemInv(_, _, Item, _, _),
    banyakItemInventory(Item, Jml),
    write(Jml), write(' '),write(Item), nl, fail.

