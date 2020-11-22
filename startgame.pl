:- dynamic(enginestats/1).
enginestats(0).
start :-
    enginestats(1),
    write("in game situation"),nl,!;
    write("selamat datang di tokemon"),nl,
    write("ketikkan help untuk bantuan"),nl,
    write("ketikkan start sekali lagi untuk mulai game"),nl,
    asserta(enginestats(1)),!.

    

help :-
    write("daftar perintah : "),nl,
    write("w untuk maju "),nl,ss
    write("a untuk kanan "),nl,
    write("s untuk mundur "),nl,
    write("d untuk kiri "),nl,
    write(" "),nl,
    write(" "),nl,
    write(" "),nl,
    write(" "),nl.




quit:-
    write("thanks for using this program"),nl,
    write("arigatouuu"),nl.