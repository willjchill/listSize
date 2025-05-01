## Practicing Assembly NASM x86-64 on GNU/Linux

# Objective:
- Print out size of list in text file.

**Example:** 
>> cat list.txt
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
>> ./listSize $(cat list.txt)
0016

# Specifications:
- Only use syscalls, no external libraries other than assembler.
- Assemble to ELF64 exe.
- Intel syntax for assembly only.
