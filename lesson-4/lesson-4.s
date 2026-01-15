.global _main
.align 4

_main: 
  mov x1, #1
  mov x7, #2
  mov x8, #3

  cmp x7, x8
  bl func_comp_1

  mov x9, #10
  mov x10, #9

  cmp x9, x10
  bl func_comp_2

  bl exit_program

func_comp_1: 
  b.lt print_smaller
  b.eq print_equal
  b print_bigger

func_comp_2:
  b.lt print_smaller
  b.eq print_equal
  b print_bigger


exit_program:
  mov     x0, #0
  mov     x16, #1
  svc     #0x80

print_equal:
  mov     x0, #1
  adr     x1, equal
  mov     x2, #3
  mov     x16, #4
  svc     #0x80
  ret

print_smaller:
  mov     x0, #1
  adr     x1, smaller
  mov     x2, smaller_length
  mov     x16, #4
  svc     #0x80
  ret

print_bigger:
  mov     x0, #1
  adr     x1, bigger
  mov     x2, bigger_length
  mov     x16, #4
  svc     #0x80
  ret

bigger: .ascii "Bigger\n"
bigger_length = . - bigger

equal: .ascii "Equal\n"
equal_length = . - equal

smaller: .ascii "Smaller\n"
smaller_length = . - smaller


