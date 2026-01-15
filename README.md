

## How to compile program

1. generate the object file `as -arch arm64 -o using-add-sub-lsl.o using-add-sub-lsl.s` 
2. generate executable file `ld -o using-add-sub-lsl using-add-sub-lsl.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch arm64`
