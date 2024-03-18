.section .text

foo:
  // ...  
  jr $ra

main:
  jal foo
  jal printf # treba jos proslijedit argumente, ali to cemo kasnije
  jal foo
  jal printf # treba jos proslijedit argumente, ali to cemo kasnije
