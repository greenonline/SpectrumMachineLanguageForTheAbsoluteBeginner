              00100 ; *********************** FREEWAY FROG ***********************
              00110 ;
              00120 ;
              00130 ;
              00140 ;
              00150 ;
6978          00160         org 27000                   ; start point decimal 27000
              00170 ;
6978 F3       00180 start   di                          ; disable basic system effecting
6979 D9       00190         exx                         ; the keyboard scanning
697A E5       00200         push    hl                  ; preserve the HL register pair
697B D9       00210         exx                         ; pop back before return
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
69EF C0       00230         db      192,240,156,192,240,248,244,254
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
     00
6E61 00       02000 ob6ext  db      0,0,0,0             ; ob6 pos real/abs flag
     00 00 00
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
6E71 0000     02110 pcarpos defw    0
6E73 0000     02120 pcarshp defw    0
6E75 0000     02130 pcaratt defw    0
6E77 02       02140 pcarrow defb    2
6E78 06       02150 pcarcol defb    6    
              02160 ;
              02170 ;
6E79 00       02180 frgext  defb    0                   ; frog database
6E7A 00       02190 frgcyc  defb    0  
6E7B 00       02200 frgdir  defb    0                   ; 0:up 1:rht 2:down 3:left                        
6E7C 0000     02210 frgpos  defw    0
6E7E 0000     02220 frogsh  defw    0
6E80 00       02230 frgatr  defb    0
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
     06
              02660 ;    
              02670 ;    
6EC5 06       02680 rtdb    db      6,1,0,0   
     01 00 00          
6EC9 1848     02690         defw    $4818              
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
     49 47 48 20 53 43 4F 52
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
6F6C 0000     00870 newpos  defw    0                   ; new traffic object position
6F6E 0000     00880 posptr  defw    0                   ; traffic position database ptr
6F70 00       00890 genflg  defb    0                   ; traffic regneration flag
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
6F82 05       01210 numfrg  defb    5                   ; number of frog
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
7342 E1       07840         pop     hl
7343 D1       07850         pop     de
7344 23       07860         inc     hl                  ; pos ptr
7345 13       07870         inc     de                  ; message prt
7346 C1       07880         pop     bc
7347 10DF     07890         djnz    disasc
7349 C9       07900         ret
              07910 ;
              07920 ;    
734A D9       07930 police  exx
734B 216D6E   07940         ld      hl,pcarext
734E 7E       07950         ld      a,(hl)              ; test police car
734F E5       07960         push    hl
7350 D9       07970         exx
7351 A7       07980         and     a
7352 2023     07990         jr      nz,movpc            ; move police car
7354 D1       08000         pop     de                  ; db ext ptr
7355 CDCC77   08010         call    randno              ; move when multiple of
7358 E61F     08020         and     $1f                 ; 31
735A FE1F     08030         cp      $1f
735C C0       08040         ret     nz
735D 3E01     08050         ld      a,1                 ; set chase flag
735F 32726F   08060         ld      (chase),a
7362 21F56E   08070         ld      hl,rpcdb            ; right pc
7365 CDCC77   08080         call    randno
7368 E601     08090         and     1
736A 2803     08100         jr      z,rhtpc
736C 21DD6E   08110         ld      hl,lpcdb
736F 010C00   08120 rhtpc   ld      bc,12
7372 EDB0     08130         ldir
7374 D9       08140         exx
7375 E5       08150         push    hl
7376 D9       08160         exx
7377 E1       08170 movpc   pop     hl                  ; existence ptr
7378 23       08180         inc     hl
7379 23       08190         inc     hl                  ; direction
737A 7E       08200         ld      a,(hl)
737B 47       08210         ld      b,a                 ; store dir
737C 23       08220         inc     hl
737D 23       08230         inc     hl                  ; posptr
737E 226E6F   08240         ld      (posptr),hl
7381 5E       08250         ld      e,(hl)
7382 23       08260         inc     hl
7383 56       08270         ld      d,(hl)
7384 1C       08280         inc     e                   ; assume move right
7385 A7       08290         and     a
7386 2802     08300         jr      z,pcmrht            ; police car move right
7388 1D       08310         dec     e
7389 1D       08320         dec     e
738A ED536C6F 08330 pcmrht  ld      (newpos),de
738E 3E02     08340         ld      a,2                 ; two row
7390 32606F   08350         ld      (row),a
7393 3E06     08360         ld      a,6
7395 325F6F   08370         ld      (column),a
7398 C5       08380         push    bc                  ; direction
7399 3A706E   08390         ld      a,(pcarrap)         ; real/abs flag
739C EB       08400         ex      de,hl
739D CD9672   08410         call    rshape              ; ret skip/fill, attr
73A0 2A636F   08420         ld      hl,(attpos)
73A3 F1       08430         pop     af
73A4 A7       08440         and     a                   ; if 1, ok
73A5 2004     08450         jr      nz,pctah            ; police car test ahead
73A7 010500   08460         ld      bc,5
73AA 09       08470         add     hl,bc
73AB 7E       08480 pctah   ld      a,(hl)
73AC E607     08490         and     7
73AE 012000   08500         ld      bc,32
73B1 A7       08510         and     a
73B2 ED42     08520         sbc     hl,bc
73B4 FE04     08530         cp      4
73B6 2807     08540         jr      z,isfrg2
73B8 7E       08550         ld      a,(hl)
73B9 E607     08560         and     7
73BB FE04     08570         cp      4
73BD 2009     08580         jr      nz,nfrog2
73BF 3E01     08590 isfrg2  ld      a,1
73C1 327C6F   08600         ld      (crhflg),a          ; set crash flag
73C4 3D       08610         dec     a                   ; blank colour
73C5 77       08620         ld      (hl),a              ; blank front of pc
73C6 09       08630         add     hl,bc
73C7 77       08640         ld      (hl),a              ; ** should blank front **
73C8 CDDF73   08650 nfrog2  call    strpc               ; store new underneath
73CB 2A6E6F   08660         ld      hl,(posptr)
73CE ED5B6C6F 08670         ld      de,(newpos)
73D2 73       08680         ld      (hl),e
73D3 23       08690         inc     hl
73D4 72       08700         ld      (hl),d
73D5 CDAF71   08710         call    mvctrl
73D8 D9       08720         exx                         ; if non exist
73D9 7E       08730         ld      a,(hl)
73DA 32726F   08740         ld      (chase),a
73DD D9       08750         exx
73DE C9       08760         ret
              08770 ;
              08780 ;
              08790 ; *********************** STRPC ***********************
              08800 ;
              08810 ; store underneath police car
              08820 ;
73DF 2A6C6F   08830 strpc   ld      hl,(newpos)         ; pos ptr
73E2 11AD6D   08840         ld      de,pcstr            ; storage loc
73E5 EB       08850         ex      de,hl
73E6 73       08860         ld      (hl),e              ; store position
73E7 23       08870         inc     hl
73E8 72       08880         ld      (hl),d
73E9 23       08890         inc     hl
73EA EB       08900         ex      de,hl
73EB 21606F   08910         ld      hl,row              ; load 5 bytes of info
73EE 7E       08920         ld      a,(hl)
73EF 010500   08930         ld      bc,5
73F2 EDB0     08940         ldir
73F4 08       08950         ex      af,af'
73F5 2A6C6F   08960         ld      hl,(newpos)
73F8 E5       08970 spclp1  push    hl
73F9 3A616F   08980         ld      a,(skip)
73FC 4F       08990         ld      c,a
73FD 09       09000         add     hl,bc
73FE CB44     09010         bit     0,h
7400 2804     09020         jr      z,nssps
7402 7C       09030         ld      a,h
7403 C607     09040         add     a,7
7405 67       09050         ld      h,a
7406 3A626F   09060 nssps   ld      a,(fill)
7409 A7       09070         and     a
740A 280F     09080         jr      z,nxtspc
740C 4F       09090         ld      c,a
740D E5       09100 spclp2  push    hl                  ; restore char
740E 0608     09110         ld      b,8
7410 7E       09120 spclp3  ld      a,(hl)              ; store screen first
7411 12       09130         ld      (de),a
7412 13       09140         inc     de
7413 24       09150         inc     h
7414 10FA     09160         djnz    spclp3
7416 E1       09170         pop     hl
7417 23       09180         inc     hl                  ; next char
7418 0D       09190         dec     c
7419 20F2     09200         jr      nz,spclp2
741B E1       09210 nxtspc  pop     hl
741C 08       09220         ex      af,af'              ; upd row count
741D 3D       09230         dec     a
741E 280F     09240         jr      z,spcatr            ; restore police attr
7420 08       09250         ex      af,af'
7421 0E20     09260         ld      c,32
7423 ED42     09270         sbc     hl,bc               ; up one line
7425 CD44     09280         bit     0,h                 ; cross screen section?
7427 28CF     09290         jr      z,spclp1
7429 7C       09300         ld      a,h
742A D607     09310         sub     7
742C 67       09320         ld      h,a
742D 18C9     09330         jr      spclp1
742F 2A636F   09340 spcatr  ld      hl,(attpos)         ; attribute start pos
7432 3A606F   09350         ld      a,(row)
7435 08       09360         ex      af,af'
7436 E5       09370 spcat1  push    hl
7437 3A616F   09380         ld      a,(skip)
743A 4F       09390         ld      c,a
743B 09       09400         add     hl,bc
743C 3A626F   09410         ld      a,(fill)
743F A7       09420         and     a
7440 2803     09430         jr      z,nxtrpa
7442 4F       09440         ld      c,a
7443 EDB0     09450         ldir
7445 E1       09460 nxtspa  pop     hl
7446 08       09470         ex      af,af'
7447 3D       09480         dec     a
7448 C8       09490         ret     z
7449 08       09500         ex      af,af'
744A 0E20     09510         ld      c,32
744C ED42     09520         sbc     hl,bc
744E 18E6     09530         jr      spcat1
              09540 ;
              09550 ;
7450 3A6D6E   09560 respc   ld      a,(pcarext)         ; test pc exist
7453 A7       09570         and     a
7454 C8       09580         ret     z
7455 11606F   09590         ld      de,row
7458 21AF6D   09600         ld      hl,pcstr+2
745B 010500   09610         ld      bc,5
745E EDB0     09620         ldir                        ; retrieve 5 info
7460 EB       09630         ex      de,hl               ; de storage ptr
7461 2AAD6D   09640         ld      hl,(pcstr)          ; load pos
7464 3A606F   09650         ld      a,(row)
7467 08       09660         ex      af,af'
7468 E5       09670 rpclp1  push    hl                  ; save pos
7469 3A616F   09680         ld      a,(skip)
746C 4F       09690         ld      c,a
746D 09       09700         add     hl,bc
746E CB44     09710         bit     0,h
7470 2804     09720         jr      z,nsrps
7472 3E07     09730         ld      a,7
7474 84       09740         add     a,h
7475 67       09750         ld      h,a
7476 3A626F   09760 nsrps   ld      a,(fill)
7479 A7       09770         and     a
747A 280F     09780         jr      z,nxtrpc
747C 4F       09790         ld      c,a
747D E5       09800 rpclp2  push    hl
747E 0608     09810         ld      b,8
7480 1A       09820 rpclp3  ld      a,(de)              ; restore char
7481 77       09830         ld      (hl),a
7482 13       09840         inc     de
7483 24       09850         inc     h
7484 10FA     09860         djnz    rpclp3
7486 E1       09870         pop     hl
7487 23       09880         inc     hl
7488 0D       09890         dec     c
7489 20F2     09900         jr      nz,rpclp2
748B E1       09910 nxtrpc  pop     hl
748C 08       09920         ex      af,af'
748D 3D       09930         dec     a                   ; upd row count
748E 280F     09940         jr      z,rpcatr              ; restore police car
7490 08       09950         ex      af,af'
7491 0E20     09960         ld      c,32
7493 ED42     09970         sbc     hl,bc               ; move up one line
7495 CD44     09980         bit     0,h
7497 28CF     09990         jr      z,rpclp1
7499 7C       10000         ld      a,h
749A D607     10010         sub     7                   ; cross boundary
749C 67       10020         ld      h,a
749D 18C9     10030         jr      rpclp1
749F 2A636F   10040 rpcatr  ld      hl,(attpos)         ; attr start loading pos
74A2 3A606F   10050         ld      a,(row)
74A5 08       10060         ex      af,af'
74A6 E5       10070 rpcat1  push    hl
74A7 3A616F   10080         ld      a,(skip)
74AA 4F       10090         ld      c,a
74AB 09       10100         add     hl,bc
74AC 3A626F   10110         ld      a,(fill)
74AF A7       10120         and     a
74B0 2805     10130         jr      z,nxtrpa
74B2 EB       10140         ex      de,hl
74B3 4F       10150         ld      c,a
74B4 EDB0     10160         ldir
74B6 EB       10170         ex      de,hl
74B7 E1       10180 nxtrpa  pop     hl
74B8 08       10190         ex      af,af'
74B9 3D       10200         dec     a
74BA C8       10210         ret     z
74BB 08       10220         ex      af,af'
74BC 0E20     10230         ld      c,32
74BE ED42     10240         sbc     hl,bc
74C0 18E4     10250         jr      rpcat1
              10260 ;
              10270 ;    
74C2 3A7C6F   10280 frog    ld      a,(crhflg)          ; crash flag
74C5 A7       10290         and     a
74C6 2017     10300         jr      nz,frgcrh           ; frog crash
74C8 325E6F   10310         ld      (updwn),a           ; set no score
74CB CDE374   10320         call    regfrg              ; regenerate frog
74CE 217A6E   10330         ld      hl,frgcyc           ; test move
74D1 35       10340         dec     (hl)
74D2 C0       10350         ret     nz
74D3 2B       10360         dec     hl
74D4 7E       10370         ld      a,(hl)              ; reset cycle count
74D5 23       10380         inc     hl
74D6 77       10390         ld      (hl),a
74D7 CD1075   10400         call    movfrg
74DA 3A7C6F   10410         ld      a,(crhflg)
74DD A7       10420         and     a
74DE C8       10430         ret     z
74DF CD9176   10440 frgcrh  call    crash
74E2 C9       10450         ret
              10460 ;
              10470 ; *********************** REGFRG *********************** 
              10480 ;
              10490 ; Regenerate frog if any left
              10500 ; Set GAMFLG to 0 if none left
              10510 ;
74E3 3A796E   10520 regfrg  ld      a,(frgext)
74E6 A7       10530         and     a
74E7 C0       10540         ret     nz
74E8 21816E   10550         ld      hl,frgdb
74EB 11796E   10560         ld      de,frgext
74EE 010800   10570         ld      bc,8
74F1 EDB0     10580         ldir
74F3 21846E   10590         ld      hl,frgstn           ; update frog station
74F6 35       10600         dec     (hl)                ; move 3 characters left
74F7 35       10610         dec     (hl)
74F8 35       10620         dec     (hl)
74F9 2A7C6E   10630         ld      hl,(frgpos)
74FC 22786F   10640         ld      (oldfrg),hl
74FF 227A6F   10650         ld      (newfrg),hl
7502 21896D   10660         ld      hl,frgstr           ; init frg str for res
7505 118A6D   10670         ld      de,frgstr+1         ; blank frog store
7508 012300   10680         ld      bc,35
750B 3600     10690         ld      (hl),0
750D EDB0     10700         ldir
750F C9       10710         ret
              10720 ;
              10730 ; *********************** MOVFRG *********************** 
              10740 ;
              10750 ; move frog, store and retrieve
              10760 ;
7510 AF       10770 movfrg  xor     a
7511 2120E0   10780         ld      hl,$0e020           ; H=-32, L=32
7514 4F       10790         ld      c,a                 ; c=>abs movement
7515 08       10800         ex      af,af'
7516 3EDF     10810         ld      a,$0df              ; test right
7518 DBFE     10820         in      a,($0fe)
751A E601     10830         and     1
751C 2006     10840         jr      nz,left
751E 0C       10850         inc     c
751F 11D769   10860         ld      de,frog2
7522 0601     10870         ld      b,1
7524 3EDF     10880 left    ld      a,$0df              ; test left
7526 DBFE     10890         in      a,($0fe)
7528 E604     10900         and     4
752A 2006     10910         jr      nz,down
752C 0D       10920         dec     c
752D 11176A   10930         ld      de,frog4
7530 0603     10940         ld      b,3
7532 3EFD     10950 down    ld      a,$0fd              ; test down
7534 DBFE     10960         in      a,($0fe)
7536 E601     10970         and     1
7538 200B     10980         jr      nz,up
753A 79       10990         ld      a,c
753B B5       11000         add     a,l                 ; add 32
753C 4F       11010         ld      c,a
753D 08       11020         ex      af,af'
753E 3D       11030         dec     a
753F 08       11040         ex      af,af'              ; dec up/dwn flg
7540 11F769   11050         ld      de,frog3
7543 0602     11060         ld      b,2
7545 3EF7     11070 up      ld      a,$0f7              ; test up
7547 DBFE     11080         in      a,($0fe)
7549 E601     11090         and     1
754B 200B     11100         jr      nz,valid
754D 79       11110         ld      a,c
754E 84       11120         add     a,h                 ; add -32
754F 4F       11130         ld      c,a
7550 08       11140         ex      af,af'
7551 3C       11150         inc     a
7552 08       11160         ex      af,af'
7553 11B769   11170         ld      de,frog1
7556 0600     11180         ld      b,0
7558 78       11190 valid   ld      a,b                 ; store temp dir
7559 327D6F   11200         ld      (temdir),a
755C ED53806F 11210         ld      (temshp),de         ; store temp shape
7560 AF       11220         xor     a
7561 B9       11230         cp      c
7562 C8       11240         ret     z                   ; if no move go back
7563 2A786F   11250         ld      hl,(oldfrg)
7566 CD79     11260         bit     7,c                 ; test -ve
7568 47       11270         ld      b,a
7569 1E07     11280         ld      e,7                 ; for boundary adj
756B 2803     11290         jr      z,netdwn            ; net move rht, dwn
756D 05       11300         dec     b
756E 1EF9     11310         ld      e,-7
7570 09       11320 netdwn  add     hl,bc
7571 CB44     11330         bit     0,h
7573 2803     11340         jr      z,valid1            ; no cross boundary
7575 7C       11350         ld      a,h
7576 83       11360         add     a,e
7577 67       11370         ld      h,a                 ; adj hdb
7578 227E6F   11380 valid1  ld      (tempos),hl
757B EB       11390         ex      de,hl
757C 3E40     11400         ld      a,$40               ; test upscr
757E BA       11410         cp      d
757F 7B       11420         ld      a,e
7580 2004     11430         jr      nz,valid2
7582 FE20     11440         cp      $20
7584 382F     11450         jr      c,nvalid
7586 E61F     11460 valid2  and     $1f                 ; test right boundary
7588 FE1F     11470         cp      $1f
758A 2829     11480         jr      z,nvalid
758C 21BE50   11490         ld      hl,$50be            ; test bot boundary
758F A7       11500         and     a
7590 ED52     11510         sbc     hl,de
7592 3821     11520         jr      c,nvalid            
7594 217E50   11530         ld      hl,$507e            ; test frog station
7597 ED52     11540         sbc     hl,de
7599 3011     11550         jr      nc,yvalid
759B 7B       11560         ld      a,e                 ; test within box
759C E61F     11570         and     $1f
759E 67       11580         ld      h,a
759F 3A846E   11590         ld      a,(frgstn)
75A2 FEA0     11600         cp      $0a0                ; test last frog
75A4 3806     11610         jr      c,yvalid            ; mo mpre frog station
75A6 3C       11620         inc     a                   ; when no frog left
75A7 E61F     11630         and     $1f
75A9 94       11640         sub     h
75AA 3009     11650         jr      nc,nvalid
75AC ED537A6F 11660 yvalid  ld      (newfrg),de         ; store new pos
75B0 08       11670         ex      af,af'
75B1 325E6F   11680         ld      (updwn),a
75B4 08       11690         ex      af,af'
75B5 2A786F   11700 nvalid  ld      hl,(oldfrg)         ; test oldfrg=newfrg
75B8 A7       11710         and     a
75B9 ED52     11720         sbc     hl,de
75BB 7D       11730         ld      a,l
75BC B4       11740         or      h
75BD C8       11750         ret     z                   ; return if same
75BE CDD675   11760         call    resfrg              ; restore frog
75C1 2A7A6F   11770         ld      hl,(newfrg)         ; update old frog pos
75C4 22786F   11780         ld      (oldfrg),hl
75C7 217D6F   11790         ld      hl,temdir
75CA 117B6E   11800         ld      de,frgdir
75CD 010500   11810         ld      bc,5
75D0 EDB0     11820         ldir
75D2 CD2876   11830         call    strfrg
75D5 C9       11840         ret
              11850 ;
              11860 ;    
75D6 11896D   11870 resfrg  ld      de,frgstr           ; storage ptr
75D9 2A786F   11880         ld      hl,(oldfrg)         ; restore from oldpos
75DC E5       11890         push    hl
75DD 3E02     11900         ld      a,2                 ; row counter
75DF 08       11910         ex      af,af'
75E0 E5       11920 rfrlp1  push    hl
75E1 0E02     11930         ld      c,2                 ; column counter
75E3 E5       11940 rfrlp2  push    hl
75E4 0608     11950         ld      b,8
75E6 1A       11960 rfrlp3  ld      a,(de)              ; restore from db
75E7 77       11970         ld      (hl),a              ; into screen
75E8 13       11980         inc     de
75E9 24       11990         inc     h                   ; next char byte
75EA 10FA     12000         djnz    rfrlp3
75EC E1       12010         pop     hl
75ED 23       12020         inc     hl
75EE 0D       12030         dec     c                   ; column count
75EF 20F2     12040         jr      nz,rfrlp2
75F1 E1       12050         pop     hl
75F2 08       12060         ex      af,af'
75F3 3D       12070         dec     a                   ; row count
75F4 2810     12080         jr      z,rfratr
75F6 08       12090         ex      af,af'
75F7 A7       12100         and     a
75F8 0E20     12110         ld      c,32                ; up one line
75FA ED42     12120         sbc     hl,bc
75FC CB44     12130         bit     0,h
75FE 28E0     12140         jr      z,rfrlp1
7600 7C       12150         ld      a,h
7601 D607     12160         sub     7
7603 67       12170         ld      h,a
7604 18DA     12180         jr      rfrlp1
7606 E1       12190 rfratr  pop     hl
7607 7C       12200         ld      a,h
7608 E618     12210         and     $18
760A CB2F     12220         sra     a
760C CB2F     12230         sra     a
760E CB2F     12240         sra     a
7610 C65B     12250         add     a,$58
7612 67       12260         ld      h,a
7613 3E02     12270         ld      a,2                 ; row counter
7615 08       12280         ex      af,af'
7616 E5       12290 rfrat1  push    hl
7617 EB       12300         ex      de,hl
7618 0E02     12310         ld      c,2                 ; restore attr
761A EDB0     12320         ldir
761C EB       12330         ex      de,hl
761D E1       12340         pop     hl
761E 08       12350         ex      af,af'
761F 3D       12360         dec     a                   ; update row counter
7620 C8       12370         ret     z
7621 08       12380         ex      af,af'
7622 0E20     12390         ld      c,32
7624 ED42     12400         sbc     hl,bc
7626 18EE     12410         jr      rfrat1
              12420 ;
              12430 ;
7628 11896D   12440 strfrg  ld      de,frgstr
762B 2A7A6F   12450         ld      hl,(newfrg)         ; store base on newpos
762E D9       12460         exx
762F 2A7E6E   12470         ld      hl,(frogsh)         ; load shape as well
7632 D9       12480         exx
7633 E5       12490         push    hl
7634 3E02     12500         ld      a,2
7636 08       12510         ex      af,af'
7637 E5       12520 sfrlp1  push    hl
7638 0E02     12530         ld      c,2
763A E5       12540 sfrlp2  push    hl
763B 0608     12550         ld      b,8                 ; store and load a char
763D 7E       12560 sfrlp3  ld      a,(hl)
763E 12       12570         ld      (de),a
763F D9       12580         exx
7640 7E       12590         ld      a,(hl)
7641 23       12600         inc     hl
7642 D9       12610         exx
7643 77       12620         ld      (hl),a
7644 13       12630         inc     de
7645 24       12640         inc     h
7646 10F5     12650         djnz    sfrlp3
7648 E1       12660         pop     hl
7649 23       12670         inc     hl                  ; next char
764A 0D       12680         dec     c
764B 20ED     12690         jr      nz,sfrlp2
764D E1       12700         pop     hl
764E 08       12710         ex      af,af'
764F 3D       12720         dec     a
7650 2810     12730         jr      z,sfratr
7652 08       12740         ex      af,af'
7653 A7       12750         and     a
7654 0E20     12760         ld      c,32
7656 ED42     12770         sbc     hl,bc               ; next row
7658 CB44     12780         bit     0,h
765A 28DB     12790         jr      z,sfrlp1
765C 7C       12800         ld      a,h
765D D607     12810         sub     7
765F 67       12820         ld      h,a
7660 18D5     12830         jr      sfrlp1
7662 E1       12840 sfratr  pop     hl
7663 7C       12850         ld      a,h                 ; calculate attr pos
7664 E618     12860         and     $18
7666 CB2F     12870         sra     a
7668 CB2F     12880         sra     a
766A CB2F     12890         sra     a
766C C658     12900         add     a,$58
766E 67       12910         ld      h,a
766F 3E02     12920         ld      a,2
7671 08       12930         ex      af,af'
7672 0602     12940 sfrat1  ld      b,2
7674 E5       12950         push    hl
7675 7E       12960 sfratlp ld      a,(hl)
7676 12       12970         ld      (de),a
7677 3604     12980         ld      (hl),4              ; fill frog attr
7679 23       12990         inc     hl
767A 13       13000         inc     de
767B E607     13010         and     7                   ; test crash
767D 2805     13020         jr      z,nfrog3
767F 3E01     13030         ld      a,1
7681 327C6F   13040         ld      (crhflg),a
7684 10EF     13050 nfrog3  djnz    sfratlp
7686 E1       13060         pop     hl
7687 08       13070         ex      af,af'
7688 3D       13080         dec     a
7689 C8       13090         ret     z
768A 08       13100         ex      af,af'
768B 0E20     13110         ld      c,32
768D ED42     13120         sbc     hl,bc
768F 18E1     13130         jr      sfrat1
              13140 ;
              13150 ;
7691 AF       13160 crash   xor     a
7692 327C6F   13170         ld      (crhflg),a          ; reset crash flag
7695 32796E   13180         ld      (frgext),a          ; set frog nonexist
7698 CDA776   13190         call    frgdie
769B CDD675   13200         call    resfrg
769E 21826F   13210         ld      hl,numfrg
76A1 35       13220         dec     (hl)                ; decrease frog number
76A2 C0       13230         ret     nz
76A3 32776F   13240         ld      (gamflg),a          ; zeroise game flag
76A6 C9       13250         ret                         ; when no frog left
              13260 ;
              13270 ;
76A7 2A786F   13280 frgdie  ld      hl,(oldfrg)         ; old pos of frg
76AA 010240   13290         ld      bc,$4002            ; red colour
76AD D9       13300         exx
76AE 21396F   13310         ld      hl,dieton           ; set die tone
76B1 D9       13320         exx
76B2 7C       13330         ld      a,h                 ; test end of journey
76B3 B8       13340         cp      b
76B4 2016     13350         jr      nz,notend
76B6 7D       13360         ld      a,l
76B7 B8       13370         cp      b
76B8 3012     13380         jr      nc,notend
76BA 11466F   13390         ld      de,score+3          ; 100 pts bonus
76BD EB       13400         ex      de,hl
76BE 34       13410         inc     (hl)
76BF 21476F   13420         ld      hl,score+4
76C2 CD4B77   13430         call    disscr
76C5 0E06     13440         ld      c,6                 ; yellow
76C7 D9       13450         exx
76C8 21156F   13460         ld      hl,homton
76CB D9       13470         exx
76CC 79       13480 notend  ld      a,c
76CD 32656F   13490         ld      (attr),a
76D0 2A786F   13500         ld      hl,(oldfrg)
76D3 ED5B7E6E 13510         ld      de,(newfrg)
76D7 CD7A70   13520         call    drwfrg
76DA 112000   13530         ld      de,32               ; line adjust
76DD 19       13540         add     hl,de
76DE 08       13550         ex      af,af'
76DF 3A656F   13560         ld      a,(attr)
76E2 08       13570         ex      af,af'
76E3 0605     13580         ld      b,5
76E5 C5       13590 flaslp  push    bc                  ; attribute ptr
76E6 E5       13600         push    hl                  ; blank ink black paper
76E7 AF       13610         xor     a
76E8 77       13620         ld      (hl),a
76E9 23       13630         inc     hl
76EA 77       13640         ld      (hl),a
76EB ED52     13650         sbc     hl,de
76ED 77       13660         ld      (hl),a
76EE 2B       13670         dec     hl
76EF 77       13680         ld      (hl),a
76F0 CD0877   13690         call    frgton              ; generate froh tone
76F3 E1       13700         pop     hl
76F4 E5       13710         push    hl
76F5 08       13720         ex      af,af'
76F6 77       13730         ld      (hl),a              ; black paper, red or
76F7 23       13740         inc     hl                  ; yellow ink
76F8 77       13750         ld      (hl),a
76F9 A7       13760         and     a
76FA ED52     13770         sbc     hl,de
76FC 77       13780         ld      (hl),a
76FD 2B       13790         dec     hl
76FE 77       13800         ld      (hl),a
76FF 08       13810         ex      af,af'
7700 CD0877   13820         call    frgton
7703 E1       13830         pop     hl
7704 C1       13840         pop     bc
7705 10DE     13850         djnz    flaslp
7707 C9       13860         ret
              13870 ;
              13880 ;
7708 D9       13890 frgton  exx
7709 E5       13900         push    hl
770A CDB577   13910         call    tone1
770D E1       13920         pop     hl
770E 010400   13930         ld      bc,4                 ; move down database
7711 08       13940         ex      af,af'
7712 FE06     13950         cp      6
7714 2804     13960         jr      z,home
7716 01FCFF   13970         ld      bc,-4                ; move up database
7719 09       13980 home    add     hl,bc
771A D9       13990         exx
771B 08       14000         ex      af,af'
771C C9       14010         ret
              14020 ;
              14030 ;    
771D 3A796E   14040 calscr  ld      a,(frgext)          ; test existence
7720 A7       14050         and     a
7721 C8       14060         ret     z                   ; no update of score
7722 3A5E6F   14070         ld      a,(updwn)           ; test up/down movement
7725 A7       14080         and     a                   ; test any score
7726 C8       14090         ret     z
7727 21476F   14100         ld      hl,score+4          ; add 10 to score
772A CD7F     14110         bit     7,a                 ; test move down
772C 2003     14120         jr      nz,dwnscr           ; down score
772E 34       14130         inc     (hl)
772F 181A     14140         jr      disscr              ; dis score
7731 3A796F   14150 dwnscr  ld      a,(oldfrg+1)        ; test hob
7734 FE40     14160         cp      $40                 ; test first block
7736 2009     14170         jr      nz,tlhwy            ; test low highway
7738 3A786F   14180         ld      a,(oldfrg)
773B FEC0     14190         cp      $0c0                ; not even step on hwy
773D D8       14200         ret     c
773E 34       14210         inc     (hl)
773F 180A     14220         jr      disscr
7741 FE50     14230 tlhwy   cp      $50                 ; test in low hwy
7743 C0       14240         ret     nz
7744 3A786F   14250         ld      a,(oldfrg)
7747 FE20     14260         cp      $20
7749 D0       14270         ret     nc                  ; no score if step hwy
774A 34       14280         inc     (hl)
774B 0604     14290 disscr  ld      b,4                 ; hl => tenth's pos
774D 7E       14300 addlop  ld      a,(hl)
774E FE3A     14310 crylop  cp      $3a                 ; carry loop
7750 3807     14320         jr      c,upddig            ; update digit
7752 D60A     14330         sub     10
7754 2B       14340         dec     hl
7755 34       143450        inc     (hl)
7756 23       14360         inc     hl
7757 18F5     14370         jr      crylop
7759 77       14380 upddig  ld      (hl),a
775A 2B       14390         dec     hl
775B 10F0     14400         djnz    addlop
775D 21446F   14410         ld      hl,score+1
7760 CD6F77   14420         call    scrimg              ; score image
7763 210640   14430         ld      hl,$4006
7766 11596F   14440         ld      de,image
7769 0605     14450         ld      b,5
776B CD2873   14460         call    disasc
776E C9       14470         ret
              11480 ;
              14490 ;
776F 11596F   14500 scrimg  ld      de,image
7772 010500   14510         ld      bc,5
7775 EDB0     14520         ldir
7777 21596F   14530         ld      hl,image
777A 013004   14540         ld      bc,$0430
777D 79       14550 prezer  ld      a,c
777E BE       14560         cp      (hl)                ; test $30
777F 2005     14570         jr      nz,prezex
7781 3620     14580         ld      (hl),$20            ; space fill
7783 23       14590         inc     hl
7784 10F7     14600         djnz    prezer
7786 C9       14610 prezex  ret
              14620 ;
              14630 ;
7787 3EBF     14640 siren   ld      a,$0bf
7789 DBFE     14650         in      a,($0fe)
778B E601     14660         and     1
778D 2009     14670         jr      nz,nsound
778F 3A736F   14680         ld      a,(soundf)          ; reset sound condition
7792 3C       14690         inc     a
7793 E601     14700         and     1
7795 32736F   14710         ld      (soundf),a
7798 3A736F   14720 nsound: ld      a,(soundf)
779B A7       14730         and     a
779C 2825     14740         jr      z,delay
779E 3A726F   14750         ld      a,(chase)           ; is police car on
77A1 A7       14760         and     a
77A2 281F     14770         jr      z,delay
77A4 3A746F   14780         ld      a,(tonflg)
77A7 3C       14790         inc     a
77A8 E601     14800         and     1
77AA 32746F   14810         ld      (tonflg),a
77AD 210D6F   14820         ld      hl,pcton1
77B0 2803     14830         jr      z,tone1
77B2 21116F   14840         ld      hl,pcton2
77B5 5E       14850 tone1   ld      e,(hl)              ; de=duration*frequency
77B6 23       14860         inc     hl
77B7 56       14870         ld      d,(hl)
77B8 23       14880         inc     hl
77B9 4E       14890         ld      c,(hl)
77BA 23       14900         inc     hl
77BB 46       14910         ld      b,(hl)
77BC C5       14920         push    bc
77BD E1       14930         pop     hl                  ; hl=437500/freq-30.125
77BE CDB503   14940         call    $03b5
77C1 F3       14950         di
77C2 C9       14960         ret
77C3 010018   14970 delay   ld      bc,6144
77C6 0B       14980 wait    dec     bc
77C7 78       14990         ld      a,b
77C8 B1       15000         or      c
77C9 20FB     15010         jr      nz,wait
77CB C9       15020         ret
              15030 ;
              15040 ;
77CC E5       15050 randno  push    hl
77CD C5       15060         push    bc
77CE 2A756F   15070         ld      hl,(rnd)
77D1 46       15080         ld      b,(hl)
77D2 23       15090         inc     hl
77D3 3E3F     15100         ld      a,$3f               ; bound pointer within ROM
77D5 A4       15110         and     h
77D6 67       15120         ld      h,a
77D7 78       15130         ld      a,b
77D8 22756F   15140         ld      (rnd),hl
77DB C1       15150         pop     bc
77DC E1       15160         pop     hl
77DD C9       15170         ret
              15180 ;
              15190 ;
77DE 21446F   15200 over    ld      hl,score+1          ; high score manage
77E1 11546F   15210         ld      de,hiscr
77E4 0605     15220         ld      b,5
77E6 1A       15230 sortlp  ld      a,(de)
77E7 BE       15240         cp      (hl)
77E8 2803     15250         jr      z,samscr            ; test 1st ne degit
77EA D0       15260         ret     nc
77EB 1805     15270         jr      scrgt               ; update high score
77ED 13       15280 samscr  inc     de
77EE 23       15290         inc     hl
77EF 10F5     15300         djnz    sortlp
77F1 C9       15310         ret
77F2 21446F   15320 scrgt   ld      hl,score+1
77F5 11546F   15330         ld      de,hiscr
77F8 010500   15340         ld      bc,5
77FB EDB0     15350         ldir
77FD C9       15360         ret
              15370 ;
              15380 ;    
77FE 3E38     15390 final   ld      a,56                ; set white border
7800 32485C   15400         ld      (23624),a
7803 210040   15410         ld      hl,$4000            ; start of screen
7806 110140   15420         ld      de,$4001
7809 01FF17   15430         ld      bc,6143             ; size of screen
780C 3600     15440         ld      (hl),0
780E EDB0     15450         ldir
7810 210058   15460         ld      hl,$5800            ; start of attribute file
7813 110158   15470         ld      de,$5801
7816 01FF02   15480         ld      bc,767
7819 3638     15490         ld      (hl),56             ; white paper black ink
781B EDB0     15500         ldir
781D C9       15510         ret
              15520 ;
              15530 ;
6978          15540         end     start
00000 Total errors
