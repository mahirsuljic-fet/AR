.section .data

.globl number
number: .word 42

.globl result
result: .word 0


.section .text

.globl main
main:
  # $s0 -> number
  # $s1 -> &result (adresa od result)

  la $s0, number          # ucitaj adresu od number u $s0
  la $s1, result          # ucitaj adresu od result u $s1
  lw $s0, ($s0)           # ucitaj vrijednost od number u $s0

  ############
  # PRVI DIO #
  ############

  # $t1 -> rezultat

  andi $t1, $s0, 0x0001   # izvuci zadnji bit iz $s0 i smjesti rezultat u $t1
  xori $t1, $t1, 0x0001   # flip-aj zadnji bit iz $t1
  sw $t1, ($s1)           # spremi rezultat u result
  
  KRAJ_PRVI:  # label za debagiranje (breakpoint)


  #############
  # DRUGI DIO #
  #############
  
  # number * 22 <=> number * (16 + 8 - 2)
  #             <=> number * 16 + number * 8 - number * 2
  #             <=> number << 4 + number << 3 - number << 1

  # $t1 -> rezultat
  # $t2 -> number << 4
  # $t3 -> number << 3
  # $t4 -> number << 1

  sll $t2, $s0, 4         # $t2 = number << 4
  sll $t3, $s0, 3         # $t3 = number << 3
  sll $t4, $s0, 1         # $t4 = number << 1

  addu $t1, $t2, $t3      # $t1 = number << 4 + number << 3
  subu $t1, $t1, $t4      # $t1 -= number << 1

  sw $t1, ($s1)           # spremi rezultat u result
  
  KRAJ_DRUGI:  # label za debagiranje (breakpoint)


  #############
  # TRECI DIO #
  #############
  
  # number * 7  <=> number * (8 - 1)
  #             <=> number * 8 - number
  #             <=> number << 3 - number

  # $t1 -> rezultat
  # $t2 -> number << 3

  sll $t2, $s0, 3         # $t2 = number << 3
  subu $t1, $t2, $s0      # $t1 = number << 3 - number
  sw $t1, ($s1)           # spremi rezultat u result

  KRAJ_TRECI:  # label za debagiranje (breakpoint)


  ###############
  # CETVRTI DIO #
  ###############

  # ostatak pri dijeljenju sa 8 ce biti zadnja tri bita broja
  # jer je 8 u binarnom zapisu 1000
  # u tu svrhu koristimo masku 0x7 (0b111)

  # $t1 -> rezultat

  andi $t1, $s0, 0x0007   # $t1 = $s0 % 8
  sw $t1, ($s1)           # spremi rezultat u result

  KRAJ_CETVRTI:  # label za debagiranje (breakpoint)


  ############
  # PETI DIO #
  ############

  # ostatak pri dijeljenju sa 32 ce biti zadnjih pet bitova broja
  # jer je 32 u binarnom zapisu 100000

  # $t1 -> rezultat

  andi $t1, $s0, 0x001F   # $t1 = $s0 % 32
  sw $t1, ($s1)           # spremi rezultat u result

  KRAJ_PETI:  # label za debagiranje (breakpoint)

  addiu $v0, $0, 0
  jr $ra
  nop
