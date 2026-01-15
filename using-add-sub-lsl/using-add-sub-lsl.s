// example of using 
// - add 
// - sub 
// - lsl 
// - how to print integer to terminal
// It only run on Apple Silicon

// INFO: 
// ignore about label convert_to_ascii, i don't know the logic also, now it seem work on number 1 - 9 only

.global _main

_main:
    // Step 1: store number in x0
    mov     x0, #0         // number to print
    mov     x2, #5
    mov     x5, #2
    mov     x1, #1
    lsl     x3, x1, #1    // shift 1 bit so become 10 (binary) -> 2 (decimal)

    add     x0, x3, x2    // 2 + 5 = 7
    mov     x4, x0        // x4 = x0 = 7
    sub     x0, x4, x3    // x0 = 7 - 2 = 5

    // Step 2: convert number to ASCII
    bl      convert_to_ascii

    // Step 3: print the number
    bl      print_buffer

    // Step 4: exit program
    bl      exit_program

convert_to_ascii:
    adrp    x1, buffer@PAGE
    add     x1, x1, buffer@PAGEOFF
    add     w4, w0, #'0'    // number -> ASCII
    strb    w4, [x1]
    ret

print_buffer:
    mov     x0, #1           // stdout
    adrp    x1, buffer@PAGE
    add     x1, x1, buffer@PAGEOFF
    mov     x2, #1           // length = 1 byte
    mov     x16, #4          // syscall write
    svc     #0x80
    ret

exit_program:
    mov     x0, #0           // exit code
    mov     x16, #1          // syscall exit
    svc     #0x80
    ret

// ----------------------------
.data
buffer: .space 1
