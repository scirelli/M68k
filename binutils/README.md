### Setup Instructions
* https://darkdust.net/writings/megadrive/crosscompiler

```
docker run --rm -it --entrypoint sh -v /tmp/t:/tmp/t m68k-coff-gcc:latest
docker run --rm asl:latest /tmp/t/gamehut.s
```

### Home page
* http://www.gnu.org/software/binutils/

### Source zips
* http://ftp.gnu.org/gnu/binutils/
* https://ftp.gnu.org/gnu/gcc/
* https://gcc.gnu.org/git.html

### Newlib
* https://sourceware.org/newlib/

### References
* https://stackoverflow.com/a/11642624/808603

### Gitrepos
* https://sourceware.org/git/binutils-gdb
* https://gcc.gnu.org/git/gcc.git
