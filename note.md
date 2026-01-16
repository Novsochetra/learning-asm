## Arm64 Assembly Learning

register **X0**->**X30** is for general purpose use
lower 32 bits can use **W0**->**W30**

### Special Register
- Program Counter (PC) => contain address of the next instruction to be execute
- Stack Pointer (SP) => (not yet understand)
- Frame Pointer (FP) = X29 => (not yet understand)
- Link Register (LR) = X30 => (not yet understand)
- Zero Register (XZR) => (not yet understand)
- Specifically on macos: X18 is reserved (do no use it)

### Arm64 has 4 level privilege for code execution:
- User Mode (USR) => least privilege, standard program execution
- Supervisor Mode (SVC) => kernel privilege
- other 2 not yet research

### Register X16
is the special register for syscall. the follow value is response for each task
- X16, #1 for exit
- X16, #2 for fork
- X16, #3 for read
- X16, #4 for write
- X16, #5 for open
- X16, #6 for close

### Register X0
has the following value:
- X0, #0 for stdin
- X0, #1 for stdout
- X0, #2 for stderr


### Instruction
- (ADR) for storing value
- (SVC) switching to kernel mode
- (MOV) moving value into specific register

### ARM64 Bit-Level Map: `mov X0, #0x1234`

in arm when we use mov behide the scene it will generate to use 1 of follow instruction it either (movz, movk, movn). so when we saw 1, 0 on column 30, 29 it mean we use **movz**([opc](https://arm.jonpalmisc.com/latest_aarch64/movz))

| Bit | 31 | 30 | 29 | 28 | 27 | 26 | 25 | 24 | 23 | 22 | 21 | 20 | 19 | 18 | 17 | 16 | 15 | 14 | 13 | 12 | 11 | 10 | 09 | 08 | 07 | 06 | 05 | 04 | 03 | 02 | 01 | 00 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Field** | sf | opc | opc | 1 | 0 | 0 | 1 | 0 | 1 | hw | hw | v | a | l | u | e | v | a | l | u | e | v | a | l | u | e | v | Rd | Rd | Rd | Rd | Rd |
| **Value** | **1** | **1** | **0** | **1** | **0** | **0** | **1** | **0** | **1** | **0** | **0** | **0** | **0** | **0** | **1** | **0** | **0** | **1** | **0** | **0** | **0** | **1** | **1** | **0** | **1** | **0** | **0** | **0** | **0** | **0** | **0** | **0** |

- **sf** has 1 bit (0 or 1). if 1 it mean it will use 64 bit, otherwise 32bit
- **hw** has 2 bit. since we value for store data is 16 bit ( 65535 ) when the value is exceed the hw value will be switch from 00 to 01 to allow more value store. look at the following table when value is exceed 16 bit.

    | Bit | 31 | 30 | 29 | 28 | 27 | 26 | 25 | 24 | 23 | 22 | 21 | 20 | 19 | 18 | 17 | 16 | 15 | 14 | 13 | 12 | 11 | 10 | 09 | 08 | 07 | 06 | 05 | 04 | 03 | 02 | 01 | 00 |
    | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
    | **Field** | sf | opc | opc | 1 | 0 | 0 | 1 | 0 | 1 | hw | hw | v | a | l | u | e | v | a | l | u | e | v | a | l | u | e | v | Rd | Rd | Rd | Rd | Rd |
    | **Value** | **1** | **1** | **0** | **1** | **0** | **0** | **1** | **0** | **1** | **0** | **1** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **0** | **1** | **0** | **0** | **0** | **0** | **0** |

### Variable
to declare variable we can just follow this formula:

```
LABEL_NAME: DATA_TYPE VALUE

ex:

mylabel: ascii "Hello ASM"
```

### Control Program Flow
- **cmp** to compare a register with another register or a 12-bit value


### Miscilinious

- when use `mov x1, #'0'` it seem telll the program to store value into regsiter **x1** with the value of #48 since the ascii of '0' is 48

### Trick For Debug
since we don't have privilege to access lldb for debugging, the only solution is to crash the appication with sys exit with the result of variable we want to debug. ex:

```asm
_main:
    mov x3, #20
    mov x4, #30

    add x5, x3, x4
    mov x0, x5


    b exit

exit:
    mov x16, #1
    svc 0x80
```

then we can run shell `echo $?` so it will print the exit code that previously program exit. the shell going to ouput `50`

