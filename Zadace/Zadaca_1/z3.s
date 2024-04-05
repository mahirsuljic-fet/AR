.section .text

.globl main
main:
  # maska
  # 0b0111'0111'1111'1111"1011'1111'1111'1110
  # 0x77FFBFFE

  # $t0 -> proizvoljan broj
  # $t1 -> maska

  # ucitajemo neki proizvoljan broj u $t0
  lui $t0, 0xAAAA
  ori $t0, $t0, 0xAAAA

  # ucitajemo masku u $t1
  lui $t1, 0x77FF
  ori $t1, $t1, 0xBFFE

  # resetovanje bita
  and $v0, $t0, $t1
  
  jr $ra
  nop
