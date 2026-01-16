.global _main
.align 4

_main:
  mov x0, #1

  mov x5, #35
  mov x6, #10

  // modular syntax
  udiv x7, x5, x6
  mul x8, x7, x6
  sub x9, x5, x8
  add x10, x9, #'0'  // => 48 + 2 => 50 ascii

  // Step 3: store in buffer
  adrp x1, buffer@PAGE
  add x1, x1, buffer@PAGEOFF
  strb w10, [x1]

  // sysout
  mov x2, #2
  mov x16, #4
  svc 0x80

  mov x0, #1
  b exit

exit:
  // mov x0, #1
  mov x16, #1
  svc 0x80

.data
buffer: .space 1
