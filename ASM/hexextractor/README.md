# Hexextractor

Here is a handy Perl script, [`hexextractor.pl`](https://github.com/greenonline/SpectrumMachineLanguageForTheAbsoluteBeginner/blob/main/ASM/hexextractor.pl) that takes the `.asm` file via STDIN and produces a [hex dump](https://github.com/greenonline/SpectrumMachineLanguageForTheAbsoluteBeginner/blob/main/ASM/freeway_frog.hex) on STDOUT.

Run using 

```none
cat freeway_frog_full.asm | perl hexextractor.pl -alcxwbs
```

Don't be surprised, when you run the script, if nothing is output. It is probably because you haven't told `hexextractor` to do anything yet! Pass the command line arguments `abclsu`, to turn on the full output.

Here is a [hex dump](https://github.com/greenonline/SpectrumMachineLanguageForTheAbsoluteBeginner/blob/main/ASM/freeway_frog.hex) sample:

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

## Command line options

These are also configurable via command line options/switches (`'abcdhlmsuvwx'`) - however, to do so, all of the default constants (see below) need to be set to zero.

The options are: 

```none
   -a               show ASCII table
   -b               blank empty memory locations
   -c               show hex dump
   -d               debug mode
   -h               brief help message
   -l               show addresses
   -m               full documentation
   -s               add spaces between hex bytes of code<sup>1</sup>
   -u               global uppercase
   -v               display version
   -w               uppercase addresses
   -x               uppercase code
```

## Permanent options

These might be more useful if you do not wish to repeatedly use the comand line options.

You can turn off the ASCII table generated on the right hand side by changing the line:
```none
    DO_ASCII => 1,                          # Enable additional ascii character dump
```
to
```none
    DO_ASCII => 0;                          # Disable additional ascii character dump
```
You can change the hex output to lower case by changing the line:
```none
    DO_CAPS => 1;                  # Enable upper case hex
```
to
```none
    DO_CAPS => 0;                  # Enable lower case hex
```
You can even configure both the addresses and the code differently, to be in either lower or upper case, by changing the following two lines:
```none
    DO_ADDRESS => 1,                        # Enable upper case hex for addresses
    DO_CODE => 1,                           # Enable upper case hex for code
```
This last modification may *seem* pointless, but trust me it isn't. It can alleviate the monotony of pure upper case characters. I recommend the following setting:
```none
    DO_ASCII => 1,                          # Enable additional ascii character dump
    DO_CAPS => 1;                           # Enable upper case hex
    DO_ADDRESS => 0,                        # Disable upper case hex for addresses, i.e. lower case.
    DO_CODE => 1,                           # Enable upper case hex for code (only).
```

You can also configure: blanking of empty memory locations; whether spaces seperate the hex bytes<sup>1</sup>; debug, show addresses/code/ASCII.


### Footnotes

<sup>1</sup> If `-s` is not used, and spaces between the bytes are suppressed, then, in certain circumstances, some bytes of *non_contiguous code* can lose their "location" and appear to be assigned to an incorrect address - if they are preceded by empty memory locations *AND* the blanking option is turned on. For this reason always use the `-s` option for correct byte alignment, visually.

For completely contiguous blocks of code, or if the blanking option is not applied, then the `-s` option can be safely not used.
