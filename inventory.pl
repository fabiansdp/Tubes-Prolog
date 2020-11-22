:- include('item.pl').


:- dynamic(itemInv/5).
:- dynamic(maxInventory/1).



init_invent :-
    asserta(maxInventory(100)). 

# Menghitung jumlah item yang ada di dalam Inventory
banyakItemInventory(Jml) :-
    findall(Item,itemInv(_, _, Item, _, _),ListInvent),
	length(ListInvent,Jml).



#MEMASUKAN ITEM KE DALAM INVENTORY

# Inventori tidak muat
addItemInv(Item) :-
    banyakItemInventory(Jumlah),
    maxInventory(Max),
    (Jumlah >= Max),
    write("Inventory penuh!"), nl, !, fail.

# Inventori muat
addItemInv(Item) :-
    item(_, _, Item, _, _),
    asserta(itemInv(_, _, Item, _, _)), !.



#MEMBUANG ITEM DARI DALAM INVENTORY

# Item tidak ada di Inventory
buangItem(Item) :-
    \+itemInv(_, _, Item, _, _), !, fail.

# Item ada di Inventory
buangItem(Item) :-
    itemInv(_, _, Item, _, _),
    retract(itemInv(_, _, Item, _, _)), !.




