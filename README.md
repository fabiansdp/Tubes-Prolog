# Tugas Besar Logika Komputasional IF2121
> Permainan Adventure dengan Bahasa Prolog

## Daftar Isi
* [Kontributor](#kontributor)
* [Penjelasan](#penjelasan)

## Kontributor
1. Fabian Savero Diaz Pranoto
2. Hafid Abi Daniswara
3. Pratama Andiko
4. Syamil Cholid A.

## Penjelasan
Kamu adalah seorang yang terdampar di sebuah pulau terpencil. Setelah bertanya-tanya ke warga setempat, masalah utama warga itu adalah Naga Hitam yang memperbudak mereka. Bantulah mereka untuk membasmi naga itu!

## Cara Memulai
Pertama, compile file startgame:
```
?- [startgame].
yes
```
Lalu masukkan command start ke dalam terminal dan pilih kelas:
```
?- start.
=======SELAMAT DATANG=======
Masyarakat kami sudah bertahun-tahun takut dengan kekuatan Naga Hitam
Tolong bantulah kami untuk membasmi Naga Hitam!

Pilih Kelas: 
1. Swordsman 
2. Archer 
3. Magician 
1.

Kamu pilih Swordsman!
```
## List Command
1. help\
Menampilkan daftar command
```
| ?- help.
Daftar Command:
1. w (Maju)
2. a (Kiri)
3. s (Mundur)
4. d (Kanan)
5. heal (Pulihkan HP dan Mana)
6. legend (Lihat legend map)
7. status (Lihat Stat)
8. inventory (Lihat Inventory)
9. checkquest (Check Status Quest)
```
2. heal (Hanya bisa dilakukan di luar battle)\
Memulihkan HP dan mana pemain.
```
| ?- heal.
Semua lukamu hilang!
```
3. legend\
Menampilkan legend peta.
```
| ?- legend.
######################
#P------------#Q-----#
#---------E---#S-----#
#-------------#------#
#-#####-------##-----#
#-Q--E---------------#
##############---#####
#--GE-------#--E-----#
#Q####------#--------#
#-#-------#####------#
#-#------------------#
#---------Q----------#
#---##################
#---#Q----------#E--T#
#---#####-------#-####
#---#-----------#E---#
#---#-----------####-#
#--------------------#
#--------------------#
#######---E----------#
#Q--------G---------D#
######################
P = Player
E = Enemy
G = Teleport
S = Shop
D = Boss
Q = Quest
T = ?????
```
4. status\
Menampilkan status pemain.
```
| ?- status.
Level: 1
Class: Swordsman
Weapon: Beginner Sword
Armor: Beginner Armor
HP: 100/100
Mana: 50/50
Attack: 10
Defense: 20
XP: 0/10
Gold: 0
```
5. inventory\
Membuka inventory pemain.
```
| ?- inventory.
Inventory: 
5 Red Potion
```
6. checkquest\
Mengecek quest yang sedang dijalani.
```
| ?- checkquest.
Status Quest:
Slime: 0/3
Goblin: 0/0
Wolf: 0/0
```

## Mekanisme Game
Game ini merupakan sebuah adventure based game dengan sistem leveling yang mirip dengan game RPG. 

### Mekanisme Eksplorasi
Untuk mekanisme eksplorasi, pemain memakai command wasd untuk menggerakkan avatar-nya
di map 2D ini. Juga diterapkan sebuah titik teleport di dalam map. Pemain juga dapat menemukan sebuah harta karun yang disembunyikan di dalam map.

### Mekanisme Battle
Untuk mekanisme battle, game ini memakai sistem turn based yang sederhana. Command-command yang tersedia di mode battle :
1. attack\
Pemain akan menyerang dan menimbulkan damage sebesar attack dikurangi defense musuh.
2. flee\
Pemain dapat melarikan diri dari musuh dengan peluang 50%. Jika gagal, turn player akan habis dan diganti turn musuh.
3. specialattack\
Pemain dapat mengeluarkan special attack yang spesifik dengan class masing-masing.
4. status\
Melihat status pemain.
5. redpotion\
Memakai red potion.
6. bluepotion\
Memakai blue potion.
7. enragepotion\
Memakai enrage potion.
8. defensepotion\
Memakai defense potion.
9. help\
Menampilkan daftar command.
