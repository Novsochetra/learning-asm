.global _main
.align 4

_main:
  // ask question
  mov x0, #1
  adrp x1, question_1@PAGE
  add x1, x1, question_1@PAGEOFF
  mov x2, question_1_length
  mov x16, #4
  svc 0x80


  // listen to user input
  mov x0, #0
  adrp x1, buffer@PAGE
  add x1, x1, buffer@PAGEOFF
  mov x2, #1
  mov x16, #3
  svc 0x80

  // print message: you type: 
  mov x0, #1
  adrp x1, message@PAGE
  add x1, x1, message@PAGEOFF
  mov x2, message_length
  mov x16, #4
  svc 0x80

  // print the value from sys read
  mov x0, #1              
  adrp x1, buffer@PAGE    
  add x1, x1, buffer@PAGEOFF
  mov x2, #1
  mov x16, #4            
  svc 0x80

  // print new line
  mov x0, #1
  adrp x1, new_line@PAGE
  add x1, x1, new_line@PAGEOFF
  mov x2, new_line_length
  mov x16, #4
  svc 0x80

  // 3. Exit
  mov x16, #1
  svc 0x80


.data
buffer: .space 1

new_line: .ascii "\n"
new_line_length = . - new_line

message: .ascii "your luck number is: "
message_length = . - message

question_1: .ascii "please enter your lucky number(0 -> 10): "
question_1_length = . - question_1

