## TAP files

### BASIC

#### BASIC files from the book

The files for:

 - HEXLOAD
 - EZCODE
 - CHECKSUM

are loaded using `LOAD ""`.

#### Frogger

Likewise for the bonus `frogger.tap`, load with `LOAD ""`. Run with `RUN 2000`.

### ASM

Note that the assembler version of Frogger - *Freeway Frog* - from the book, needs to be loaded with `LOAD "" CODE`. To run:

```none
10 LET L=USR 27000
```

From [General info for: Spectrum Machine Language for the Absolute Beginner \[#ID: 23574\]](https://spectrumcomputing.co.uk/entry/23574/ZX-Spectrum/Spectrum_Machine_Language_for_the_Absolute_Beginner) / [`SpectrumMachineLanguageForTheAbsoluteBeginner(EN).txt`](https://spectrumcomputing.co.uk/zxdb/sinclair/entries/0023574/SpectrumMachineLanguageForTheAbsoluteBeginner(EN).txt):

> FREEWAY FROG program
> 
> The entire machine code program. The program occupies from 6978H to 781DH (27000 to 31005). Type (LOAD "" CODE (ENTER)) to load the 
program from tape. Then Type (LET L=USR 27000 (ENTER)) to run the program.
> 
> Controls: "1" to move up, "A" to move down, "I" to move left and "P" to move right.
> 
> To turn off sound of police-car, type (ENTER) during the game. To exit the game, type (BREAK).
