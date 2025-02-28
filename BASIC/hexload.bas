100 REM
110 REM monitor program
120 CLEAR 26999: LET ze = PI - PI: LET on = PI / PI:LET tw = on + on:LET qk = 256: LET lm = 27000: LET mr = 140: LET wl = 340
130 GO SUB 2000
140 CLS:PRINT "Start of machine code area = ";lm
150 PRINT "menu" : PRINT : PRINT "    Write machine code.........1"
160 PRINT : PRINT "    Save  machine code.........2"
170 PRINT : PRINT "    Load  machine code.........3"
180 PRINT : PRINT "    List  machine code.........4"
190 PRINT : PRINT "    Move  machine code.........5"
200 PRINT : PRINT "Please press appropriate key."
210 LET g$ = INKEY$
220 IF g$ = "m" OR g$ = "M" THEN STOP
230 IF g$ = "" OR g$ < "1" OR g$ > "5" THEN GO TO 210
240 CLS:PRINT "Start of machine code area = " ; lm
250 GO TO 300*VAL g$
300 REM INV Write****************** TRU
310 INPUT "Write to address :"; d
320 IF d > mm OR d < lm THEN GO TO 310
330 PRINT : PRINT "Write Address : "; d : PRINT "To return to menu enter ""m"""
340 LET a$ = ""
350 IF a$ = "" THEN INPUT "Enter hex. code :";a$
360 IF a$(on) = "m" OR as(on) = "M" THEN GO TO mr
370 IF LEN a$/tw <> INT (LEN a$/tw) THEN PRINT "Incorrect entry ";: GO TO wl
380 LET c = ze
390 FOR f = 16 TO on STEP -15
400 LET a = CODE a$((f=16)+tw*(f = on))
410 IF a < 48 OR a> 102 OR (a>57 AND a< 65) OR (a > 90 and a<97) THEN PRINT "Incorrect entry ";: GO TO wl
420 LET c = c+f*((a < 58)*(a-48)+(a >64 AND a < 71)*(a-55_+(a>96)*(a-87))
430 NEXT f : POKE d, c: LET d = d+on
440 PRINT a$(TO tw); "  ";
450 LET a$ = a$(3 TO )
460 IF d = UDG THEN PRINT "Warning : uyou are now in the user graphics area!":GO TO wl
470 IF d = UDG-20 THEN PRINT "Warning : you are now in routines memory area!":GO TO wl
480 GO TO wl+on
600 REM INV Save*************** TRU
610 INPUT "Save M.C. from address :";a
620 INPUT "Number of bytes to be saved :";n
630 INPUT "Name of the routine :"; a$
640 SAVE a$ CODE a, n
650 PRINT "Do you wish to verify?"
660 INPUT v$
670 IF v$ <> "y" THEN GO TO mr
680 PRINT "Rewind tape an press ""PLAY""."
690 VERIFY a$ CODE a, n
700 PRINT "O.K.": PAUSE 50
710 GO TO mr
900 REM INV Load*************** TRU
910 INPUT "Load M.C. to address starting.  : ";a
920 IF a > mm OR a <lm THEN GO TO 910
930 INPUT "Program name:"; a$
940 PRINT "Press ""PLAY"" on tape."
950 LOAD a$ CODE a,n: GO TO mr
1200 REM INV List*************** TRU
1210 LET a$ = "0123456789ABCDEF"
1220 INPUT "List Address :";d
1230 PRINT "Press ""M"" to return to Menu."
1240 LET a = INT (PEEK d/16) : LET b = PEEK d-16 * INT (PEEK d/16)
1250 PRINT d; TAB 7; a$(a+on);a$(b+on)
1260 LET d = d+on
1270 IF INKEY$ = "m" OR INKEY$ = "M" THEN GO TO mr
1280 GO TO 1240
1500 REM INV Move*************** TRU
1510 INPUT "Move from memory : "; fm
1520 INPUT "Move until memory : "; um
1530 INPUT "Move to memory : " ; tm
1540 IF tm > fm THEN GO TO 1610
1550 LET mo = tm
1560 FOR I = fm TO um
1570 POKE mp, PEEK I
1580 LET mp = mp + on
1590 NEXT I
1600 GO TO mr
1610 LET mp = um + tm - fm
1620 FOR I = um TO fm STEP -on
1630 POKE mp, PEEK I
1640 LET mp = mp - on
1650 NEXT I
1660 GO TO mr
2000 LET RT = PEEK 23732+qk*PEEK 23722
2010 IF RT = 65535 THEN LET mm = 65347: LET UDG = 65367
2015 LET mm = 65347: LET UDG = 65367
2020 IF RT = 32767 THEN LET mm = 32579: LET UDG = 32599
2030 LET nl = INT (UDG/qk)
2040 POKE 23675,UDG-nl*qk:POKE 23676, nl
3050 RETURN

