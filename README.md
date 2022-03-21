# RVSoC

## Original

Developed by Kise Lab. in Tokyo Tech.

- [RVSoC Project, a portable and Linux capable RISC-V computer system on an FPGA](https://www.arch.cs.titech.ac.jp/wk/rvsoc/doku.php?id=start)
- [How to build the RISC-V cross compiler and RISC-V Linux binary files that works with RVSoC](https://www.arch.cs.titech.ac.jp/wk/rvsoc/doku.php?id=binary)

## How to start Linux

```
$ cd binary
$ python3 serial_sendfile.py --port=/dev/ttyUSB0 --rate=2000000 --image=initmem.bin
```
