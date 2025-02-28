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
frog2:
69D7 1F       00200     db      31,31,31,127,252,193,113,56
     1F 1F 7F FC C1 71 38
69DF FE       00210     db      254,244,248,240,192,156,240,192
     F4 FB F0 CD 9C F0 C0
69E7 3B       00220    db      56,113,193,252,127,31,31,31
    db      192,240,156,192,240,248,244,254
frog3:
    db      255,223,79,111,37,35,1,0
    db      255,251,242,246,164,196,128,0
    db      48,120,216,220,159,31,15,111
    db      12,30,27,59,249,248,240,246
frog4:
    db      127,47,31,15,3,57,15,3
    db      240,240,248,254,63,131,142,28
    db      3,15,57,3,15,31,47,127
    db      28,142,131,63,254,248,240,240
;
;
lbike:
    db      0,0,0,0,0,0,0,0
    db      31,63,115,81,169,112,112,32
    db      254,252,252,234,213,206,14,4
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      1,3,1,0,3,4,14,31
    db      128,192,192,224,224,112,119,255
    db      0,0,0,0,0,0,0,0
;
lbatt:
    db      0,7,7,0
    db      0,7,7,0    
;
rbike:
    db      0,0,0,0,0,0,0,0
    db      127,63,63,87,171,115,112,32
    db      248,252,206,138,149,14,14,4
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      1,3,3,7,7,14,238,255
    db      128,192,128,0,192,32,112,248
    db      0,0,0,0,0,0,0,0
;
rbatt:
    db      0,7,7,0
    db      0,7,7,0
;
;    
lcar:
    db      0,0,0,0,0,0,0,0
    db      0,0,3,7,15,2,0,0
    db      7,255,255,159,111,247,240,96
    db      128,255,255,255,255,254,0,0
    db      240,254,255,159,111,256,240,96
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,63,97,193
    db      0,0,0,0,0,0,128,192
    db      0,0,0,0,0,0,0,0
;
lcatt:
    db      0,6,6,6,6,0
    db      0,0,0,6,6,0
;
;    
rcar:
    db      0,0,0,0,0,0,0,0
    db      15,127,255,249,246,111,15,6
    db      1,255,255,255,255,127,0,0
    db      244,255,255,249,246,239,15,6
    db      0,0,192,224,240,64,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,1,3
    db      0,0,0,0,0,252,134,131
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
;
rcatt:
    db      0,2,2,2,2,0
    db      0,2,2,0,0,0
;
;
ltruck:
    db      0,0,0,0,0,0,0,0
    db      31,31,31,62,61,59,3,1
    db      248,252,254,127,184,216,192,128
    db      255,255,255,255,6,15,15,6
    db      255,255,255,0,0,0,0,0
    db      255,255,255,0,0,0,0,0
    db      255,255,255,0,6,15,15,6
    db      254,254,254,4,50,122,122,48
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,7,9,17,17,31,31
    db      2,2,250,250,254,252,252,248
    db      255,255,255,255,255,255,255,255
    db      255,255,255,255,255,255,255,255
    db      255,255,255,255,255,255,255,255
    db      255,255,255,255,255,255,255,255
    db      254,254,254,254,254,254,254,254
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,255,255,255
    db      0,0,0,0,0,255,255,255
    db      0,0,0,0,0,255,255,255
    db      0,0,0,0,0,255,255,255
    db      0,0,0,0,0,254,254,254
    db      0,0,0,0,0,0,0,0
;
ltatt:
    db      0,3,3,5,5,5,5,5,0
    db      0,3,3,5,5,5,5,5,0
    db      0,0,0,5,5,5,5,5,0
;
;
rtruck:
    db      0,0,0,0,0,0,0,0
    db      127,127,127,32,76,94,94,12
    db      255,255,255,0,96,240,240,96
    db      255,255,255,0,0,0,0,0
    db      255,255,255,0,0,0,0,0
    db      255,255,255,255,96,240,240,96
    db      31,63,127,254,29,27,3,1
    db      248,248,248,124,188,220,192,128
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      127,127,127,127,127,127,127,127
    db      255,255,255,255,255,255,255,255
    db      255,255,255,255,255,255,255,255
    db      255,255,255,255,255,255,255,255
    db      255,255,255,255,255,255,255,255
    db      64,64,95,95,127,63,63,31
    db      0,0,244,144,136,136,248,248
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,127,127,127
    db      0,0,0,0,0,255,255,255
    db      0,0,0,0,0,255,255,255
    db      0,0,0,0,0,255,255,255
    db      0,0,0,0,0,255,255,255
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
    db      0,0,0,0,0,0,0,0
;
rtatt:
    db      0,5,5,5,5,5,3,3,0
    db      0,5,5,5,5,5,3,3,0
    db      0,5,5,5,5,5,0,0,0
;
;
blank:
    db      0,0,0,0
;
;
frgstr:
    ds      36                  ; 4*8+4
pcstr:
    ds      120                 ; 12*8+12+7
;
;    
; *********************** DATABASE ***********************
ob1ext:
    defb    0                   ; object 1 existence
    defb    0                   ; cycle count
    defb    0                   ; direction, 0=>right
    defb    0                   ; object 1 pos real/abs
    defw    0                   ; position counter
    defw    0                   ; shape pointer
    defw    0                   ; attribute pointer
    defb    0                   ; row counter
    defb    0                   ; column pointer
ob2ext:
    db      0,0,0,0             ; ob2 pos real/abs flag
    defw    0
    defw    0
    defw    0
    db      0,0
ob3ext:
    db      0,0,0,0             ; ob3 pos real/abs flag
    defw    0
    defw    0
    defw    0
    db      0,0    
ob4ext:
    db      0,0,0,0             ; ob4 pos real/abs flag
    defw    0
    defw    0
    defw    0
    db      0,0
ob5ext:
    db      0,0,0,0             ; ob5 pos real/abs flag
    defw    0
    defw    0
    defw    0
    db      0,0
ob6ext:
    db      0,0,0,0             ; ob6 pos real/abs flag
    defw    0
    defw    0
    defw    0
    db      0,0
;
;
pcarext:
    defb    0                   ; police car database
pcarcyc:
    defb    0
pcardir:
    defb    0
pcarrap:
    defb    0
pcarpos:
    defw    0
pcarshp:
    defw    0
pcaratt:
    defw    0
pcarrow:
    defb    2
pcarcol:
    defb    6    
;
;
frgext:
    defb    0                   ; frog database
frgcyc:
    defb    0  
frgdir:
    defb    0                   ; 0:up 1:rht 2:down 3:left                        
frgpos:
    defw    0
frogsh:
    defw    0
frgatr:
    defb    0

;
;    
frgdb:
    db      8,8,1
frgstn:
    defw    $50ac
    defw    frog1
    db      4                   ; attr. total 8 chars
;
;    
dbindex:
    defw    rbdb                ; right bike db
    defw    lbdb                ; left bike db
    defw    rcdb                ; right car db
    defw    lcdb                ; left car db
    defw    rtdb                ; right truck db
    defw    ltdb                ; left truck db
;
;    
rbdb:
    db      2,1,0,0             ; ext cnt dir raf
    defw    $481d               ; pos
    defw    rbike               ; right bike
    defw    rbatt               ; attribute
    db      2,4                 ; row col
;
;    
lbdb:
    db      2,1,1,1             
    defw    $48df               
    defw    lbike               
    defw    lbatt               
    db      2,4
;
;    
rcdb:
    db      3,1,0,0             
    defw    $481b               
    defw    rcar               
    defw    rcatt               
    db      2,6
;
;    
lcdb:
    db      3,1,1,1             
    defw    $48df              
    defw    lcar               
    defw    lcatt               
    db      2,6
;
;    
rtdb:
    db      6,1,0,0             
    defw    $4818              
    defw    rtruck               
    defw    rtatt               
    db      3,9
;
;    
ltdb:
    db      6,1,1,1             
    defw    $48df            
    defw    ltruck               
    defw    ltatt               
    db      3,9
;
;    
lpcdb:
    db      1,1,1,1
    defw    $48df
    defw    lcar
    defw    lpcatt
    db      2,6
;
;
lpcatt:
    db      0,5,5,5,5,0
    db      0,0,0,5,5,0
;
;    
rpcdb:
    db      1,1,0,0
    defw    $481b
    defw    rcar
    defw    rpcatt
    db      2,6
;
;    
rpcatt:
    db      0,5,5,5,5,0
    db      0,5,5,0,0,0
;
;
pcton1:
    db      41,0,$0f0,1         ; first police car tone
pcton2:
    db      23,0,$8c,3          ; second police car tone     
;
;
homton:
    db      $46,0,$0c7,4        ; frog rech home tone
    db      $5d,0,$8c,3
    db      $7c,0,$0a1,2
    db      $0aa,0,$0f1,1
    db      $0de,0,$6d,1
    db      $28,1,9,1
    db      $8b,1,$0bf,0
    db      $0f,2,$88,0
    db      $0c0,2,$5e,0
dieton:
    db      $84,3,$43,0         ; frog dying tone, reverse
;
;        
scrms1:
    defm    "Score "
score:
    db      $30,$30,$30,$30,$30,$30
scrms2:
    defm    "HIGH SCORES"
hiscr:
    db      $30,$30,$30,$30,$30    
;
;
image:
    ds      5                   ; printing image of score
updwn:
    defb    0                   ; set when frog moves up or down
;
;
column:
    db      0                   ; variable storing shape column
row:
    db      0                   ; variable storing shape row
skip:
    defb    0                   ; char skipping during draw
fill:
    defb    0                   ; char drawn
attpos:
    defw    0                   ; holding the atrribute file ptr
attr:
    db      0                   ; attr of character block drawn
drwpos:
    defw    0                   ; draw position
strpos:
    defw    0                   ; store position
;
;
attptr:
    defw    0                   
newpos:
    defw    0                   ; new traffic object position
posptr:
    defw    0                   ; traffic position database ptr
genflg:
    defb    0                   ; traffic regneration flag
;
;    
jamflg:
    defb    0                   ; set to 1 as traffic move jam
;
;
chase:
    defb    0                   ; set when police car appears
soundf:
    defb    0                   ; set when user want siren sound
tonflg:
    defb    0                   ; determine which siren tone
rnd:
    defw    0                   ; pointer to rom for random no.    
;
;    
gamflg:
    defb    1                   ; end if zero
oldfrg:
    defw    0                   ; old frog pos
newfrg:
    defw    0                   ; old frog pos
crhflg:
    defb    0                   ; set to 1 when from was crash
temdir:
    defb    0                   ; frog temporary new direction
tempos:
    defw    0                   ; frog temporary new position
temshp:
    defw    0                   ; frog temporary new shape
;
;
bothy1      equ $5020           ; 0,38.  0,39
bothy2      equ $5120           
tophy1      equ $46a0           ; 0,128. 0,129
tophy2      equ $47a0
midhy1      equ $4b60           ; x,83.  x,84
midhy2      equ $4c60
;
;
chrset      equ $3c00
;
;
numfrg:
    defb    5                   ; number of frog
;
;
init:
    xor     a                   ; 000 for d2 d2 d0
    out     ($0fe),a            ; set border colour
    ld      (23624),a           ; to black
    ld      (crhflg),a
    ld      (frgext),a          ; set frog non exist
    inc     a
    ld      (gamflg),a         ; set game flag
    ld      a,5                 ; initialise frog no.
    ld      (numfrg),a
    ld      a,r                 ; generate random ptr
    and     $3f                 ; for this cycle
    ld      h,a                 ; ptr points to rom
    ld      a,r
    ld      l,a
    ld      (rnd),hl
    ld      hl,$50ac            ; init frog station
    ld      (frgstn),hl
    call    clrscr              ; clear screen routine
    call    drwhwy              ; draw highway
    call    lineup              ; line up all exist frogs
    ld      hl,$4000            ; message location
    ld      de,scrms1           ; load score message
    ld      b,6
    call    disasc              ; display ascii character
    ld      hl,score+1          ; print score
    call    scrimg              ; convert to printable image
    ld      hl,$4006
    ld      de,image
    ld      b,5
    call    disasc
    ld      hl,$400e            ; high score message
    ld      de,scrms2
    ld      b,11
    call    disasc
    ld      hl,hiscr
    call    scrimg
    ld      hl,$4019
    ld      de,image
    ld      b,5
    call    disasc
    ld      hl,ob1ext           ; set all obj nonexist
    ld      de,12
    ld      b,7
    xor     a
intlp1:
    ld      (hl),a
    add     hl,de
    djnz    intlp1
    ld      (chase),a           ; set no police car chase
    inc     a
    ld      (soundf),a          ; set siren on
    ld      hl,score            ; initialise score to
    ld      de,score+1          ; ascii zero ie $30
    ld      c,5
    ld      (hl),$30
    ldir                        ; init score to $30
    ret
;
;
drwhwy:
    ld      hl,$40a0            ; fill top hwy
    call    filhwy
    ld      hl,$4860            ; fill middle hwy
    call    filhwy
    ld      hl,$5020            ; fill bottom hwy
    call    filhwy
    ld      hl,tophy1           ; reverse build highway
    ld      de,tophy2
    xor     a
    call    highwy
    ld      hl,bothy1
    ld      de,bothy2
    call    highwy
    ld      hl,midhy1
    ld      de,midhy2
    ld      a,195               ; bin 11000011
highwy:
    ld      b,32                ; 32*8 bits
hwylop:
    ld      (hl),a
    ld      (de),a
    inc     hl
    inc     de
    djnz    hwylop
    ret
;
;
filhwy:
    ld      a,$0ff
    exx
    ld      b,32
filhyl:
    exx
    push    hl
    ld      b,8
filchr:
    ld      (hl),a
    inc     h
    djnz    filchr
    pop     hl
    inc     hl
    exx
    djnz    filhyl
    exx
    ret
;
;
; *********************** LINEUP ***********************
;
; draw all frogs left of screen
;
lineup:
    ld      a,1                 ; right frog
    ld      (frgdir),a
    ld      de,frog2            ; right frog shape
    ld      hl,(frgstn)         ; frog station
    ld      a,4                 ; (paper 0) * 8 + (ink 4)
    ld      (attr),a
    ld      a,(numfrg)          ; number of frog
    and     a                   ; test for number of frog left
    ret     z
    ld      b,a                 ; number of frog times
drawln:
    push    bc
    push    de
    push    hl
    call    drwfrg             ; draw frog routine
    pop     hl
    pop     de
    dec     hl
    dec     hl
    dec     hl
    pop     bc
    djnz    drawln
    ret
;
;    
; *********************** DRWFRG ***********************
; similar to draw routine
;
drwfrg:
    ld      a,2                 ; two row frog shape
    ex      af,af'
    push    hl                  ; store pos ptr
frglp0:
    push    hl
    ld      c,2                 ; column count
frglp1:
    push    hl
    ld      b,8                 ; draw character
frglp2:
    ld      a,(de)
    ld      (hl),a
    inc     de
    inc     h                   ; next byte of the char
    djnz    frglp2
    pop     hl                  ; current pointer
    inc     hl                  ; moce to next char pos
    dec     c                   ; decr  column count
    jr      nz,frglp1           
    pop     hl                  ; row ptr
    ex      af,af'              
    dec     a                   ; dec lines of char
    ld      c,32
    jr      z,frgatt            ; load frog attribute
    ex      af,af'
    and     a
    sbc     hl,bc               ; move 32 char/1 line up
    bit     0,h                 ; test cross scr section
    jr      z,frglp0
    ld      a,h
    sub     7                   ; up one screen section
    ld      h,a
    jr      frglp0
frgatt:
    pop     hl                  ; pos ptr
    ld      a,h                 ; convert to attribute ptr
    and     $18
    sra     a
    sra     a
    sra     a
    add     a,$58
    ld      h,a
    ld      a,(attr)            ; fill frog shape attr
    ld      (hl),a
    inc     hl                  ; next character
    ld      (hl),a
    sbc     hl,bc               ; one line up
    ld      (hl),a
    dec     hl                  ; next char left
    ld      (hl),a
    ret
;
;
; *********************** TFCTRL ***********************
; traffic control routine
;
tfctrl:
    ld      hl,genflg           ; check regneration flag
    xor     a                   
    cp      (hl)
    jr      z,gener             ; if zero test generate
    dec     (hl)                ; decr generation flag
    ret
gener:
    ld      hl,ob1ext           ; start of traffic db
    ld      de,12               ; 12 byte database
    ld      b,6                 ; 6 db pairs
tctrlp:
    cp      (hl)                ; test existence
    jr      nz,nspace
    call    regen               ; regeneration routine
    ret
nspace:
    add     hl,de
    djnz    tctrlp
    ret
;
;
; *********************** REGEN ***********************
; regneration of traffic
; INPUT:    HL=>DB PAIRS
;
regen:
    push    hl
rand1:
    call    randno              ; random number routine
    and     7                   ; generate random number
    cp      6                   ; from 0 to 5
    jr      nc,rand1
    ld      bc,$5921            ; two char test
    ld      hl,$5920            ; test jam
    bit     0,a                 ; odd number is left
    jr      z,rtraf             ; right traffic
    ld      l,$0df
    ld      c,$0de
rtraf:
    add     a,a                 ; get dbindex ptr in de
    ld      e,a
    ld      a,(bc)              ; test 2 char ahead
    add     a,(hl)
    and     a                   ; zero paper, zero ink
    jr      z,loaddb            ; if 0, initialise new obj
    pop     hl                  ; if jam, return
    ret
loaddb:
    ld      d,a                 ; a = 0
    ld      hl,dbindex          ; get db
    add     hl,de
    ld      e,(hl)              ; get corr database
    inc     hl
    ld      d,(hl)
    ex      de,hl               ; source
    pop     de                  ; destination
    ld      bc,12
    ldir
    ld      a,2                 ; set regeneration flag
    ld      (genflg),a          ; skip for 2 cycles
    ret
;
;    
; *********************** MOVTRF ***********************
; move traffic routine
;
movtrf:
    exx
    ld      hl,ob1ext
    ld      de,12
    ld      b,6
mtrflp
    push    hl
    exx
    pop     hl                  ; existence
    ld      a,(hl)              ; skip when no exist
    and     a
    jp      z,nxtmov
    inc     hl                  ; cycle count
    dec     (hl)                ; decr cycle count
    jp      nz,nxtmov
    inc     hl                  ; direction
    ld      a,(hl)              ; 0 L to R, 1 R to L
    inc     hl
    inc     hl
    ld      (posptr),hl         ; pos ptr
    ld      e,(hl)              ; restore pos
    inc     hl
    ld      d,(hl)
    inc     e                   ; move right
    and     a
    jr      z,ldpos
    dec     e                   ; move left
    dec     e                   ; move left
ldpos:
    ld      (newpos),de
    ex      af,af'
    ld      bc,5                 ; restore obj length
    add     hl,bc
    ld      a,(hl)              ; row
    ld      (row),a
    inc     hl
    ld      a,(hl)              ; column
    ld      (column),a          
    dec     a
    ld      c,a
    ex      af,af'
    and     a                   ; test direction
    ex      de,hl
    jr      nz,rtol             ; right to left
    add     hl,bc               ; find head of truck
    ld      a,l                 ; lob
    cp      $40                 ; test right edge
    jr      nc,moveok           ; skip test adhead if off
    jr      testah              ; test ahead
rtol:
    ld      a,l                 ; new position, ahead as well
    cp      $0c0                ; test left edge
    jr      c,moveok            ; skip test ahead
testah:
    ld      a,h                 ; covert to attr
    and     $18
    sra     a
    sra     a
    sra     a
    add     a,$58
    ld      h,a
    ld      bc,32
    xor     a
    ld      (jamflg),a          ; initialise jam flag
    ld      a,(row)
tahlop:
    ex      af,af'
    ld      a,(hl)              ; retrieve attr
    and     7
    jr      z,tfrog1            ; jump if black ink
    cp      4                   ; test for green, frog
    jr      nz,jam1             ; jam if not a frog
    ld      a,1                 ; move if it is a frog
    ld      (crhflg),a          ; set frog crash
    jr      tfrog1
jam1:
    ld      (jamflg),a          ; set jamflg non zero
tfrog1:
    and     a
    sbc     hl,bc
    ex      af,af'
    dec     a                   ; update row
    jr      nz,tahlop
    ld      a,(jamflg)          ; test traffic jam
    and     a
    jr      z,moveok            ; move if no jam
    exx                         ; else stop move one cycle
    inc     hl
    inc     (hl)                ; load 2 to cycle count
    inc     (hl)
    dec     hl
    exx
    jr      nxtmov
moveok:
    ld      hl,(posptr)         ; retrieve ptr to pos
    ld      de,(newpos)
    ld      (hl),e              ; store newpos on db
    inc     hl
    ld      (hl),d
    call    mvctrl              ; movement control   
nxtmov:
    exx
    add     hl,de
    dec     b
    jp      nz,mtrflp
    exx
    ret    
;
;
; *********************** MVCTRL ***********************
; Traffic movement control routine
;
mvctrl:
    dec     hl
    dec     hl
    ld      a,e                 ; de=>newpos, hl=>db ptr
    and     $1f                 ; test edge
    jr      nz,chgraf           ; change real abs flag
    ld      a,(hl)
    inc     a
    and     1
    ld      (hl),a
chgraf:
    dec     hl                  ; pt dir
    ld      a,(hl)
    and     a
    jr      nz,toleft           ; right to left
    ld      a,e
    and     $1f                 ; if to right and abs
    jr      nz,drwobj           
    inc     hl                  ; get raf
    ld      a,(hl)
    dec     hl                  ; pt to dir
    and     a                   ; if abstract, dies
    jr      nz,drwobj
    exx
    ld      (hl),a              ; set non existence
    exx
    ret
toleft:
    ld      a,(column)
    ld      c,a
    ex      de,hl               ; test end of object
    add     hl,bc               ; touches left edge
    ld      a,l
    cp      $0c0
    ex      de,hl
    jr      nz,drwobj
    exx                         ; object nonexist as
    ld      (hl),0              ; it moves off screen
    exx
    ret
drwobj:
    exx
    ld      a,(hl)
    inc     hl
    ld      (hl),a              ; refill cycle count
    dec     hl
    exx
    inc     hl
    push    hl                  ; refill cycle count
    inc     hl
    inc     hl
    inc     hl
    ld      e,(hl)              ; retrieve shape ptr
    inc     hl
    ld      d,(hl)
    inc     hl
    ld      c,(hl)              ; retrieve attr ptr
    inc     hl
    ld      b,(hl)
    ld      (attptr),bc
    inc     hl
    ld      a,(hl)
    ld      (row),a
    inc     hl
    ld      a,(hl)
    ld      (column),a
    pop     hl
    ld      a,(hl)              ; raflag
    ld      hl,(newpos)
    call    draw
    ret
;
;
; *********************** DRAW ***********************
; input :   hl=>start of display pos
;           de=>ptr to shape db
;           a =>position of real/abstract flag
;           c =>no. of col to be display
;           col pass as var
;
; var       column, row, attr, drwpos, skip, fill
;
; reg:      a,bc,de,hl,a'
;
draw:
    call    rshape              ; return row/col attptr
    ld      a,(row)
    ex      af,af'
lp0:
    push    de
    push    hl                  ; store line ptr
    ld      a,(skip)
    ld      c,a
    ld      b,0
    add     hl,bc               ; skip pos ptr
    add     a,a                 ; multiple of 8 bytes
    add     a,a
    add     a,a
    ld      c,a                 ; skip shape ptr
    ex      de,hl
    add     hl,bc
    ex      de,hl
    bit     0,h                 ; cross screen section
    jr      z,noskip
    ld      a,7                 ; if yes, move up
    add     a,h
    ld      h,a
noskip:
    ld      a,(fill)
    and     a
    jr      z,nxt
    ld      c,a                 ; column to be filled
lp1:
    push    hl                  ; fill character
    ld      b,8
lp2:
    ld      a,(de)              ; fill character bytes
    ld      (hl),a
    inc     de
    inc     h
    djnz    lp2
    pop     hl
    dec     c
    jr      z,nxt
    inc     hl                  ; next character
    jr      lp1
nxt:
    ex      af,af'
    pop     hl                  ; restore line ptr
    pop     de                  ; shape db ptr
    dec     a                   ; update row count
    jr      z,ldattr
    ex      af,af'
    and     a                   ; clear carry
    ld      c,$20
    sbc     hl,bc               ; one line up
    bit     0,h                 ; cross screen section
    jr      z,moddb
    ld      a,h
    sub     7
    ld      h,a
moddb:
    ld      a,(column)
    add     a,a
    add     a,a
    add     a,a                 ; update shape db
    ld      c,a
    ex      de,hl
    add     hl,bc
    ex      de,hl
    jr      lp0
ldattr:
    ld      hl,(attpos)
    ld      de,(attptr)
    ld      a,(row)
atrow:
    ex      af,af'
    push    de
    push    hl
    ld      a,(skip)
    ld      c,a
    ld      b,0
    add     hl,bc               ; skip attribute file
    ex      de,hl
    add     hl,bc               ; skip attribute database
    ex      de,hl
    ld      a,(fill)
    and     a
    jr      z,skipat            ; skip attribute
    ld      b,a                 ; fill attribute
attr2:
    ld      a,(de)
    ld      (hl),a
    inc     hl
    inc     de
    djnz    attr2
skipat:
    pop     hl
    pop     de
    ld      a,(column)
    and     a                   ; clear carry
    ld      c,$20
    sbc     hl,bc               ; next attribute line up
    ld      c,a
    ex      de,hl
    add     hl,bc               ; update attribute db
    ex      de,hl
    ex      af,af'
    dec     a
    jr      nz,atrow
    ret
;
;
; *********************** RSHAPE ***********************
; input:    hl=>position
;           a=>real/abstract flag
;           de=>shape ptr
;           column
;
; output:   skip, fill, attpos

rshape:
    push    hl
    ex      af,af'              ; real shape
    ld      h,$1f
    ld      a,h
    and     l                   ; trap lower 5 bits
    ld      l,a
    ld      a,h
    sub     l                   ; substract from $1f
    inc     a
    and     h                   ;adjust for zero diff
    ld      l,a
    ex      af,af'
    and     a                   ; 0=>abstract, 1=>real
    ld      a,(column)
    jr      nz,real
    sub     l
    ld      (fill),a
    ld      a,l                 ; reload abs diff
    ld      (skip),a
    jr      calatt
real:
    cp      l                   ; take min of col/fill
    jr      c,toobig            ; fill more than col
    ld      a,l
    and     a
    jr      nz,toobig
    ld      a,(column)
toobig:
    ld      (fill),a
    xor     a
    ld      (skip),a
calatt:
    pop     hl
    push    hl
    ld      a,h
    and     $18
    sra     a
    sra     a
    sra     a
    add     a,$58
    ld      h,a
    ld      (attpos),hl
    pop     hl
    ret
;
;
clrscr:
    ld      hl,$4000            ; hl => start of screen        
    ld      de,$4001
    ld      bc,6143             ; size of screen $17ff
    xor     a                   ; blank screen
    ld      (hl),a
    ldir
    ld      hl,$5800            ; set first line for score
    ld      de,$5801            ; of attribute file
    ld      bc,31
    ld      (hl),7              ; ink seven
    ldir
    ld      hl,$5820            ; set attribute
    ld      de,$5821            ; start from second line
    ld      bc,735
    ld      (hl),a              ; (paper 0) * 8 + (ink 0)
    ldir
    ld      hl,$58a0            ; set highway
    ld      de,$5960            ; high, middle, bottom
    ld      bc,$5a20
    ld      a,56                ; (paper 7) * 8+ (ink 0)
    exx
    ld      b,32                ; fill one line
hwyatt:
    exx
    ld      (hl),a
    ld      (de),a
    ld      (bc),a
    inc     hl
    inc     de
    inc     bc
    exx
    djnz    hwyatt
    exx
    ret
;
;
shape:
    push    hl                  ; save hl ptr
    ld      a,(frgdir)
    add     a,a
    ld      hl,frgshp
    ld      d,0
    ld      e,a
    add     hl,de               ; ptr to pos of shape
    ld      e,(hl)
    inc     hl
    ld      d,(hl)
    pop     hl
    ret 
;
;
; *********************** DISASC ***********************
; display ASCII value from character set
; NB: store DE, the message pointer HL stays them same after 
; display
; used BC register as well

disasc:
    push    bc
    push    de
    push    hl
    ld      a,(de)              ; load ascii char
    ld      l,a
    ld      h,0
    add     hl,hl               ; multiple of 8 bytes
    add     hl,hl
    add     hl,hl
    ex      de,hl
    ld      hl,chrset           ; start of character set
    add     hl,de
    ex      de,hl
    pop     hl
drwchr:
    ld      b,8                 ; draw character
    push    hl
charlp:
    ld      a,(de)
    ld      (hl),a
    inc     de
    inc     h
    djnz    charlp
    pop     hl
    pop     de
    inc     hl                  ; pos ptr
    inc     de                  ; message prt
    pop     bc
    djnz    disasc
    ret
;
;    
police:
    exx
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
    
