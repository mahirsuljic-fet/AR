lwc1 $f0, 0($t0)

########################################################################

li $t0, 4
mtc1 $t0, $f0   # u $f0 ce biti 4, ali ne u IEEE nego u two's complement
mfc1 $t0, $f0

mov.s $f0, $f13 # iz $f13 korpiraj u f0

########################################################################

cvt.X.Y $fd, $fs

X moze biti w s d (npr. cvt.w.Y ...)
Y moze biti w s d (npr. cvt.X.w ...)

li $t0, 4         # ucitaj 4 u $t0
mtc1 $f0, $t0     # premjesti 4 iz $t0 u $f0
cvt.s.w $f0, $f0  # prebaci word iz $f0 u single precision float u $f0

########################################################################

c.lt.s $f0, $f1   # $f0 < $f1
c.eq.d $f0, $f1   # $f0 == $f1

bc1t L1           # ako je rezultat zadnjeg poredjenja tacno idi na L1
foo
bar

L1:
  tar
