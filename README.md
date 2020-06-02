# Hello World in Assembly
Dipping my feet into programming at a lower level of computer architecture by understanding and writing hello world in x86 assembly.

It's really interesting to see how programming closer to the CPU is different to higher level languages I'm familiar with.

All explanations are above the code in the `hello_world.asm` file.
Comments are also present throughout the code itself.

## Compilation and Usage
This is also outlined in the preamble before the code, but:
- To assemble (using nasm 32-bit, `sudo apt install nasm` on debian based systems):
```bash
nasm -f elf32 -o hello_world.o  hello_world.asm
```
- To link (using ld, but you could use gcc instead if you wish):
```bash
ld -m elf_i386 -o hello_world hello_world.o
```
- To run, in the terminal:
```bash
./hello_world
```
That should yield `Hello World!`.

Screenshot:

![Screenshot](./terminal_output.png?raw=true "Screenshot of compilation and run output")
