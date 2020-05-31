# M68k
Messing around trying to get Motorola 68k Assemblers building.


## Using Windows Build tools
### ASM68k
Example of building a `.s` source file with ASM68k.  
In the `asm68k` folder there's a `asm68k` executable:
```
./asm68k /p /i /w /ov+ /oos+ /oop+ /oow+ /ooz+ /ooaq+ /oosq+ /oomq+ /ow+ sourceFile.s,sourceFile.bin,sourceFile.sym
```
The directory you run `asm68k` from is mapped into the container.

### Gens KMod Emulator
You can then run the generated bin file with the `gens_kmod` emulator:
```
export WIN_BASE='C:\users\root\My Documents\project'
./gens.exe "${WIN_BASE}\bin\sourceFile.bin"
```
The directory you run `gens.exe` from is mapped into the container under `WIN_BASE`.
It runs poorly, you'll see frame tearing.
