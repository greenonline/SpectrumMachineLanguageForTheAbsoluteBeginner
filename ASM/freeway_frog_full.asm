              00100 ; *********************** FREEWAY FROG ***********************
              00110 ;
              00120 ;
              00130 ;
              00140 ;
              00150 ;
6978          00160         org 27000                   ; start point decimal 27000
              00170 ;
6978 F3       00180 start   di                          ; disable basic system effecting
697A D9       00190         exx                         ; the keyboard scanning
697B E5       00200         push    hl                  ; preserve the HL register pair
697C D9       00210         exx                         ; pop back before return
697C CD836F   00220 again   call    init                ; initialisation
697F CDBD70   00230 move    call    tfctrl              ; traffic control routine
6982 CD5074   00240         call    respc               ; restore underneath
6985 CD0F71   00250         call    movtrf              ; move traffic
6988 CD4A73   00260         call    police              ; police car routine
698B CDC274   00270         call    frog                ; frog module
698E CD1D77   00280         call    calscr              ; calculate and display score
6991 CD8777   00290         call    siren               ; siren or delay
6994 3A776F   00300         ld      a,(gamflg)          ; finish when no frog
6997 A7       00310         and     a
6998 2005     00320         jr      nz,contin
699A CDDE77   00330         call    over                ; high score management
699D 18DD     00340         jr      again               ; new game again
699F 3E7F     00350 contin  ld      a,$7f               ; trap space key pressed
69A1 DBFE     00360         in      a,($0fe)            ; scan keyboard
69A3 E601     00370         and     1
69A5 20D8     00380         jr      nz,move
69A7 CDFE77   00390         call    final               ; reset screen and border colour
69AA D9       00400         exx
69AB E1       00410         pop     hl                  ; retrieve hl'
69AC D9       00420         exx
69AD FB       00430         ei                          ; enable interupts
69AE C9       00440         ret                         ; return to basic system
              00450 ;
              00460 ;
69AF          00470
              00100 ; *********************** FROGDB/ASM ***********************
              00110 ;
69AF B769     00120 frgshp  defw    frog1               ; up frog
69B1 D769     00130         defw    frog2               ; right frog
69B3 F769     00140         defw    frog3               ; down frog
69B5 1768     00150         defw    frog4               ; left frog
69B7 6F       00160 frog1   db      111,15,31,159,220,216,120,48
     0F 1F 9F DC D8 78 30
69BF F6       00170         db      246,240,248,249,59,27,30,12
     F0 F8 F9 3B 1B 1E 0C
69C7 00       00180         db      0,1,35,37,111,79,223,255
     01 23 25 6F 4F DF FF
69CF 00       00190         db      0,128,196,164,246,242,251,255
     80 C4 A4 F6 F2 FB FF
69D7 1F       00200 frog2   db      31,31,31,127,252,193,113,56
     1F 1F 7F FC C1 71 38
69DF FE       00210         db      254,244,248,240,192,156,240,192
     F4 FB F0 CD 9C F0 C0
69E7 3B       00220         db      56,113,193,252,127,31,31,31
     71 C1 FC 7F 1F 1F 1F
69EF CO       00230.        db      192,240,156,192,240,248,244,254
     F0 9C C0 F0 F8 F4 FE
69F7 FF       00240 frog3   db      255,223,79,111,37,35,1,0
     DF 4F 6F 25 23 01 00
69FF FF       00250         db      255,251,242,246,164,196,128,0
     FB F2 F6 A4 C4 80 00
6A07 30       00260         db      48,120,216,220,159,31,15,111
     78 D8 DC 9F 1F 0F 6F
6A0F 0C       00270         db      12,30,27,59,249,248,240,246
     1E 1B 3B F9 F8 F0 F6
6A17 7F       00280 frog4   db      127,47,31,15,3,57,15,3
     2F 1F 0F 03 39 0F 03
6A1F F0       00290         db      240,240,248,254,63,131,142,28
     F0 F8 FE 3F 83 8E 1C
6A27 03       00300         db      3,15,57,3,15,31,47,127
     0F 39 03 0F 1F 2F 7F
6A2F 1C       00310         db      28,142,131,63,254,248,240,240
     BE 83 3F FE F8 F0 F0
              00320 ;
              00330 ;
6A37 00       00340 lbike   db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00 
6A3F 1F       00350         db      31,63,115,81,169,112,112,32
     3F 73 51 A9 70 70 20
6A47 FE       00360         db      254,252,252,234,213,206,14,4
     FC FC EA D5 CE 0E 04
6A4F 00       00370         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6A57 00       00380         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00 
6A5F 01       00390         db      1,3,1,0,3,4,14,31
     03 01 00 03 04 0E 1F
6A67 80       00400         db      128,192,192,224,224,112,119,255
     C0 C0 E0 E0 70 77 FF
6A6F 00       00410         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
              00420 ;
6A77 00       00430 lbatt   db      0,7,7,0
     07 07 00
6A7B 00       00440         db      0,7,7,0    
     07 07 00
              00450 ;
6A7F 00       00460 rbike   db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6A87 7F       00470         db      127,63,63,87,171,115,112,32
     3F 3F 57 AB 73 70 20
6A8F F8       00480         db      248,252,206,138,149,14,14,4
     FC CE 8A 95 0E 0E 04
6A97 00       00490         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6A9F 00       00500         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6AA7 01       00510         db      1,3,3,7,7,14,238,255
     03 03 07 07 0E EE FF
6AAF 80       00520         db      128,192,128,0,192,32,112,248
     C0 80 00 C0 20 70 F8
6AB7 00       00530         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
              00540 ;
              00550 ;
6ABF 00       00560 rbatt   db      0,7,7,0
     07 07 00
6AC3 00       00570         db      0,7,7,0
     07 07 00
              00580 ;
              00590 ;    
6AC7 00       00600 lcar    db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6ACF 00       00610         db      0,0,3,7,15,2,0,0
     00 03 07 0F 02 00 00
6AD7 07       00620         db      7,255,255,159,111,247,240,96
     FF FF 9F 6F F7 F0 60
6ADF 80       00630         db      128,255,255,255,255,254,0,0
     FF FF FF FF FE 00 00
6AE7 F0       00640         db      240,254,255,159,111,256,240,96
     FE FF 9F 6F F6 F0 60
6AEF 00       00650         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6AF7 00       00660         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6AFF 00       00670         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6B07 00       00680         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6B0F 00       00690         db      0,0,0,0,0,63,97,193
     00 00 00 00 3F 61 C1
6B17 00       00700         db      0,0,0,0,0,0,128,192
     00 00 00 00 00 80 C0
6B1F 00       00710         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
              00720 ;
6B27 00       00730 lcatt   db      0,6,6,6,6,0
     06 06 06 06 00
6B2D 00       00740         db      0,0,0,6,6,0
     00 00 06 06 00
              00750 ;
              00760 ;    
6B33 00       00770 rcar    db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6B3B 0F       00780         db      15,127,255,249,246,111,15,6
     7F FF F9 F6 6F 0F 06
6B43 01       00790         db      1,255,255,255,255,127,0,0
     FF FF FF FF 7F 00 00
6B4B E0       00800         db      244,255,255,249,246,239,15,6
     FF FF F9 F6 EF 0F 06
6B53 00       00810         db      0,0,192,224,240,64,0,0
     00 C0 E0 F0 40 00 00
6B5B 00       00820         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6B63 00       00830         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6B6B 00       00840         db      0,0,0,0,0,0,1,3
     00 00 00 00 00 01 03
6B73 00       00850         db      0,0,0,0,0,252,134,131
     00 00 00 00 FC 86 84
6B7B 00       00860         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6B83 00       00870         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6B8B 00       00880         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
              00890 ;
6B93 00       00900 rcatt   db      0,2,2,2,2,0
     02 02 02 02 00
6B99 00       00910         db      0,2,2,0,0,0
     02 02 00 00 00
              00920 ;
              00930 ;
6B9F 00       00940 ltruck  db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6BA7 1F       00950         db      31,31,31,62,61,59,3,1
     1F 1F 3E 3D 3B 03 01
6BAF F8       00960         db      248,252,254,127,184,216,192,128
     FC FE 7F B8 D8 C0 80
6BB7 FF       00970         db      255,255,255,255,6,15,15,6
     FF FF FF 06 0F 0F 06
6BBF FF       00980         db      255,255,255,0,0,0,0,0
     FF FF 00 00 00 00 00
6BC7 FF       00990         db      255,255,255,0,0,0,0,0
     FF FF 00 00 00 00 00
6BCF FF       01000         db      255,255,255,0,6,15,15,6
     FF FF 00 06 0F 0F 06
6BD7 FE       01010         db      254,254,254,4,50,122,122,48
     FE FE04 32 7A 7A 30
6BDF 00       01020         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6BE7 00       01030         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6BEF 00       01040         db      0,0,7,9,17,17,31,31
     00 07 09 11 11 1F 1F
6BF7 02       01050         db      2,2,250,250,254,252,252,248
     02 FA FA FE FC FC FB
6BFF FF       01060         db      255,255,255,255,255,255,255,255
     FF FF FF FF FF FF FF
6C07 FF       01070         db      255,255,255,255,255,255,255,255
     FF FF FF FF FF FF FF
6C0F FF       01080         db      255,255,255,255,255,255,255,255
     FF FF FF FF FF FF FF
6C17 FF       01090         db      255,255,255,255,255,255,255,255
     FF FF FF FF FF FF FF
6C1F FE       01100         db      254,254,254,254,254,254,254,254
     FE FE FE FE FE FE FE
6C27 00       01110         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6C2F 00       01120         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6C37 00       01130         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6C3F 00       01140         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6C47 00       01150         db      0,0,0,0,0,255,255,255
     00 00 00 00 FF FF FF
6C4F 00       01160         db      0,0,0,0,0,255,255,255
     00 00 00 00 FF FF FF
6C57 00       01170         db      0,0,0,0,0,255,255,255
     00 00 00 00 FF FF FF
6C5F 00       01180         db      0,0,0,0,0,255,255,255
     00 00 00 00 FF FF FF
6C67 00       01190         db      0,0,0,0,0,254,254,254
     00 00 00 00 FE FE FE
6C6F 00       01200         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
              01210 ;
              01220 ;
6C77 00       01230 ltatt   db      0,3,3,5,5,5,5,5,0
     03 03 05 05 05 05 05 00
6C80 00       01240         db      0,3,3,5,5,5,5,5,0
     03 03 05 05 05 05 05 00
6C89 00       01250         db      0,0,0,5,5,5,5,5,0
     00 00 05 05 05 05 05 00
              01260 ;
              01270 ;
6C92 00       01280 rtruck  db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6C9A 7F       01290         db      127,127,127,32,76,94,94,12
     7F 7F 20 4c 5E 5E 0C
6CA2 FF       01300         db      255,255,255,0,96,240,240,96
     FF FF 00 60 F0 F0 60
6CAA FF       01310         db      255,255,255,0,0,0,0,0
     FF FF 00 00 00 00 00 
6CB2 FF       01320         db      255,255,255,0,0,0,0,0
     FF FF 00 00 00 00 00 
6CBA FF       01330         db      255,255,255,255,96,240,240,96
     FF FF FF 60 F0 F0 60
6CC2 1F       01340         db      31,63,127,254,29,27,3,1
     3F 7F FE 1D 1B 03 01
6CCA F8       01350         db      248,248,248,124,188,220,192,128
     F8 F8 7C BC DC C0 80
6CD2 00       01360         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6CDA 00       01370         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6CE2 7F       01380         db      127,127,127,127,127,127,127,127
     7F 7F 7F 7F 7F 7F 7F
6CEA FF       01390         db      255,255,255,255,255,255,255,255
     FF FF FF FF FF FF FF
6CF2 FF       01400         db      255,255,255,255,255,255,255,255
     FF FF FF FF FF FF FF
6CFA FF       01410         db      255,255,255,255,255,255,255,255
     FF FF FF FF FF FF FF
6D02 FF       01420         db      255,255,255,255,255,255,255,255
     FF FF FF FF FF FF FF
6D0A 40       01430         db      64,64,95,95,127,63,63,31
     40 5F 5F 7F 3F 3F 1F
6D12 00       01440         db      0,0,244,144,136,136,248,248
     00 E0 90 88 88 F8 F8
6D1A 00       01450         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6D22 00       01460         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6D2A 00       01470         db      0,0,0,0,0,127,127,127
     00 00 00 00 7F 7F 7F
6D32 00       01480         db      0,0,0,0,0,255,255,255
     00 00 00 00 FF FF FF
6D3A 00       01490         db      0,0,0,0,0,255,255,255
     00 00 00 00 FF FF FF
6D42 00       01500         db      0,0,0,0,0,255,255,255
     00 00 00 00 FF FF FF
6D4A 00       01510         db      0,0,0,0,0,255,255,255
     00 00 00 00 FF FF FF
6D52 00       01520         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6D5A 00       01530         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
6D62 00       01540         db      0,0,0,0,0,0,0,0
     00 00 00 00 00 00 00
              01550 ;
              01560 ;
6D6A 00       01570 rtatt   db      0,5,5,5,5,5,3,3,0
     05 05 05 05 05 03 03 00
6D73 00       01580         db      0,5,5,5,5,5,3,3,0
     05 05 05 05 05 03 03 00
6D7C 00       01590    db      0,5,5,5,5,5,0,0,0
     05 05 05 05 05 00 00 00
              01600 ;
              01610 ;
6D85 00       01620 blank   db      0,0,0,0
     00 00 00
              01630 ;
              01640 ;
0024          01650 frgstr  ds      36                  ; 4*8+4
0078          01660 pcstr   ds      120                 ; 12*8+12+7
              01670 ;
              01680 ;    
              01690 ; *********************** DATABASE ***********************
              01700 ;
6E25 00       01710 ob1ext  defb    0                   ; object 1 existence
6E26 00       01720         defb    0                   ; cycle count
6E27 00       01730         defb    0                   ; direction, 0=>right
6E28 00       01740         defb    0                   ; object 1 pos real/abs
6E29 0000     01750         defw    0                   ; position counter
6E2B 0000     01760         defw    0                   ; shape pointer
6E2D 0000     01770         defw    0                   ; attribute pointer
6E2F 00       01780         defb    0                   ; row counter
6E30 00       01790         defb    0                   ; column pointer
6E31 00       01800 ob2ext  db      0,0,0,0             ; ob2 pos real/abs flag
     00 00 00
6E35 0000     01810         defw    0
6E37 0000     01820         defw    0
6E39 0000     01830         defw    0
6E3B 00       01840         db      0,0
     00
6E3D 00       01850 ob3ext  db      0,0,0,0             ; ob3 pos real/abs flag
     00 00 00
6E41 0000     01860         defw    0
6E43 0000     01870         defw    0
6E45 0000     01880         defw    0
6E47 00       01890         db      0,0 
     00   
6E49 00       01900 ob4ext  db      0,0,0,0             ; ob4 pos real/abs flag
     00 00 00
6E4D 0000     01910         defw    0
6E4F 0000     01920         defw    0
6E51 0000     01930         defw    0
6E53 00       01940         db      0,0
     00
6E55 00       01950 ob5ext  db      0,0,0,0             ; ob5 pos real/abs flag
     00 00 00
6E59 0000     01960         defw    0
6E5B 0000     01970         defw    0
6E5D 0000     01980         defw    0
6E5F 00       01990         db      0,0
6E61 00       02000 ob6ext  db      0,0,0,0             ; ob6 pos real/abs flag
6E65 0000     02010         defw    0
6E67 0000     02020         defw    0
6E69 0000     02030         defw    0
6E6B 00       02040         db      0,0
     00
              02050 ;
              02060 ;
6E6D 00       02070 pcarext defb    0                   ; police car database
6E6E 00       02080 pcarcyc defb    0
6E6F 00       02090 pcardir defb    0
6E70 00       02100 pcarrap defb    0
6371 0000     02110 pcarpos defw    0
6373 0000     02120 pcarshp defw    0
6375 0000     02130 pcaratt defw    0
6E77 02       02140 pcarrow defb    2
6E78 06       02150 pcarcol defb    6    
              02160 ;
              02170 ;
6E79 00       02180 frgext  defb    0                   ; frog database
6E7A 00       02190 frgcyc  defb    0  
6E7B 00       02200 frgdir  defb    0                   ; 0:up 1:rht 2:down 3:left                        
637C 0000     02210 frgpos  defw    0
637E 0000     02220 frogsh  defw    0
6380 00       02230 frgatr  defb    0
              02240 ;
              02250 ;    
6E81 08       02260 frgdb   db      8,8,1
     08 01
6E84 AC50     02270 frgstn  defw    $50ac
6E86 B769     02280         defw    frog1
6E88 04       02290         db      4                   ; attr. total 8 chars
              02300 ;
              02310 ;    
6E89 956E     02320 dbindex defw    rbdb                ; right bike db
6E8B A16E     02330         defw    lbdb                ; left bike db
6E8D AD6E     02340         defw    rcdb                ; right car db
6E8F B96E     02350         defw    lcdb                ; left car db
6E91 C56E     02360         defw    rtdb                ; right truck db
6E93 D16E     02370         defw    ltdb                ; left truck db
              02380 ;
              02390 ;    
6E95 02       02400 rbdb    db      2,1,0,0             ; ext cnt dir raf
     01 00 00
6E99 1D48     02410         defw    $481d               ; pos
6E9B 7F6A     02420         defw    rbike               ; right bike
6E9D BF6A     02430         defw    rbatt               ; attribute
6E9F 02       02440         db      2,4                 ; row col
     04
              02450 ;
              02460 ;    
6EA1 02       02470 lbdb    db      2,1,1,1    
     01 01 01
6EA5 DF48     02480         defw    $48df               
6EA7 376A     02490         defw    lbike               
6EA9 776A     02500         defw    lbatt               
6EAB 02       02510         db      2,4
     04
              02520 ;    
              02530 ;    
6EAD 03       02540 rcdb    db      3,1,0,0  
     01 00 00
6EB1 1B4B     02550         defw    $481b               
6EB3 336B     02560         defw    rcar               
6EB5 936B     02570         defw    rcatt               
6EB7 02       02580         db      2,6
     06
              02590 ;    
              02600 ;    
6EB9 03       02610 lcdb    db      3,1,1,1  
     01 01 01           
6EBD DF4B     02620         defw    $48df              
6EBF C76A     02630         defw    lcar               
6EC1 276B     02640         defw    lcatt               
6EC3 02       02650         db      2,6
              02660 ;    
              02670 ;    
6EC5 06       02680 rtdb    db      6,1,0,0   
     01 00 00          
6EC5 1848     02690         defw    $4818              
6ECB 926C     02700         defw    rtruck               
6ECD 6A6D     02710         defw    rtatt               
6ECF 03       02720         db      3,9
     09
              02730 ;    
              02740 ;    
6ED1 06       02750 ltdb    db      6,1,1,1 
     01 01 01    
6ED5 DF48     02760         defw    $48df            
6ED7 9F6B     02770         defw    ltruck               
6ED9 776C     02780         defw    ltatt               
6EDB 03       02790         db      3,9
     09
              02800 ;    
              02810 ;    
6EDD 01       02820 lpcdb   db      1,1,1,1
     01 01 01
6EE1 DF48     02830         defw    $48df
6EE3 C76A     02840         defw    lcar
6EE5 E96E     02850         defw    lpcatt
6EE7 02       02860         db      2,6
     06
              02870 ;    
              02880 ;    
6EE9 00       02890 lpcatt  db      0,5,5,5,5,0
     05 05 05 05 00
6EEF 00       02900         db      0,0,0,5,5,0
     00 00 00 05 05 00
              02910 ;
              02920 ;    
6EF5 01       02930 rpcdb   db      1,1,0,0
     01 00 00
6EF9 1B4B     02940         defw    $481b
6EFB 336B     02950         defw    rcar
6EFD 016F     02960         defw    rpcatt
6EFF 02       02970         db      2,6
     06
              02980 ;
              02990 ;
6F01 00       03000 rpcatt  db      0,5,5,5,5,0
     05 05 05 05 00
6F07 00       03010         db      0,5,5,0,0,0
     05 05 00 00 00
              03020 ;
              03030 ;
              00480 ;
              00490 ;
6F0D 29       00500 pcton1  db      41,0,$0f0,1         ; first police car tone
     00 F0 01
6F11 17       00510 pcton2  db      23,0,$8c,3          ; second police car tone     
     00 8C 03
              00520 ;
              00530 ;
6F15 46       00540 homton  db      $46,0,$0c7,4        ; frog rech home tone
     00 C7 04
6F19 5D       00550         db      $5d,0,$8c,3
     00 C7 04
6F1D 7C       00560         db      $7c,0,$0a1,2
     00 A1 02
6F21 AA       00570         db      $0aa,0,$0f1,1
     00 F1 01
6F25 DE       00580         db      $0de,0,$6d,1
     00 6D 01
6F29 28       00590         db      $28,1,9,1
     01 09 01
6F2D 8B       00600         db      $8b,1,$0bf,0
     01 BF 00
6F31 0F       00610         db      $0f,2,$88,0
     02 88 00
6F35 C0       00620         db      $0c0,2,$5e,0
     02 5E 00
6F39 84       00630 dieton  db      $84,3,$43,0         ; frog dying tone, reverse
     03 43 00
              00640 ;
              00650 ;
6F3D 53       00660 scrms1  defm    "Score "
     63 6F 72 65 20
6F43 30       00670 score   db      $30,$30,$30,$30,$30,$30
     30 30 30 30 30
6F49 48       00680 scrms2  defm    "HIGH SCORES"
     49 47 48 20 53 4F 52
     45 20
6F54 30       00690 hiscr   db      $30,$30,$30,$30,$30 
     30 30 30 30   
              00700 ;
              00710 ;
0005          00720 image   ds      5                   ; printing image of score
6F5E 00       00730 updwn   defb    0                   ; set when frog moves up or down
              00740 ;
              00750 ;
6F5F 00       00760 column  db      0                   ; variable storing shape column
6F60 00       00770 row     db      0                   ; variable storing shape row
6F61 00       00780 skip    defb    0                   ; char skipping during draw
6F62 00       00790 fill    defb    0                   ; char drawn
6F63 0000     00800 attpos  defw    0                   ; holding the atrribute file ptr
6F65 00       00810 attr    db      0                   ; attr of character block drawn
6F66 0000     00820 drwpos  defw    0                   ; draw position
6F68 0000     00830 strpos  defw    0                   ; store position
              00840 ;
              00850 ;
6F6A 0000     00860 attptr  defw    0                   
6F6A 0000     00870 newpos  defw    0                   ; new traffic object position
6F6A 0000     00880 posptr  defw    0                   ; traffic position database ptr
6F6A 00       00890 genflg  defb    0                   ; traffic regneration flag
              00900 ;
              00910 ;
6F71 00       00920 jamflg  defb    0                   ; set to 1 as traffic move jam
              00930 ;
              00940 ;
6F72 00       00950 chase   defb    0                   ; set when police car appears
6F73 00       00960 soundf  defb    0                   ; set when user want siren sound
6F74 00       00970 tonflg  defb    0                   ; determine which siren tone
6F75 0000     00980 rnd     defw    0                   ; pointer to rom for random no.    
              00990 ;
              01000 ;
6F77 01       01010 gamflg  defb    1                   ; end if zero
6F78 0000     01020 oldfrg  defw    0                   ; old frog pos
6F7A 0000     01030 newfrg  defw    0                   ; old frog pos
6F7C 00       01040 crhflg  defb    0                   ; set to 1 when from was crash
6F7D 00       01050 temdir  defb    0                   ; frog temporary new direction
6F7E 0000     01060 tempos  defw    0                   ; frog temporary new position
6F80 0000     01070 temshp  defw    0                   ; frog temporary new shape
              01080 ;
              01090 ;
5020          01100 bothy1  equ $5020                   ; 0,38.  0,39
5120          01110 bothy2  equ $5120           
46A0          01120 tophy1  equ $46a0                   ; 0,128. 0,129
47A0          01130 tophy2  equ $47a0
4860          01140 midhy1  equ $4b60                   ; x,83.  x,84
4C60          01150 midhy2  equ $4c60
              01160 ;
              01170 ;
3C00          01180 chrset  equ $3c00
              01190 ;
              01200 ;
6F82          01210 numfrg  defb    5                   ; number of frog
              01220 ;
              01230 ;
6F83 AF       01240 init    xor     a                   ; 000 for d2 d2 d0
6F84 D3FE     01250         out     ($0fe),a            ; set border colour
6F86 32485C   01260         ld      (23624),a           ; to black
6F89 32796E   01270         ld      (crhflg),a
6F8C 32796E   01280         ld      (frgext),a          ; set frog non exist
6F8F 3C       01290         inc     a
6F90 32776F   01300         ld      (gamflg),a         ; set game flag
6F93 3E05     01310         ld      a,5                 ; initialise frog no.
6F95 32826F   01320         ld      (numfrg),a
6F98 ED5F     01330         ld      a,r                 ; generate random ptr
6F9A E63F     01340         and     $3f                 ; for this cycle
6F9C 67       01350         ld      h,a                 ; ptr points to rom
6F9D ED5F     01360         ld      a,r
6F9F 6F       01370         ld      l,a
6FA0 22756F   01380         ld      (rnd),hl
6FA3 21AC50   01390         ld      hl,$50ac            ; init frog station
6FA6 22846E   01400         ld      (frgstn),hl
6FA9 CDD772   01410         call    clrscr              ; clear screen routine
6FAC CD0B70   01420         call    drwhwy              ; draw highway
6FAF CD5570   01430         call    lineup              ; line up all exist frogs
6FB2 210040   01440         ld      hl,$4000            ; message location
6FB5 113D6F   01450         ld      de,scrms1           ; load score message
6FB8 0606     01460         ld      b,6
6FBA CD2873   01470         call    disasc              ; display ascii character
6FBD 21446F   01480         ld      hl,score+1          ; print score
6FC0 CD6F77   01490         call    scrimg              ; convert to printable image
;ME <- TYPO???
6FC3 210640   01500         ld      hl,$4006
6FC6 11596F   01510         ld      de,image
6FC9 0605     01520         ld      b,5
6FCB CD2873   01530         call    disasc
6FCE 210E40   01540         ld      hl,$400e            ; high score message
6FD1 11496F   01550         ld      de,scrms2
6FD4 060B     01560         ld      b,11
6FD6 CD2873   01570         call    disasc
6FD9 21546F   01580         ld      hl,hiscr
6FDC CD6F77   01590         call    scrimg
6FDF 211940   01600         ld      hl,$4019
6FE2 11596F   01610         ld      de,image
6FE5 0605     01620         ld      b,5
6FE7 CD2873   01630         call    disasc
6FEA 21256E   01640         ld      hl,ob1ext           ; set all obj nonexist
6FED 110C00   01650         ld      de,12
6FF0 0607     01660         ld      b,7
6FF2 AF       01670         xor     a
6FF3 77       01680 intlp1  ld      (hl),a
6FF4 19       01690         add     hl,de
6FF5 10FC     01700         djnz    intlp1
6FF7 32726F   01710         ld      (chase),a           ; set no police car chase
6FFA 3C       01720         inc     a
6FFB 32736F   01730         ld      (soundf),a          ; set siren on
6FFE 21436F   01740         ld      hl,score            ; initialise score to
7001 11446F   01750         ld      de,score+1          ; ascii zero ie $30
7004 0E05     01760         ld      c,5
7006 3630     01770         ld      (hl),$30
7008 EDB0     01780         ldir                        ; init score to $30
700A C9       01790         ret
              01800 ;
              01810 ;
700B 21A040   01820 drwhwy  ld      hl,$40a0            ; fill top hwy
700E CD4170   01830         call    filhwy
7011 216048   01840         ld      hl,$4860            ; fill middle hwy
7014 CD4170   01850         call    filhwy
7017 212050   01860         ld      hl,$5020            ; fill bottom hwy
701A CD4170   01870         call    filhwy
701D 21A046   01880         ld      hl,tophy1           ; reverse build highway
7020 11A047   01890         ld      de,tophy2
7023 AF       01900         xor     a
7024 CD3870   01910         call    highwy
7027 212050   01920         ld      hl,bothy1
702A 112051   01930         ld      de,bothy2
702D CD3870   01940         call    highwy
7030 21604B   01950         ld      hl,midhy1
7033 11604C   01960         ld      de,midhy2
7036 3EC3     01970         ld      a,195               ; bin 11000011
7038 0620     01980 highwy  ld      b,32                ; 32*8 bits
703A 77       01990 hwylop  ld      (hl),a
703B 12       02000         ld      (de),a
703C 23       02010         inc     hl
703D 13       02020         inc     de
703E 10FA     02030         djnz    hwylop
7040 C9       02040         ret
              02050 ;
              02060 ;
7041 3EFF     02070 filhwy  ld      a,$0ff
7043 D9       02080         exx
7044 0620     02090         ld      b,32
7046 D9       02100 filhyl  exx
7047 E5       02110         push    hl
7048 0608     02120         ld      b,8
704A 77       02130 filchr  ld      (hl),a
704B 24       02140         inc     h
704C 10FC     02150         djnz    filchr
704E E1       02160         pop     hl
704F 23       02170         inc     hl
7050 D9       02180         exx
7051 10F3     02190         djnz    filhyl
7053 D9       02200         exx
7054 C9       02210         ret
              02220 ;
              02230 ;
              02240 ; *********************** LINEUP ***********************
              02250 ;
              02260 ; draw all frogs left of screen
              02270 ;
              02280 ;
7055 3E01     02290 lineup  ld      a,1                 ; right frog
7057 327B6E   02300         ld      (frgdir),a
705A 11D769   02310         ld      de,frog2            ; right frog shape
705D 2A846E   02320         ld      hl,(frgstn)         ; frog station
7060 3E04     02320         ld      a,4                 ; (paper 0) * 8 + (ink 4)
7062 32656F   02340         ld      (attr),a
7065 3A826F   02350         ld      a,(numfrg)          ; number of frog
7068 A7       02360         and     a                   ; test for number of frog left
7069 C8       02370         ret     z
706A 47       02380         ld      b,a                 ; number of frog times
706B C5       02390 drawln  push    bc
706C D5       02400         push    de
706D E5       02410         push    hl
706E CD7A70   02420         call    drwfrg             ; draw frog routine
7071 E1       02430         pop     hl
7072 D1       02440         pop     de
7073 2B       02450         dec     hl
7074 2B       02460         dec     hl
7075 2B       02470         dec     hl
7076 C1       02480         pop     bc
7077 10F2     02490         djnz    drawln
7079 C9       02500         ret
              02510 ;
              02520 ;    
              02530 ; *********************** DRWFRG ***********************
              02540 ;
              02550 ; similar to draw routine
              02560 ;
707A 3E02     02570 drwfrg  ld      a,2                 ; two row frog shape
707C 08       02580         ex      af,af'
707D E5       02590         push    hl                  ; store pos ptr
707E E5       02600 frglp0  push    hl
707F 0E02     02610         ld      c,2                 ; column count
7081 E5       02620 frglp1  push    hl
7082 0608     02630         ld      b,8                 ; draw character
7084 1A       02640 frglp2  ld      a,(de)
7085 77       02650         ld      (hl),a
7086 13       02660         inc     de
7087 24       02670         inc     h                   ; next byte of the char
7088 10FA     02680         djnz    frglp2
708A E1       02690         pop     hl                  ; current pointer
708B 23       02700         inc     hl                  ; moce to next char pos
708C 0D       02710         dec     c                   ; decr  column count
708D 20F2     02720         jr      nz,frglp1           
708F E1       02730         pop     hl                  ; row ptr
7090 08       02740         ex      af,af'              
7091 3D       02750         dec     a                   ; dec lines of char
7092 0E20     02760         ld      c,32
7094 280E     02770         jr      z,frgatt            ; load frog attribute
7096 08       02780         ex      af,af'
7097 A7       02790         and     a
7098 ED42     02800         sbc     hl,bc               ; move 32 char/1 line up
709A CB44     02810         bit     0,h                 ; test cross scr section
709C 28E0     02820         jr      z,frglp0
709E 7C       02830         ld      a,h
709F D607     02840         sub     7                   ; up one screen section
70A1 67       02850         ld      h,a
70A2 18DA     02860         jr      frglp0
70A4 E1       02870 frgatt  pop     hl                  ; pos ptr
70A5 7C       02880         ld      a,h                 ; convert to attribute ptr
70A6 E618     02890         and     $18
70A8 CD2F     02900         sra     a
70AA CD2F     02910         sra     a
70AC CD2F     02920         sra     a
70AE C658     02930         add     a,$58
70B0 67       02940         ld      h,a
70B1 3A656F   02950         ld      a,(attr)            ; fill frog shape attr
70B4 77       02960         ld      (hl),a
70B5 23       02970         inc     hl                  ; next character
70B6 77       02980         ld      (hl),a
70B7 ED42     02990         sbc     hl,bc               ; one line up
70B9 77       03000         ld      (hl),a
70BA 2B       03010         dec     hl                  ; next char left
70BB 77       03020         ld      (hl),a
70BC C9       03030         ret
              03040 ;
              03050 ; *********************** TFCTRL ***********************
              03060 ;
              03070 ; traffic control routine
              03080 ;
70BD 21706F   03090 tfctrl  ld      hl,genflg           ; check regneration flag
70C0 AF       03100         xor     a                   
70C1 BE       03110         cp      (hl)
70C2 2802     03120         jr      z,gener             ; if zero test generate
70C4 35       03130         dec     (hl)                ; decr generation flag
70C5 C9       03140         ret
70C6 21256E   03150 gener   ld      hl,ob1ext           ; start of traffic db
70C9 110C00   03160         ld      de,12               ; 12 byte database
70CC 0606     03170         ld      b,6                 ; 6 db pairs
70CE BE       03180 tctrlp  cp      (hl)                ; test existence
70CF 2004     03190         jr      nz,nspace
70D1 CDD970   03200         call    regen               ; regeneration routine
70D4 C9       03210         ret
70D5 19       03220 nspace  add     hl,de
70D6 10F6     03230         djnz    tctrlp
70D8 C9       03240         ret
              03250 ;
              03260 ;
              03270 ; *********************** REGEN ***********************
              03280 ;
              03290 ; regneration of traffic
              03300 ; INPUT:    HL=>DB PAIRS
              03310 ;
70D9 E5       03320 regen   push    hl
70DA CDCC77   03330 rand1   call    randno              ; random number routine
70DD E607     03340         and     7                   ; generate random number
70DF FE06     03350         cp      6                   ; from 0 to 5
70E1 30F7     03360         jr      nc,rand1
70E3 012159   03370         ld      bc,$5921            ; two char test
70E6 212059   03380         ld      hl,$5920            ; test jam
70E9 CB47     03390         bit     0,a                 ; odd number is left
70EB 2804     03400         jr      z,rtraf             ; right traffic
70ED 2EDF     03410         ld      l,$0df
70EF 0EDE     03420         ld      c,$0de
70F1 87       03430 rtraf   add     a,a                 ; get dbindex ptr in de
70F2 5F       03440         ld      e,a
70F3 0A       03450         ld      a,(bc)              ; test 2 char ahead
70F4 86       03460         add     a,(hl)
70F5 A7       03470         and     a                   ; zero paper, zero ink
70F6 2802     03480         jr      z,loaddb            ; if 0, initialise new obj
70F8 E1       03490         pop     hl                  ; if jam, return
70F9 C9       03500         ret
70FA 57       03510 loaddb  ld      d,a                 ; a = 0
70FB 21896E   03520         ld      hl,dbindex          ; get db
70FE 19       03530         add     hl,de
70FF 5E       03540         ld      e,(hl)              ; get corr database
7100 23       03550         inc     hl
7101 56       03560         ld      d,(hl)
7102 EB       03570         ex      de,hl               ; source
7103 D1       03580         pop     de                  ; destination
7104 010C00   03590         ld      bc,12
7107 EDB0     03600         ldir
7109 EDB0     03610         ld      a,2                 ; set regeneration flag
710B 32706F   03620         ld      (genflg),a          ; skip for 2 cycles
710E C9       03630         ret
              03640 ;
              03650 ;
              03660 ; *********************** MOVTRF ***********************
              03670 ;
              03680 ; move traffic routine
              03690 ;
710F D9       03700 movtrf  exx
7110 21256E   03710         ld      hl,ob1ext
7113 110C00   03720         ld      de,12
7116 0606     03730         ld      b,6
7118 E5       03740 mtrflp  push    hl
7119 D9       03750         exx
711A E1       03760         pop     hl                  ; existence
711B 7E       03770         ld      a,(hl)              ; skip when no exist
711C A7       03780         and     a
711D CAA771   03790         jp      z,nxtmov
7120 23       03800         inc     hl                  ; cycle count
7121 35       03810         dec     (hl)                ; decr cycle count
7122 C2A771   03820         jp      nz,nxtmov
7125 23       03830         inc     hl                  ; direction
7126 7E       03840         ld      a,(hl)              ; 0 L to R, 1 R to L
7127 23       03850         inc     hl
7128 23       03860         inc     hl
7129 226E6F   03870         ld      (posptr),hl         ; pos ptr
712C 5E       03880         ld      e,(hl)              ; restore pos
712D 23       03890         inc     hl
712E 56       03900         ld      d,(hl)
712F 1C       03910         inc     e                   ; move right
7130 A7       03920         and     a
7131 2802     03930         jr      z,ldpos
7133 1D       03940         dec     e                   ; move left
7134 1D       03950         dec     e                   ; move left
7135 ED536C6F 03960 ldpos   ld      (newpos),de
7139 08       03970         ex      af,af'
713A 010500   03980         ld      bc,5                 ; restore obj length
713D 09       03990         add     hl,bc
713E 7E       04000         ld      a,(hl)              ; row
713F 32606F   04010         ld      (row),a
7142 23       04020         inc     hl
7143 7E       04030         ld      a,(hl)              ; column
7144 325F6F   04040         ld      (column),a          
7147 3D       04050         dec     a
7148 4F       04060         ld      c,a
7149 08       04070         ex      af,af'
714A A7       04080         and     a                   ; test direction
714B EB       04090         ex      de,hl
714C 2008     04100         jr      nz,rtol             ; right to left
714E 09       04110         add     hl,bc               ; find head of truck
714F 7D       04120         ld      a,l                 ; lob
7150 FE40     04130         cp      $40                 ; test right edge
7152 3046     04140         jr      nc,moveok           ; skip test adhead if off
7154 1805     04150         jr      testah              ; test ahead
7156 7D       04160 rtol    ld      a,l                 ; new position, ahead as well
7157 FEC0     04170         cp      $0c0                ; test left edge
7159 383F     04180         jr      c,moveok            ; skip test ahead
715B 7C       04190 testah  ld      a,h                 ; covert to attr
715C E618     04200         and     $18
715E CB2F     04210         sra     a
7160 CB2F     04220         sra     a
7162 CB2F     04230         sra     a
7164 C658     04240         add     a,$58
7166 67       04250         ld      h,a
7167 012000   04260         ld      bc,32
716A AF       04270         xor     a
716B 32716F   04280         ld      (jamflg),a          ; initialise jam flag
716E 3A606F   04290         ld      a,(row)
7171 08       04300 tahlop  ex      af,af'
7172 7E       04310         ld      a,(hl)              ; retrieve attr
7173 E607     04320         and     7
7175 280E     04330         jr      z,tfrog1            ; jump if black ink
7177 FE04     04340         cp      4                   ; test for green, frog
7179 2007     04350         jr      nz,jam1             ; jam if not a frog
717B 3E01     04360         ld      a,1                 ; move if it is a frog
717D 327C6F   04370         ld      (crhflg),a          ; set frog crash
7180 1803     04380         jr      tfrog1
7182 32716F   04390 jam1    ld      (jamflg),a          ; set jamflg non zero
7185 A7       04400 tfrog1  and     a
7186 ED42     04410         sbc     hl,bc
7188 08       04420         ex      af,af'
7189 3D       04430         dec     a                   ; update row
718A 20E5     04440         jr      nz,tahlop
718C 3A716F   04450         ld      a,(jamflg)          ; test traffic jam
718F A7       04460         and     a
7190 2808     04470         jr      z,moveok            ; move if no jam
7192 D9       04480         exx                         ; else stop move one cycle
7193 23       04490         inc     hl
7194 34       04500         inc     (hl)                ; load 2 to cycle count
7195 34       04510         inc     (hl)
7196 2B       04520         dec     hl
7197 D9       04530         exx
7198 180D     04540         jr      nxtmov
719A 2A6E6F   04550 moveok  ld      hl,(posptr)         ; retrieve ptr to pos
719D ED5B6C6F 04560         ld      de,(newpos)
71A1 73       04570         ld      (hl),e              ; store newpos on db
71A2 23       04580         inc     hl
71A3 72       04590         ld      (hl),d
71A4 CDAF71   04600         call    mvctrl              ; movement control   
71A7 D9       04610 nxtmov  exx
71A8 19       04620         add     hl,de
71A9 05       04630         dec     b
71AA C21871   04640         jp      nz,mtrflp
71AD D9       04650         exx
71AE C9       04660         ret    
              04670 ;
              04680 ; *********************** MVCTRL ***********************
              04690 ;
              04700 ; Traffic movement control routine
              04710 ;
71AF 2B       04720 mvctrl  dec     hl
71B0 2B       04730         dec     hl
71B1 7B       04740         ld      a,e                 ; de=>newpos, hl=>db ptr
71B2 E61F     04750         and     $1f                 ; test edge
71B4 2005     04760         jr      nz,chgraf           ; change real abs flag
71B6 7E       04770         ld      a,(hl)
71B7 3C       04780         inc     a
71B8 E601     04790         and     1
71BA 77       04800         ld      (hl),a
71BB 2B       04810 chgraf  dec     hl                  ; pt dir
71BC 7E       04820         ld      a,(hl)
71BD A7       04830         and     a
71BE 200F     04840         jr      nz,toleft           ; right to left
71C0 7B       04850         ld      a,e
71C1 E61F     04860         and     $1f                 ; if to right and abs
71C3 201B     04870         jr      nz,drwobj           
71C5 23       04880         inc     hl                  ; get raf
71C6 7E       04890         ld      a,(hl)
71C7 2B       04900         dec     hl                  ; pt to dir
71C8 A7       04910         and     a                   ; if abstract, dies
71C9 2015     04920         jr      nz,drwobj
71CB D9       04930         exx
71CC 77       04940         ld      (hl),a              ; set non existence
71CD D9       04950         exx
71CE C9       04960         ret
71CF 3A5F6F   04970 toleft  ld      a,(column)
71D2 4F       04980         ld      c,a
71D3 EB       04990         ex      de,hl               ; test end of object
71D4 09       05000         add     hl,bc               ; touches left edge
71D5 7D       05010         ld      a,l
71D6 FEC0     05020         cp      $0c0
71D8 EB       05030         ex      de,hl
71D9 2005     05040         jr      nz,drwobj
71DB D9       05050         exx                         ; object nonexist as
71DC 3600     05060         ld      (hl),0              ; it moves off screen
71DE D9       05070         exx
71DF C9       05080         ret
71E0 D9       05090 drwobj  exx
71E1 7E       05100         ld      a,(hl)
71E2 23       05110         inc     hl
71E3 77       05120         ld      (hl),a              ; refill cycle count
71E4 2B       05130         dec     hl
71E5 D9       05140         exx
71E6 23       05150         inc     hl
71E7 E5       05160         push    hl                  ; refill cycle count
71E8 23       05170         inc     hl
71E9 23       05180         inc     hl
71EA 23       05190         inc     hl
71EB 5E       05200         ld      e,(hl)              ; retrieve shape ptr
71EC 23       05210         inc     hl
71ED 56       05220         ld      d,(hl)
71EE 23       05230         inc     hl
71EF 4E       05240         ld      c,(hl)              ; retrieve attr ptr
71F0 23       05250         inc     hl
71F1 46       05260         ld      b,(hl)
71F2 ED436A6F 05270         ld      (attptr),bc
71F6 23       05280         inc     hl
71F7 7E       05290         ld      a,(hl)
71F8 32606F   05300         ld      (row),a
71FB 23       05310         inc     hl
71FC 7E       05320         ld      a,(hl)
71FD 325F6F   05330         ld      (column),a
7200 E1       05340         pop     hl
7201 7E       05350         ld      a,(hl)              ; raflag
7202 2A6C6F   05360         ld      hl,(newpos)
7205 CD0972   05370         call    draw
7208 C9       05380         ret
              05390 ;
              05400 ;
              05410 ;
              05420 ; *********************** DRAW ***********************
              05430 ;
              05440 ; input :   hl=>start of display pos
              05450 ;           de=>ptr to shape db
              05460 ;           a =>position of real/abstract flag
              05470 ;           c =>no. of col to be display
              05480 ;           col pass as var
              05490 ;
              05500 ; var       column, row, attr, drwpos, 
              05510 ;           skip, fill
              05520 ;
              05530 ;
              05540 ; reg:      a,bc,de,hl,a'
              05500 ;
7209 CD9672   05560 draw    call    rshape              ; return row/col attptr
720C 3A606F   05570         ld      a,(row)
720F 08       05580         ex      af,af'
7210 D5       05590 lp0     push    de
7211 E5       05600         push    hl                  ; store line ptr
7212 3A616F   05610         ld      a,(skip)
7215 4F       05620         ld      c,a
7216 0600     05630         ld      b,0
7218 09       05640         add     hl,bc               ; skip pos ptr
7219 87       05650         add     a,a                 ; multiple of 8 bytes
721A 87       05660         add     a,a
721B 87       05670         add     a,a
721C 4F       05680         ld      c,a                 ; skip shape ptr
721D EB       05690         ex      de,hl
721E 09       05700         add     hl,bc
721F EB       05710         ex      de,hl
7220 CD44     05720         bit     0,h                 ; cross screen section
7222 2804     05730         jr      z,noskip
7224 3E07     05740         ld      a,7                 ; if yes, move up
7226 84       05750         add     a,h
7227 67       05760         ld      h,a
7228 3A626F   05770 noskip  ld      a,(fill)
722B A7       05780         and     a
722C 2811     05790         jr      z,nxt
722E 4F       05800         ld      c,a                 ; column to be filled
722F E5       05810 lp1     push    hl                  ; fill character
7230 0608     05820         ld      b,8
7232 1A       05830 lp2     ld      a,(de)              ; fill character bytes
7233 77       05840         ld      (hl),a
7234 13       05850         inc     de
7235 24       05860         inc     h
7236 10FA     05870         djnz    lp2
7238 E1       05880         pop     hl
7239 0D       05890         dec     c
723A 2803     05900         jr      z,nxt
723C 23       05910         inc     hl                  ; next character
723D 18F0     05920         jr      lp1
723F 08       05930 nxt     ex      af,af'
7240 E1       05940         pop     hl                  ; restore line ptr
7241 D1       05950         pop     de                  ; shape db ptr
7242 3D       05960         dec     a                   ; update row count
7243 281A     05970         jr      z,ldattr
7245 08       05980         ex      af,af'
7246 A7       05990         and     a                   ; clear carry
7247 0E20     06000         ld      c,$20
7249 ED42     06010         sbc     hl,bc               ; one line up
724B CB44     06020         bit     0,h                 ; cross screen section
724D 2804     06030         jr      z,moddb
724F 7C       06040         ld      a,h
7250 D607     06050         sub     7
7252 67       06060         ld      h,a
7253 3A5F6F   06070 moddb   ld      a,(column)
7256 87       06080         add     a,a
7257 87       06090         add     a,a
7258 87       06100         add     a,a                 ; update shape db
7259 4F       06110         ld      c,a
725A EB       06120         ex      de,hl
725B 09       06130         add     hl,bc
725C EB       06140         ex      de,hl
725D 18B1     06150         jr      lp0
725F 2A636F   06160 ldattr  ld      hl,(attpos)
7262 ED5B6A6F 06170         ld      de,(attptr)
7266 3A606F   06180         ld      a,(row)
7269 08       06190 atrow   ex      af,af'
726A D5       06200         push    de
726B E5       06210         push    hl
726C 3A616F   06220         ld      a,(skip)
726F 4F       06230         ld      c,a
7270 0600     06240         ld      b,0
7272 09       06250         add     hl,bc               ; skip attribute file
7273 EB       06260         ex      de,hl
7274 09       06270         add     hl,bc               ; skip attribute database
7275 EB       06280         ex      de,hl
7276 3A626F   06290         ld      a,(fill)
7279 A7       06300         and     a
727A 2807     06310         jr      z,skipat            ; skip attribute
727C 47       06320         ld      b,a                 ; fill attribute
727D 1A       06330 attr2   ld      a,(de)
727E 77       06340         ld      (hl),a
727F 23       06350         inc     hl
7280 13       06360         inc     de
7281 10FA     06370         djnz    attr2
7283 E1       06380 skipat  pop     hl
7284 D1       06390         pop     de
7285 3A5F6F   06400         ld      a,(column)
7288 A7       06410         and     a                   ; clear carry
7289 0E20     06420         ld      c,$20
728B ED42     06430         sbc     hl,bc               ; next attribute line up
728D 4F       06440         ld      c,a
728E EB       06450         ex      de,hl
728F 09       06460         add     hl,bc               ; update attribute db
7290 EB       06470         ex      de,hl
7291 08       06480         ex      af,af'
7292 3D       06490         dec     a
7293 20D4     06500         jr      nz,atrow
7295 C9       06510         ret
              06520 ;
              06530 ;
              06540 ; *********************** RSHAPE ***********************
              06550 ;
              06560 ; input:    hl=>position
              06570 ;           a=>real/abstract flag
              06580 ;           de=>shape ptr
              06590 ;           column
              06600 ;
              06610 ; output:   skip, fill, attpos
              06620 ;
7296 E5       06630 rshape  push    hl
7297 08       06640         ex      af,af'              ; real shape
7298 261F     06650         ld      h,$1f
729A 7C       06660         ld      a,h
729B A5       06670         and     l                   ; trap lower 5 bits
729C 6F       06680         ld      l,a
729D 7C       06690         ld      a,h
729E 95       06700         sub     l                   ; substract from $1f
729F 3C       06710         inc     a
72A0 A4       06720         and     h                   ;adjust for zero diff
72A1 6F       06730         ld      l,a
72A2 08       06740         ex      af,af'
72A3 A7       06750         and     a                   ; 0=>abstract, 1=>real
72A4 3A5F6F   06760         ld      a,(column)
72A7 200A     06770         jr      nz,real
72A9 95       06780         sub     l
72AA 32616F   06790         ld      (fill),a
72AD 7D       06800         ld      a,l                 ; reload abs diff
72AE 32616F   06810         ld      (skip),a
72B1 1811     06820         jr      calatt
72B3 BD       06830 real    cp      l                   ; take min of col/fill
72B4 3807     06840         jr      c,toobig            ; fill more than col
72B6 7D       06850         ld      a,l
72B7 A7       06860         and     a
72B8 2003     06870         jr      nz,toobig
72BA 3A5F6F   06880         ld      a,(column)
72BD 32626F   06890 toobig  ld      (fill),a
72C0 AF       06900         xor     a
72C1 32616F   06910         ld      (skip),a
72C4 E1       06920 calatt  pop     hl
72C5 E5       06930         push    hl
72C6 7C       06940         ld      a,h
72C7 E618     06950         and     $18
72C9 CB2F     06960         sra     a
72CB CB2F     06970         sra     a
72CD CB2F     06980         sra     a
72CF C65B     06990         add     a,$58
72D1 67       07000         ld      h,a
72D2 22636F   07010         ld      (attpos),hl
72D5 E1       07020         pop     hl
72D6 C9       07030         ret
              07040 ;
              07050 ;
72D7 210040   07060 clrscr  ld      hl,$4000            ; hl => start of screen        
72DA 110140   07070         ld      de,$4001
72DD 01FF17   07080         ld      bc,6143             ; size of screen $17ff
72E0 AF       07090         xor     a                   ; blank screen
72E1 77       07100         ld      (hl),a
72E2 EDB0     07110         ldir
72E4 210058   07120         ld      hl,$5800            ; set first line for score
72E7 11015B   07130         ld      de,$5801            ; of attribute file
72EA 011F00   07140         ld      bc,31
72ED 3607     07150         ld      (hl),7              ; ink seven
72EF EDB0     07160         ldir
72F1 212058   07170         ld      hl,$5820            ; set attribute
72F4 112158   07180         ld      de,$5821            ; start from second line
72F7 01DF02   07190         ld      bc,735
72FA 77       07200         ld      (hl),a              ; (paper 0) * 8 + (ink 0)
72FB EDB0     07210         ldir
72FD 21A058   07220         ld      hl,$58a0            ; set highway
7300 116059   07230         ld      de,$5960            ; high, middle, bottom
7303 01205A   07240         ld      bc,$5a20
7306 3E3B     07250         ld      a,56                ; (paper 7) * 8+ (ink 0)
7308 D9       07260         exx
7309 0620     07270         ld      b,32                ; fill one line
730B D9       07280 hwyatt  exx
730C 77       07290         ld      (hl),a
730D 12       07300         ld      (de),a
730E 02       07310         ld      (bc),a
730F 23       07320         inc     hl
7310 13       07330         inc     de
7311 03       07340         inc     bc
7312 D9       07350         exx
7313 10F6     07360         djnz    hwyatt
7315 D9       07370         exx
7316 C9       07380         ret
              07390 ;
              07400 ;
7317 E5       07410 shape   push    hl                  ; save hl ptr
7318 3A7B6E   07420         ld      a,(frgdir)
731B 87       07430         add     a,a
731C 21AF69   07440         ld      hl,frgshp
731F 1600     07450         ld      d,0
7321 5F       07460         ld      e,a
7322 19       07470         add     hl,de               ; ptr to pos of shape
7323 5E       07480         ld      e,(hl)
7324 23       07490         inc     hl
7325 56       07500         ld      d,(hl)
7326 E1       07510         pop     hl
7327 C9       07520         ret 
              07530 ;
              07540 ;
              07550 ; *********************** DISASC ***********************
              07560 ;
              07570 ; display ASCII value from character set
              07580 ; NB: store DE, the message pointer HL stays them same after 
              07590 ; display
              07600 ; used BC register as well
              07610 ;
              07620 ;
7328 C5       07630 disasc  push    bc
7329 D5       07640         push    de
732A E5       07650         push    hl
732B 1A       07660         ld      a,(de)              ; load ascii char
732C 6F       07670         ld      l,a
732D 2600     07680         ld      h,0
732F 29       07690         add     hl,hl               ; multiple of 8 bytes
7330 29       07700         add     hl,hl
7331 29       07710         add     hl,hl
7332 EB       07720         ex      de,hl
7333 21003C   07730         ld      hl,chrset           ; start of character set
7336 19       07740         add     hl,de
7337 EB       07750         ex      de,hl
7338 E1       07760         pop     hl
7339 0608     07770 drwchr  ld      b,8                 ; draw character
733B E5       07780         push    hl
733C 1A       07790 charlp  ld      a,(de)
733D 77       07800         ld      (hl),a
733E 13       07810         inc     de
733F 24       07820         inc     h
7340 10FA     07830         djnz    charlp
7242 E1       07840         pop     hl
7243 D1       07850         pop     de
7244 23       07860         inc     hl                  ; pos ptr
7245 13       07870         inc     de                  ; message prt
7246 C1       07880         pop     bc
7247 10DF     07890         djnz    disasc
7249 C9       07900         ret
              07910 ;
              07920 ;    
734A D9       07930 police  exx
    ld      hl,pcarext
    ld      a,(hl)              ; test police car
    push    hl
    exx
    and     a
    jr      nz,movpc            ; move police car
    pop     de                  ; db ext ptr
    call    randno              ; move when multiple of
    and     $1f                 ; 31
    cp      $1f
    ret     nz
    ld      a,1                 ; set chase flag
    ld      (chase),a
    ld      hl,rpcdb            ; right pc
    call    randno
    and     1
    jr      z,rhtpc
    ld      hl,lpcdb
rhtpc:
    ld      bc,12
    ldir
    exx
    push    hl
    exx
movpc:
    pop     hl                  ; existence ptr
    inc     hl
    inc     hl                  ; direction
    ld      a,(hl)
    ld      b,a                 ; store dir
    inc     hl
    inc     hl                  ; posptr
    ld      (posptr),hl
    ld      e,(hl)
    inc     hl
    ld      d,(hl)
    inc     e                   ; assume move right
    and     a
    jr      z,pcmrht            ; police car move right
    dec     e
    dec     e
pcmrht:
    ld      (newpos),de
    ld      a,2                 ; two row
    ld      (row),a
    ld      a,6
    ld      (column),a
    push    bc                  ; direction
    ld      a,(pcarrap)         ; real/abs flag
    ex      de,hl
    call    rshape              ; ret skip/fill, attr
    ld      hl,(attpos)
    pop     af
    and     a                   ; if 1, ok
    jr      nz,pctah            ; police car test ahead
    ld      bc,5
    add     hl,bc
pctah:
    ld      a,(hl)
    and     7
    ld      bc,32
    and     a
    sbc     hl,bc
    cp      4
    jr      z,isfrg2
    ld      a,(hl)
    and     7
    cp      4
    jr      nz,nfrog2
isfrg2:
    ld      a,1
    ld      (crhflg),a          ; set crash flag
    dec     a                   ; blank colour
    ld      (hl),a              ; blank front of pc
    add     hl,bc
    ld      (hl),a              ; ** should blank front **
nfrog2:
    call    strpc               ; store new underneath
    ld      hl,(posptr)
    ld      de,(newpos)
    ld      (hl),e
    inc     hl
    ld      (hl),d
    call    mvctrl
    exx                         ; if non exist
    ld      a,(hl)
    ld      (chase),a
    exx
    ret
;
;
; *********************** STRPC ***********************
;
; store underneath police car
;
strpc:
    ld      hl,(newpos)         ; pos ptr
    ld      de,pcstr            ; storage loc
    ex      de,hl
    ld      (hl),e              ; store position
    inc     hl
    ld      (hl),d
    inc     hl
    ex      de,hl
    ld      hl,row              ; load 5 bytes of info
    ld      a,(hl)
    ld      bc,5
    ldir
    ex      af,af'
    ld      hl,(newpos)
spclp1:
    push    hl
    ld      a,(skip)
    ld      c,a
    add     hl,bc
    bit     0,h
    jr      z,nssps
    ld      a,h
    add     a,7
    ld      h,a
nssps:
    ld      a,(fill)
    and     a
    jr      z,nxtspc
    ld      c,a
spclp2:
    push    hl                  ; restore char
    ld      b,8
spclp3:
    ld      a,(hl)              ; store screen first
    ld      (de),a
    inc     de
    inc     h
    djnz    spclp3
    pop     hl
    inc     hl                  ; next char
    dec     c
    jr      nz,spclp2
nxtspc:
    pop     hl
    ex      af,af'              ; upd row count
    dec     a
    jr      z,spcatr            ; restore police attr
    ex      af,af'
    ld      c,32
    sbc     hl,bc               ; up one line
    bit     0,h                 ; cross screen section?
    jr      z,spclp1
    ld      a,h
    sub     7
    ld      h,a
    jr      spclp1
spcatr:
    ld      hl,(attpos)         ; attribute start pos
    ld      a,(row)
    ex      af,af'
spcat1:
    push    hl
    ld      a,(skip)
    ld      c,a
    add     hl,bc
    ld      a,(fill)
    and     a
    jr      z,nxtrpa
    ld      c,a
    ldir
nxtspa:
    pop     hl
    ex      af,af'
    dec     a
    ret     z
    ex      af,af'
    ld      c,32
    sbc     hl,bc
    jr      spcat1
;
;
respc:
    ld      a,(pcarext)         ; test pc exist
    and     a
    ret     z
    ld      de,row
    ld      hl,pcstr+2
    ld      bc,5
    ldir                        ; retrieve 5 info
    ex      de,hl               ; de storage ptr
    ld      hl,(pcstr)          ; load pos
    ld      a,(row)
    ex      af,af'
rpclp1:
    push    hl                  ; save pos
    ld      a,(skip)
    ld      c,a
    add     hl,bc
    bit     0,h
    jr      z,nsrps
    ld      a,7
    add     a,h
    ld      h,a
nsrps:
    ld      a,(fill)
    and     a
    jr      z,nxtrpc
    ld      c,a
rpclp2:
    push    hl
    ld      b,8
rpclp3:
    ld      a,(de)              ; restore char
    ld      (hl),a
    inc     de
    inc     h
    djnz    rpclp3
    pop     hl
    inc     hl
    dec     c
    jr      nz,rpclp2
nxtrpc:
    pop     hl
    ex      af,af'
    dec     a                   ; upd row count
    jr      z,rpcatr              ; restore police car
    ex      af,af'
    ld      c,32
    sbc     hl,bc               ; move up one line
    bit     0,h
    jr      z,rpclp1
    ld      a,h
    sub     7                   ; cross boundary
    ld      h,a
    jr      rpclp1
rpcatr:
    ld      hl,(attpos)         ; attr start loading pos
    ld      a,(row)
    ex      af,af'
rpcat1:
    push    hl
    ld      a,(skip)
    ld      c,a
    add     hl,bc
    ld      a,(fill)
    and     a
    jr      z,nxtrpa
    ex      de,hl
    ld      c,a
    ldir
    ex      de,hl
nxtrpa:
    pop     hl
    ex      af,af'
    dec     a
    ret     z
    ex      af,af'
    ld      c,32
    sbc     hl,bc
    jr      rpcat1
;
;    
frog:
    ld      a,(crhflg)          ; crash flag
    and     a
    jr      nz,frgcrh           ; frog crash
    ld      (updwn),a           ; set no score
    call    regfrg              ; regenerate frog
    ld      hl,frgcyc           ; test move
    dec     (hl)
    ret     nz
    dec     hl
    ld      a,(hl)              ; reset cycle count
    inc     hl
    ld      (hl),a
    call    movfrg
    ld      a,(crhflg)
    and     a
    ret     z
frgcrh:
    call    crash
    ret
;
;
; *********************** REGFRG *********************** 
;
; Regenerate frog if any left
; Set GAMFLG to 0 if none left

regfrg:
    ld      a,(frgext)
    and     a
    ret     nz
    ld      hl,frgdb
    ld      de,frgext
    ld      bc,8
    ldir
    ld      hl,frgstn           ; update frog station
    dec     (hl)                ; move 3 characters left
    dec     (hl)
    dec     (hl)
    ld      hl,(frgpos)
    ld      (oldfrg),hl
    ld      (newfrg),hl
    ld      hl,frgstr           ; init frg str for res
    ld      de,frgstr+1         ; blank frog store
    ld      bc,35
    ld      (hl),0
    ldir
    ret
;
;   
; *********************** MOVFRG *********************** 
; move frog, store and retrieve
;
movfrg:
    xor     a
    ld      hl,$0e020           ; H=-32, L=32
    ld      c,a                 ; c=>abs movement
    ex      af,af'
    ld      a,$0df              ; test right
    in      a,($0fe)
    and     1
    jr      nz,left
    inc     c
    ld      de,frog2
    ld      b,1
left:
    ld      a,$0df              ; test left
    in      a,($0fe)
    and     4
    jr      nz,down
    dec     c
    ld      de,frog4
    ld      b,3
down:
    ld      a,$0fd              ; test down
    in      a,($0fe)
    and     1
    jr      nz,up
    ld      a,c
    add     a,l                 ; add 32
    ld      c,a
    ex      af,af'
    dec     a
    ex      af,af'              ; dec up/dwn flg
    ld      de,frog3
    ld      b,2
up:
    ld      a,$0f7              ; test up
    in      a,($0fe)
    and     1
    jr      nz,valid
    ld      a,c
    add     a,h                 ; add -32
    ld      c,a
    ex      af,af'
    inc     a
    ex      af,af'
    ld      de,frog1
    ld      b,0
valid:
    ld      a,b                 ; store temp dir
    ld      (temdir),a
    ld      (temshp),de         ; store temp shape
    xor     a
    cp      c
    ret     z                   ; if no move go back
    ld      hl,(oldfrg)
    bit     7,c                 ; test -ve
    ld      b,a
    ld      e,7                 ; for boundary adj
    jr      z,netdwn            ; net move rht, dwn
    dec     b
    ld      e,-7
netdwn:
    add     hl,bc
    bit     0,h
    jr      z,valid1            ; no cross boundary
    ld      a,h
    add     a,e
    ld      h,a                 ; adj hdb
valid1:
    ld      (tempos),hl
    ex      de,hl
    ld      a,$40               ; test upscr
    cp      d
    ld      a,e
    jr      nz,valid2
    cp      $20
    jr      c,nvalid
valid2:
    and     $1f                 ; test right boundary
    cp      $1f
    jr      z,nvalid
    ld      hl,$50be            ; test bot boundary
    and     a
    sbc     hl,de
    jr      c,nvalid            
    ld      hl,$507e            ; test frog station
    sbc     hl,de
    jr      nc,yvalid
    ld      a,e                 ; test within box
    and     $1f
    ld      h,a
    ld      a,(frgstn)
    cp      $0a0                ; test last frog
    jr      c,yvalid            ; mo mpre frog station
    inc     a                   ; when no frog left
    and     $1f
    sub     h
    jr      nc,nvalid
yvalid:
    ld      (newfrg),de         ; store new pos
    ex      af,af'
    ld      (updwn),a
    ex      af,af'
nvalid:
    ld      hl,(oldfrg)         ; test oldfrg=newfrg
    and     a
    sbc     hl,de
    ld      a,l
    or      h
    ret     z                   ; return if same
    call    resfrg              ; restore frog
    ld      hl,(newfrg)         ; update old frog pos
    ld      (oldfrg),hl
    ld      hl,temdir
    ld      de,frgdir
    ld      bc,5
    ldir
    call    strfrg
    ret
;
;    
resfrg:
    ld      de,frgstr           ; storage ptr
    ld      hl,(oldfrg)         ; restore from oldpos
    push    hl
    ld      a,2                 ; row counter
    ex      af,af'
rfrlp1:
    push    hl
    ld      c,2                 ; column counter
rfrlp2:
    push    hl
    ld      b,8
rfrlp3:
    ld      a,(de)              ; restore from db
    ld      (hl),a              ; into screen
    inc     de
    inc     h                   ; next char byte
    djnz    rfrlp3
    pop     hl
    inc     hl
    dec     c                   ; column count
    jr      nz,rfrlp2
    pop     hl
    ex      af,af'
    dec     a                   ; row count
    jr      z,rfratr
    ex      af,af'
    and     a
    ld      c,32                ; up one line
    sbc     hl,bc
    bit     0,h
    jr      z,rfrlp1
    ld      a,h
    sub     7
    ld      h,a
    jr      rfrlp1
rfratr:
    pop     hl
    ld      a,h
    and     $18
    sra     a
    sra     a
    sra     a
    add     a,$58
    ld      h,a
    ld      a,2                 ; row counter
    ex      af,af'
rfrat1:
    push    hl
    ex      de,hl
    ld      c,2                 ; restore attr
    ldir
    ex      de,hl
    pop     hl
    ex      af,af'
    dec     a                   ; update row counter
    ret     z
    ex      af,af'
    ld      c,32
    sbc     hl,bc
    jr      rfrat1
;
;
strfrg:
    ld      de,frgstr
    ld      hl,(newfrg)         ; store base on newpos
    exx
    ld      hl,(frogsh)         ; load shape as well
    exx
    push    hl
    ld      a,2
    ex      af,af'
sfrlp1:
    push    hl
    ld      c,2
sfrlp2:
    push    hl
    ld      b,8                 ; store and load a char
sfrlp3:
    ld      a,(hl)
    ld      (de),a
    exx
    ld      a,(hl)
    inc     hl
    exx
    ld      (hl),a
    inc     de
    inc     h
    djnz    sfrlp3
    pop     hl
    inc     hl                  ; next char
    dec     c
    jr      nz,sfrlp2
    pop     hl
    ex      af,af'
    dec     a
    jr      z,sfratr
    ex      af,af'
    and     a
    ld      c,32
    sbc     hl,bc               ; next row
    bit     0,h
    jr      z,sfrlp1
    ld      a,h
    sub     7
    ld      h,a
    jr      sfrlp1
sfratr:
    pop     hl
    ld      a,h                 ; calculate attr pos
    and     $18
    sra     a
    sra     a
    sra     a
    add     a,$58
    ld      h,a
    ld      a,2
    ex      af,af'
sfrat1:
    ld      b,2
    push    hl
sfratlp:
    ld      a,(hl)
    ld      (de),a
    ld      (hl),4              ; fill frog attr
    inc     hl
    inc     de
    and     7                   ; test crash
    jr      z,nfrog3
    ld      a,1
    ld      (crhflg),a
nfrog3:
    djnz    sfratlp
    pop     hl
    ex      af,af'
    dec     a
    ret     z
    ex      af,af'
    ld      c,32
    sbc     hl,bc
    jr      sfrat1
;
;
crash:
    xor     a
    ld      (crhflg),a          ; reset crash flag
    ld      (frgext),a          ; set frog nonexist
    call    frgdie
    call    resfrg
    ld      hl,numfrg
    dec     (hl)                ; decrease frog number
    ret     nz
    ld      (gamflg),a          ; zeroise game flag
    ret                         ; when no frog left
;
;
frgdie:
    ld      hl,(oldfrg)         ; old pos of frg
    ld      bc,$4002            ; red colour
    exx
    ld      hl,dieton           ; set die tone
    exx
    ld      a,h                 ; test end of journey
    cp      b
    jr      nz,notend
    ld      a,l
    cp      b
    jr      nc,notend
    ld      de,score+3          ; 100 pts bonus
    ex      de,hl
    inc     (hl)
    ld      hl,score+4
    call    disscr
    ld      c,6                 ; yellow
    exx
    ld      hl,homton
    exx
notend:
    ld      a,c
    ld      (attr),a
    ld      hl,(oldfrg)
    ld      de,(newfrg)
    call    drwfrg
    ld      de,32               ; line adjust
    add     hl,de
    ex      af,af'
    ld      a,(attr)
    ex      af,af'
    ld      b,5
flaslp:
    push    bc                  ; attribute ptr
    push    hl                  ; blank ink black paper
    xor     a
    ld      (hl),a
    inc     hl
    ld      (hl),a
    sbc     hl,de
    ld      (hl),a
    dec     hl
    ld      (hl),a
    call    frgton              ; generate froh tone
    pop     hl
    push    hl
    ex      af,af'
    ld      (hl),a              ; black paper, red or
    inc     hl                  ; yellow ink
    ld      (hl),a
    and     a
    sbc     hl,de
    ld      (hl),a
    dec     hl
    ld      (hl),a
    ex      af,af'
    call    frgton
    pop     hl
    pop     bc
    djnz    flaslp
    ret
;
;
frgton:
    exx
    push    hl
    call    tone1
    pop     hl
    ld      bc,4                 ; move down database
    ex      af,af'
    cp      6
    jr      z,home
    ld      bc,-4                ; move up database
home:
    add     hl,bc
    exx
    ex      af,af'
    ret
;
;    
calscr:
    ld      a,(frgext)          ; test existence
    and     a
    ret     z                   ; no update of score
    ld      a,(updwn)           ; test up/down movement
    and     a                   ; test any score
    ret     z
    ld      hl,score+4          ; add 10 to score
    bit     7,a                 ; test move down
    jr      nz,dwnscr           ; down score
    inc     (hl)
    jr      disscr              ; dis score
dwnscr:
    ld      a,(oldfrg+1)        ; test hob
    cp      $40                 ; test first block
    jr      nz,tlhwy            ; test low highway
    ld      a,(oldfrg)
    cp      $0c0                ; not even step on hwy
    ret     c
    inc     (hl)
    jr      disscr
tlhwy:
    cp      $50                 ; test in low hwy
    ret     nz
    ld      a,(oldfrg)
    cp      $20
    ret     nc                  ; no score if step hwy
    inc     (hl)
disscr:
    ld      b,4                 ; hl => tenth's pos
addlop:
    ld      a,(hl)
crylop:
    cp      $3a                 ; carry loop
    jr      c,upddig            ; update digit
    sub     10
    dec     hl
    inc     (hl)
    inc     hl
    jr      crylop
upddig:
    ld      (hl),a
    dec     hl
    djnz    addlop
    ld      hl,score+1
    call    scrimg              ; score image
    ld      hl,$4006
    ld      de,image
    ld      b,5
    call    disasc
    ret
;
;
scrimg:
    ld      de,image
    ld      bc,5
    ldir
    ld      hl,image
    ld      bc,$0430
prezer:
    ld      a,c
    cp      (hl)                ; test $30
    jr      nz,prezex
    ld      (hl),$20            ; space fill
    inc     hl
    djnz    prezer
prezex:
    ret
;
;    
siren:
    ld      a,$0bf
    in      a,($0fe)
    and     1
    jr      nz,nsound
    ld      a,(soundf)          ; reset sound condition
    inc     a
    and     1
    ld      (soundf),a
nsound:
    ld      a,(soundf)
    and     a
    jr      z,delay
    ld      a,(chase)           ; is police car on
    and     a
    jr      z,delay
    ld      a,(tonflg)
    inc     a
    and     1
    ld      (tonflg),a
    ld      hl,pcton1
    jr      z,tone1
    ld      hl,pcton2
tone1:
    ld      e,(hl)              ; de=duration*frequency
    inc     hl
    ld      d,(hl)
    inc     hl
    ld      c,(hl)
    inc     hl
    ld      b,(hl)
    push    bc
    pop     hl                  ; hl=437500/freq-30.125
    call    $03b5
    di
    ret
delay:
    ld      bc,6144
wait:
    dec     bc
    ld      a,b
    or      c
    jr      nz,wait
    ret
;
;
randno:
    push    hl
    push    bc
    ld      hl,(rnd)
    ld      b,(hl)
    inc     hl
    ld      a,$3f               ; bound pointer within ROM
    and     h
    ld      h,a
    ld      a,b
    ld      (rnd),hl
    pop     bc
    pop     hl
    ret
;
;
over:
    ld      hl,score+1          ; high score manage
    ld      de,hiscr
    ld      b,5
sortlp:
    ld      a,(de)
    cp      (hl)
    jr      z,samscr            ; test 1st ne degit
    ret     nc
    jr      scrgt               ; update high score
samscr:
    inc     de
    inc     hl
    djnz    sortlp
    ret
scrgt:
    ld      hl,score+1
    ld      de,hiscr
    ld      bc,5
    ldir
    ret
;
;    
final:
    ld      a,56                ; set white border
    ld      (23624),a
    ld      hl,$4000            ; start of screen
    ld      de,$4001
    ld      bc,6143             ; size of screen
    ld      (hl),0
    ldir
    ld      hl,$5800            ; start of attribute file
    ld      de,$5801
    ld      bc,767
    ld      (hl),56             ; white paper black ink
    ldir
    ret

    end     start
    
