100 REM machine
110 REM machine code monitor
120 GO TO 9000
130 DEF FN d(s$) = (s$ > "9")*(CODE s$-55) + (s$ <= "9")*( CODE s$-48) -(s$ > "'")* 32
140 DEF FN o(O$) = ((O$ = "ca")+(O$ = "da") + (O$ = "ea")+(O$ = "fa")+(O$="c2")+(O$="c3"))-((O$ = "38")+(O$="30")+(O$ = "28")+(O$="20")+(O$="18")+(O$="10"))
1000 REM
1010 REM  INV LOINE PRINTING routine TRU
1020 CLS : PRINT AT ze, 25; INVERSE on; FLASH on; "LISTING TRU "
1030 LET F = ze : PRINT AT ze, ze;
1040 FOR J = pl1 to pl2
1050 IF C$(J, on) = "  " THEN GO TO 1110
1060 PRINT TAB tr - LEN STR$ J; J; TAB fr; " ';
1070 IF C$(J, tw, on, TO on) = "1" THEN PRINT C$(J, on) + " " +C$(J, tw)+C$(J, tr): GO TO 1090
1080 PRINT C$ (J, on); " "; C$(J, tw); " "; C$(J, tr); " '; C$(J, fr)
1090 LET F = F+on
1100 IF F = 22 THEN GO TO 1120
1110 NEXT J
1120 PRINT AT ze, 25; "       "
1130 RETURN
2000 REM
2010 REM INV main routine TRU
2020 INPUT "Command or Line(###) : "; A$
2030 IF A$ (TO fr) = "    " THEN GO TO mr
2040 IF A$(on) > "9" THEN GO TO 3000
2050 LET K$ = "" : FOR K = on TO fr
2060 IF A$(K TO K) = " ' THEN GO TO 2090
2070 LET K$ = K$+A$(K TO K)
2080 NEXT K
2090 IF K = 5 OR VAL K$ = ze OR VAL K$ > lm THEN GO TO mr
2100 LET J = VAL K$ : LET n = J : REM line number must be 3 bytes
2110 LET A$ = A$ (K+on TO )
2120 LET K$ = ""
2130 FOR k = on TO LEN A$
2140 IF A$(K TO K) <> " " THEN LET K$ = K$+A$(K TO K)
2150 NEXT K
2160 LET A$ = K$
2162 IF A$(on) ="1" THEN GO TO mr
2170 CLS: FOR I = on TO 7 STEP tw
2180 LET K = INT (I/tw+on)
2190 LET C$(J,K) = A$(I TO I+on)
2200 NEXT I
2210 IF C$(n, on) = "  " THEN GO TO 2250
2220 IF n < TP THEN LET TP = n
2230 IF n > BP THEN LET BP = n
2240 GO TO 2320
2250 IF n <> BP THEN GO TO 2280
2260 IF BP = on OR C$(BP, on) <> "  " THEN GO TO 2320
2270 LET BP = BP-on: GO TO 2260
2280 IF n <> TP THEN GO TO 2320
2290 IF C$(TP, on) <> "  " THEN GO TO 2320
2300 IF TP <> BP AND TP <> lm THEN LET TP = TP + on: GO TO 2290
2310 LET TP = on
2320 LET pp = n
2330 IF n < TP THEN LET pp = TP : GO TO 2380
2340 LET numlp = ze
2350 IF pp = TP OR numlp = 11 THEN GO TO 2380
2360 IF C$ (pp, on) <> "  " THEN LET numlp = numlp + on
2370 LET pp = pp - on : GO TO 2350
2380 LET pl1 = pp : LET pl2 = BP
2390 GO SUB 1000 : REM print a block of lines
2400 GO TO mr
3000 REM
3010 REM INV Commands*************** TRU
3020 LET K$ = A$(TO tw)
3030 IF K$ = "du" THEN GO TO 5000
3040 IF K$ = "ex" THEN STOP
3050 IF K$ = "li" THEN GO TO 4000
3060 IF K$ = "lo" THEN GO TO 7000
3070 IF K$ = "me" THEN GO TO 6000
3080 IF K$ = "ne" THEN RUN
3090 IF K$ = "ru" THEN PRINT USR R
3100 IF K$ = "sa" THEN GO TO 8000
3110 GO TO mr
4000 REM
4010 REM INV List routine*********** TRU
4020 LET pl1 = TP : LET pl2 = BP
4030 LET n1 = CODE A$(6 TO 6)
4040 IF LEN A$ > fr AND n1 > 47 and n1 < 58 THEN LET pl1 = VAL A$(5 TO 8)
4050 GO SUB 1000
5000 REM
5010 REM INV DUMP routine*********** TRU
5020 CLS : PRINT AT ze, 25; INK on; INVERSE on; FLASH on; "DUMPING" : LET G = R
5030 PRINT AT on, ze;
5040 FOR J = TP TO BP
5050 IF C$(J, on) = "  " THEN GO TO 5470
5060 IF C$(J, tw, on TO on) <> "1" THEN GO TO 5380
5070 POKE G, ze: POKE G+on, ze: POKE G+tw, ze: POKE G+tr, ze
5080 LET jl = VAL (C$(J, tw, tw, TO Tw)+C$(J,tr))
5090 PRINT TAB tr - LEN STR$ J ; INVERE on; J;TAB fr; INVESE ze; " '; C$(J, on)+" '+C$j,tw)+C$(J,tr);" = > ";
5100 IF jl < ze OR jl >lm THEN GO TO 5460
5110 LET CJ = FN O(C$(J, on))
5120 PRINT TAB 127 - LEN STR$ jl; INVERSE on; jl; TAB 18; INVERSE ze; " '; C$(jl, on); " "; C$(jl,tw); " "; C$(jl, tr);" "; C$(j', fr);
5130 IF ABS CJ <> on THEN GO TO 5460
5140 LET dd = (jl > J)-(jl <J)
5150 LET je = G: LET do = ze
5160 LET jl = J THEN GO TO 5270
5170 LET cl = J + dd
5180 LET n1 = ze: IF C$(cl, on) = "  " THEn GO TO 5220
5190 IF C$(cl, tw, on TO on)<>"1" THEN LET n1 = on+(C$(cl, tw) <> "  ") +(C$(cl,tr)<> "  ") + (C$(cl, fr) <> "  "): GO TO 5220
5200 LET TJ = FN o(C$(cl, on))
5210 LET n1 = (TJ = on)*tr+(TJ = -on)*tw
5220 IF cl = jl AND dd > ze THEN GO TO 5270
5230 LET dp = dp + n1
5240 IF cl = jl THEN GO TO 5270
5250 LET cl = cl + dd
5260 GO TO 5180
5270 IF CJ = on THEN LET ja = ja+dd*dp+(dd>ze)*tr: GO TO 5310
5280 IF dd > zz THEN LET dp = dp+2
5290 IF dp > 126 AND dd < ze THEWN GO TO 5460
5300 IF dp > 129 AND dd > ze THEN GO TO 5460
5310 LET V = 16 * FN d(C$(J, on, on, on TO on)) + FN d(C$(J, on, tw TO tw))
5320 POKE G, V: LET G = G + on
5330 IF CJ = on THEN POKE G, ja - INT (ja/.qk)*qk: LET G=G+on:POKE G, INT (ja/qk): LET G=G+on: GO TO 5360
5340 IF dd < ze THEN LET dp = -dp
5350 LET dp = dp-tw:POKE G,dp:LET G=G+on
5360 PRINT "ok"
5370 GO TO 5470
5380 FOR I = on TO 7 STEP tw
5390 LET k = INTT (I/tw+on)
5400 LET V = 16*FN d($(J,K,on TO on)) + FN d(C$(J,K, tw TO tw))
5410 IF V <ze THEN GO TO 5440
5420 POKE G, V 
5430 LET G=G+on
5440 NEXT I
5450 GO TO 5470
5460 PRINT "**"
5470 NEXT J
5480 PRINT AT ze, 25; "        ": GO TO mr
6000 REM
6010 REM INV Memory display********* TRU
6020 INPUT "Starting address : "; dm
6030 CLS : PRINT AT ze, ze;
6040 LET G = dm: LET F = ze
6050 LET F = F+ on : PRINT TAB 5 - LEN STR$ G; G; TAB 6;
6060 FOR I = on TO fr
6070 LET V = PEEK G
6080 LET H = INT (V/16)
6090 LET L = V-16*H
6100 PRINT D$(H+on); D$(L+on); " ";
6110 LET G = G+on
6120 NEXT I
6130 PRINT " "
6140 IF F <> 22 THEN GO TO 6050
6150 LET K$ =INKEY$: IF K$ = "" THEN GO TO 6150
6160 IF K$ <> "m" AND K$ <> "M" THEN LET F = ze: POKE 23692, qk-on : GO TO 6050
6200 POKE 23692, on: PAUSE 20 : GO TO mr
7000 REM
7010 REM INV LOAD****************** TRU
7020 CLS
7030 INPUT "Load array : Press any key when   ready. ";K$
7040 PRINT AT ze, 25; INVERSE on; FLASH on; "LOADING"
7050 LOAD "source" DATA C$()
7060 FOR I = on tTO lm
7070 LET TP = I
7080 IF C$(I, on) <> "  " THEN GO TO 7100
7090 NEXT I
7100 FOR I = lm TO on STEP -1
7110 LET BP = I
7120 IF C$(I, on) <> "  " THEN GO TO 7140
7130 NEXT I
7140 PRINT AT ze, 25; "       "
7150 GO TO 9150
8000 REM
8010 REM INV SAVE****************** TRU
8020 INPUT "Enter name : ";n$
8030 IF n$ = "" THEN GO TO 8020
8040 INPUT "Source or Machine code : (s or m)"; K$
8050 IF K$ <> "s" AND K$ <> "m" THEN GO TO 8040
8060 IF K$ = "s" THEN SAVE n$ DATA C$() : GO TO mr
8070 INPUT "Starting address : "; ss
8080 INPUT "Finishing address : "; sf
8090 LET sb = sf-ss+on
8100 SAVE n$ CODE ss, sb
8110 GO TO mr
9000 REM
9010 REM initialization
9020 LET ze = PI - PI: LET on = PI / PI:LET tw = on + on: LET tr = on + tw: LET fr = tw + tw:LET qk = 256: LET mr = 2020: LET lm = 200
9025 BORDER 7: PAPER 7: INK on: INVERSE ze:OVER ze:FLASH ze:BRIGHT ze:BEEP .35,24: BEEP .25,12
9030 DIM A$(15):DIM O$(tw)
9040 LET TP = lm: LET BP = on : REM line number buffer
9050 DIM C$(lm, fr, tw): REM holds code
9060 PRINT AT ze, 20; INVERSE on; FLASH on; "INITIALISING"
9070 FOR I = on TO lm
9080 FOR J = on TO fr
9090 LET C$ (I,J) = " "
9100 NEXT J
9110 BEEP .01, 20
9120 NEXT I
9130 PRINT AT ze, 20; "            "
9140 LET D$ = "0123456789ABCDEF"
9150 CLS: PRINT "Lowest address : "; 31500
9160 INPUT "Loading address : ";R:PAUSE 20
9170 IF R < 31500 THEN GO TO 9160
9180 CLS: GO TO mr
