1 REM FROGGER
2 REM by Andrew Pennell
5 POKE 23658,8
10 GO TO 900
20 FOR I= 1 TO 6 
30 LET X(I)=5*INT (RND*31)+1 
40 NEXT I
50 PRINT VAL$ Q$
60 LET A=20
100 LET X=16: LET Y=19
110 PRINT AT Y, X; INK 4; "?"
120 PAUSE 20
130 PRINT VAL$ Q$
140 FOR I=1 TO 6: LET X(I)=X(I)-10*(I/2=INT (I/2))+5
150 LET X(I)=X(I)-160*(X(I)>160)+160*(X(I)<5): NEXT I
160 PRINT VAL$ Q$: IF Y>9 THEN GO TO 200
170 LET X=X+(A=40)-(A=43): IF X<0 OR X>31 THEN GO TO 400
180 PRINT AT Y,X; PAPER 5; INK 4; "?"
200 LET B = ATTR (Y,X): IF B=5 OR B=6 THEN GOTO 400
205 LET T=T-1: PLOT OVER 1;32+T,12
206 IF T=0 THEN LET F=1: GO TO 400
210 LET XX=X : LET YY=Y : LET K$=INKEY$
220 IF K$="" THEN PRINT AT Y,X; PAPER 8; INK 4; "???": GO TO 140
225 BEEP .02, -10
230 LET X=X+(K$="G")-(K$="F"):IF Y=21 THEN LET Y=19
240 IF X<0 OR X>31 THEN GO TO 400
250 LET Y=T+3*(K$="V")-2*(K$="T"): IF Y=21 THEN LET Y=19
260 IF K$="T" THEN LET S=S+5: PRINT AT 0,6;S
280 IF A=160 OR A=47 OR A=5 OR A=6 THEN GO TO 400
290 PRINT AT Y,X;PAPER 8; INK 4; "???"
300 IF A<>56 THEN GO TO 140
305 PRINT VAL$ Q$
310 LET I=8*INT (X/8)+3; PRINT AT 2,I; INK 4 ; " ??? ";AT 3,I;" ??? "
315 LET S=S+50: PRINT AT 0,6;S
320 BEEP 2,10
330 LET FF=FF+1 : IF FF=4 THEN GO SUB 500
340 GO TO 20
400 PRINT VAL$ Q$ 
405 PRINT AT Y,X+(X<0)-(X>31);INK 8; PAPER 8; FLASH 1; OVER 1; "?"
410 PRINT AT 0,10+2*F;" ":BEEP 3,-10
415 LET F=F-1
420 IF F=0 THEN GO TO 600
430 PRINT AT Y,X+(X<0)-(X>31);INK 8;PAPER 8;OVER 1; "?"
440 GO TO 20
500 FOR I=3 TO 30 STEP 8
510 PRINT AT 2,I; "  ";AT 3,I;"  ":NEXT I
520 LET FF=0: IF F=4 THEN GO TO 525
522 LET F=F+1:PRINT AT 0,10+2*F; INK 4; "©"
525 FOR T=T TO 120: PLOT 32+T,12: BEEP .01,T/10: NEXT T
530 IF S<>0 THEN LET S=S+100:PRINT AT 0,6;S
540 RETURN
600 PRINT AT 0,12; "        "
610 PRINT AT 11,8;" YOU SCORED ";S;" "
620 IF S<HS THEN GO TO 700
630 PRINT AT 11,20 ;FLASH 1;S
640 PRINT AT 12,6;" A NEW HIGH SCORE!!! "
645 FOR I=1 TO 5: FOR J=5 TO 10: BEEP .05,J+I: NEXT J: NEXT I
650 DIM N$(6):INPUT "Enter your name (max 6 letters):";N$
660 POKE USR "Q",S-256*INT(S/256):POKE USR "Q"+1, INT (S/256)
670 FOR I=1 TO 6
680 POKE USR "Q"+1+I, CODE N$(I)
690 NEXT I
700 PRINT AT 19,0; FLASH 1;"Enter RUN for another game.  ": GO TO 16000
900 INK 0: PAPER 7: BORDER 7: CLS
905 PRINT AT 1,8;PAPER 1;TAB 31;" "
910 FOR I=2 TO 3: PRINT AT I,0;PAPER 1;"   ";AT I,5;"      "
920 PRINT AT I,13;PAPER 1;"      ";AT I,21;"       ";AT I,29;"   ": NEXT I
930 PRINT AT 0,0;"SCORE:0"
940 PRINT AT 0,12; INK 4; "??? ??? ??? ???"
950 FOR I=4 TO 10: PRINT AT I,0; PAPER 5;TAB 31;" ":NEXT I
960 FOR I=12 TO 18: PRINT AT I,0; PAPER 0; INK 7;TAB 31;" ": NEXT I
965 PRINT AT 11,0; BRIGHT 1;TAB 31;" ";AT 19,0;TAB 31;" "
970 FOR I=76 TO 28 STEP -16
975 FOR J=0 TO 249 STEP 8
980 PLOT J,I: DRAW INK 7;5,0
985 NEXT J: NEXT I
990 LET T=0: LET S=0: LET F=4
995 LET HS=PEEK USR "Q"+256*PEEK(USR"Q"+1)
1000 DIM N$(6): FOR I=1 TO 6: LET N$(I)=CHR$ PEEK (USR"Q"+1*I): NEXT I
1005 PRINT AT 20,0;"TIME";AT 21,0;"HIGH SCORE:";HS;" by ";N$
1010 DIM A$(13,3): DIM X(6): DIM Y(6): DIM P$(6,160)
1020 FOR I=1 TO 13
1030 READ J,K:LET A$(I)=CHR$ 16+CHR$ J+CHR$ K
1040 NEXT I
1050 FOR I=1 TO 6
1055 LET P=5: IF I>3 THEN LET P=0
1060 FOR J=1 TO 32
1070 READ A: LET P$(I,J*5-4 TO J*5)=CHR$ 17+CHR$ P+A$(A)
1075 BEEP .01,(J+32*I)/10
1080 NEXT J: LET Y(I)=2*I+3+2*(I>3)
1090 NEXT I
1120 LET Q$=""
1130 FOR I=1 TO 6
1135 BEEP .3, I*3
1140 LET Q$=Q$+"CHR$ 22+CHR$ "+STR$ Y(I)+"+CHR$ 0+P$("+STR$ I+",X("+STR$ I+") TO )+P$("+STR$ I+", TO X("+STR$ I+")-1)"
1150 IF I<>6 THEN LET Q$=Q$+"+"
1160 NEXT I
1165 GO SUB 500
1170 GO TO 20
1500 DATA 5,144,6,146,0,147,0,144,0,148
1510 DATA 6,149,6,150,3,159,3,158
1520 DATA 6,153,6,157,6,156,7,32
1530 DATA 13,13,8,9,13,13,8,9,12,12,12,12,8,9,13,13,8,9,13,13,13,8,9,13,13,13,8,9,13,13,13,13
1540 DATA 13,13,3,4,5,13,13,13,3,4,4,4,5,13,13,13,13,3,5,13,13,13,3,4,5,13,13,3,4,5,13,13
1550 DATA 13,8,9,13,13,13,8,9,13,8,9,13,13,8,9,13,13,13,8,9,13,13,13,8,9,13,8,9,13,13,8,9
1560 DATA 13,6,7,13,13,6,7,13,13,13,6,7,13,13,13,6,7,13,13,13,13,13,6,7,13,13,6,7,13,13,6,7
1570 DATA 13,13,13,11,12,13,13,13,13,10,1,13,13,13,11,12,13,13,13,11,12,13,13,13,13,10,1,1,13,13,13,13
1580 DATA 13,1,1,2,13,13,13,6,7,13,13,13,13,13,13,1,1,1,2,13,13,13,13,13,13,13,5,7,13,13,13,13
2000 RESTORE 2500
2010 FOR I=USR "A" TO USR "Q"+7
2020 READ A: POKE I, A
2030 NEXT I
2040 RUN
2500 DATA 255,255,255,255,255,255,255,255
2510 DATA 153,189,126, 126,126,60,165,195
2520 DATA 0,124,247,247,247,247,124,0
2530 DATA 63,127,127,255,255,127,127,53
2540 DATA 252,254,254,255,255,254,254,252
2550 DATA 56,255,255,255,255,255,255,56
2560 DATA 56,255,159,159,159,159,255,56
2570 DATA 0,0,0,0,1,11,7,7
2580 DATA 0,0,0,0,128,208,224,224
2590 DATA 0,62,239,239,239,239,62,0
2600 DATA 7,3,10,12,0,0,0,0
2610 DATA 224,192,80,48,0,0,0,0
2620 DATA 28,255,255,255,255,255,255,28
2630 DATA 28,255,249,249,249,249,255,20
2640 DATA 12,208,240,252,240,240,208,12
2650 DATA 12,7,15,127,127,15,7,12
2660 DATA 0,0,78,79,45,79,78,69
