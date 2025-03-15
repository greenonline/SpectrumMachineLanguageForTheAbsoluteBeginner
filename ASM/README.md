Freeway Frog (from the book) assembler listing.

Please note that, in order to save myself some typing, `freeway_frog_full.asm` is derived from the `.asm` source file provided in [Pasmo listing for Freeway Frog from Spectrum Machine Language for the Absolute Beginner](https://www.sinclairzxworld.com/viewtopic.php?t=5583):

 - [freeway_frog.asm](https://www.sinclairzxworld.com/download/file.php?id=15045&sid=76a2585fce4b904fa2523b187e1830ec)

Additional features:

 - Hex address
 - Hex dump
 - line numbers
 - Reorganisation of labels

There is a mixture of lower and upper case used. This is because the original `.asm` file was in lower case, and the new columns that I added are in upper case, as per the assembly listing in the book. This can be fixed by a simple case switching in your favourite text editor, or text editing tool.

Here is a handy Perl script, [`hexextractor.pl`](https://github.com/greenonline/SpectrumMachineLanguageForTheAbsoluteBeginner/blob/main/ASM/hexextractor.pl) that takes the `.asm` file via STDIN and produces a [hex dump](https://github.com/greenonline/SpectrumMachineLanguageForTheAbsoluteBeginner/blob/main/ASM/freeway_frog.hex) on STDOUT.

Run using 

```none
cat freeway_frog_full.asm | perl hexextractor.pl
```

[hex dump](https://github.com/greenonline/SpectrumMachineLanguageForTheAbsoluteBeginner/blob/main/ASM/freeway_frog.hex) sample:

```none
6978: F3 D9 E5 D9 CD 83 6F CD  ......o.
6980: BD 70 CD 50 74 CD 0F 71  .p.Pt..q
6988: CD 4A 73 CD C2 74 CD 1D  .Js..t..
6990: 77 CD 87 77 3A 77 6F A7  w..w:wo.
6998: 20 05 CD DE 77 18 DD 3E  ....w..>
69A0: 7F DB FE E6 01 20 D8 CD  .......
69A8: FE 77 D9 E1 D9 FB C9 B7  .w......
...
7800: 32 48 5C 21 00 40 11 01  2H\!.@..
7808: 40 01 FF 17 36 00 ED B0  @...6...
7810: 21 00 58 11 01 58 01 FF  !.X..X..
7818: 02 36 38 ED B0 C9        .68.....
```
You can turn off the ASCII table generated on the right hand side by changing the line:
```none
our $do_ascii = 1;                          # Enable additional ascii character dump
```
to
```none
our $do_ascii = 0;                          # Disable additional ascii character dump
```
You can change the hex output to lower case by changing the line:
```none
our $do_caps = 1;                           # Enable upper case hex
```
to
```none
our $do_caps = 0;                           # Enable lower case hex
```

