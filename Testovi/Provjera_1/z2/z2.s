.section .text

.globl main
main:
  # legenda
  # $t0 = t0
  # $t1 = t1
  # $t2 - konstante 40000 i 80000
  # $t3 - rezultat uslova if-a i else if-a
  
  # t0 = 0xDEADBEEF;
  lui $t0, 0xDEAD       # ucitavanje 0xDEAD u prvih 16 bita $t0
  ori $t0, $t0, 0xBEEF  # ucitavanje 0xBEEF u zadnjih 16 bita $t0
  
  # buduci da ce u svakom slucaju (if, else if i else)
  # prvih 16 bita $t1 biti 0xDEAD mozemo to odma ucitati
  lui $t1, 0xDEAD
  
  # if
  addiu $t2, $0, 40000  # $t2 = 40000
  slt $t3, $t2, $t0     # $t3 = $t0 > $t2   (uslov t0 > 40000)

  beq $t3, $0, else_if  # ako je $t3 == $0 znaci da $t0 nije vece od 40000
  
  # t1 = 0xDEADC0DE     (s tim da je 0xDEAD vec ucitano u $t1)
  ori $t1, $t1, 0xC0DE  # ucitavanje 0xC0DE u zadnjih 16 bita $t1
  j izlaz
  nop

  else_if:
  # 80000 mozemo u registar ucitati tako sto 
  # ucitamo 40000 (sto moze stati u 16 bita) pa zatim dodamo 40000
  ori $t2, $0, 40000    # $t2 = 40000
  sll $t2, $t2, 1       # $t2 *= 2 -> $t2 = 80000
  slt $t3, $t2, $t0     # $t3 = $t0 > $t2   (uslov t0 > 40000)

  beq $t3, $0, else     # ako je $t3 == $0 znaci da $t0 nije vece od 80000
  
  # t1 = 0xDEAD2BAD     (s tim da je 0xDEAD vec ucitano u $t1)
  ori $t1, $t1, 0x2BAD  # ucitavanje 0x2BAD u zadnjih 16 bita $t1
  j izlaz
  nop

  else:
  # t1 = 0xDEADD00D     (s tim da je 0xDEAD vec ucitano u $t1)
  ori $t1, $t1, 0xD00D  # ucitavanje 0xD00D u zadnjih 16 bita $t1

  izlaz:

  # return 0
  addiu $v0, $0, 0
  jr $ra
  nop
