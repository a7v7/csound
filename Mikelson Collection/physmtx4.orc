;-------------------------------------------------------------
; PHYSICAL MODELS
; CODED:        1/22/97 HANS MIKELSON
;-------------------------------------------------------------
sr       =           44100
kr       =           4410
ksmps    =           10
nchnls   =           1

;-------------------------------------------------------------
; BASS PHYSICAL MODEL
;-------------------------------------------------------------
         instr  2

; INITIALIZATIONS
;-------------------------------------------------------------
ifqc      init      cpspch(p5)
ipluck    init      1 / ifqc * p6
kcount    init      0
adline    init      0
ablock2   init      0
ablock3   init      0
afiltr    init      0
afeedbk   init      0

;-------------------------------------------------------------
koutenv   linseg 0, .01, 1, p3 - .11, 1, .1, 0    ; AMPLITUDE ENVELOPE
kfltenv   linseg 0, 1.5, 1, 1.5, 0                ; FILTER ENVELOPE

; THIS ENVELOPE LOADS THE STRING WITH A TRIANGLE WAVE.
kenvstr   linseg 0, ipluck / 4, - p4 / 2, ipluck / 2, p4 / 2, ipluck / 4, 0, p3 - ipluck, 0

;-------------------------------------------------------------
aenvstr   =         kenvstr                       ; CONVERT TO AUDIO RATE FOR FILTERING
ainput    tone      aenvstr, ifqc * 2             ; FILTER THE TRIANLE TO ROUND OFF THE PEAK

ablock2   =         afeedbk - ablock3 + .99 * ablock2       ; THIS IS A DC BLOCKING FILTER
ablock3   =         afeedbk                                 ; USED TO PREVENT DRIFT AWAY FROM
ablock    =         ablock2                                 ; ZERO.

;-------------------------------------------------------------
adline    delay     ablock + ainput, 1 / ifqc - 15 / sr     ; DELAY LINE LENGTH 1/FREQUENCY.
afeedbk   tone      adline,400                              ; FILTERED FEEDBACK.

;-------------------------------------------------------------
abody1    reson     afeedbk, 110, 40                        ; TWO BODY RESONANCES ARE ADDED
abody1    =         abody1 / 5000                           ; TO THE TONE.
abody2    reson     afeedbk, 70, 20
abody2    =         abody2 / 50000

;-------------------------------------------------------------
aout      =         afeedbk
          out       50 * koutenv * (aout + kfltenv * (abody1 + abody2))

          endin

;-------------------------------------------------------------
; FLUTE INSTRUMENT BASED ON PERRY COOK'S SLIDE FLUTE
;-------------------------------------------------------------

          instr  3

aflute1   init   0
ifqc      =         cpspch(p5)
ipress    =         p6
ibreath   =         p7
ifeedbk1  =         p8
ifeedbk2  =         p9

;-------------------------------------------------------------
kenv1     linseg    0, .06, 1.1 * ipress, .2, ipress, p3 - .16, ipress, .02, 0 ; FLOW SETUP
kenv2     linseg    0, .01, 1, p3 - .02, 1, .01, 0               ; FLOW MUST BE ABOUT 1 OR IT WILL BLOW UP
kenvibr   linseg    0, .5, 0, .5, 1, p3 - 1, 1                   ; VIBRATO ENVELOPE

;-------------------------------------------------------------
aflow1    rand      kenv1                                             ; NOISE IS USED TO SIMULATE BREATH SOUND.
kvibr     oscil     .1 * kenvibr, 5, 3                                ; LOW FREQUENCY VIBRATO
asum1     =         ibreath * aflow1 + kenv1 + kvibr                  ; ADD FLOW, NOISE AND VIBRATO.
asum2     =         asum1 + aflute1 * ifeedbk1                        ; ADD ABOVE TO SCALED FEEDBACK.
afqc      =         1 / ifqc - asum1 / 20000 - 9 / sr + ifqc / 12000000 ;FIND DELAY LENGTH.

;-------------------------------------------------------------
atemp1    delayr    1 / ifqc / 2                       ; THE EMBOUCHOURE DELAY SHOULD
ax        deltapi   afqc / 2                           ; BE ABOUT 1/2 THE BORE DELAY.
          delayw    asum2

;-------------------------------------------------------------
apoly     =         ax - ax * ax * ax                  ; A POLYNOMIAL IS USED TO ADJUST
asum3     =         apoly + aflute1 * ifeedbk2         ; THE FEEDBACK.

avalue    tone      asum3, 2000

; BORE, THE BORE LENGTH DETERMINES PITCH.  SHORTER IS HIGHER PITCH.
;-------------------------------------------------------------
atemp2    delayr    1 / ifqc
aflute1   deltapi   afqc
          delayw    avalue

          out      avalue * p4 * kenv2

          endin

;-------------------------------------------------------------
; CLARINET INSTRUMENT BASED ON PERRY COOK'S CLARINET
;-------------------------------------------------------------

          instr     4
areedbell init      0
ifqc      =         cpspch(p5)
ifco      =         p7
ibore     =         1/ifqc-15/sr

kenv1     linseg    0,.005,.55+.3*p6,p3-.015,.55+.3*p6,.01,0
kenvibr   linseg    0,.1,0,.9,1,p3-1,1       ; VIBRATO ENVELOPE

kemboff   =         p8                       ; CAN BE USED TO ADJUST REED STIFFNESS.

avibr     oscil     .1 * kenvibr, 5, 3       ; BREATH PRESSURE.
apressm   =         kenv1 + avibr

arefilt   tone      areedbell, ifco          ; REFLECTION FILTER FROM THE BELL IS LOWPASS.

abellreed delay     arefilt, ibore           ; THE DELAY FROM BELL TO REED.

; BACK PRESSURE AND REED TABLE LOOK UP.
asum2     =         - apressm -.95 * arefilt - kemboff
areedtab  tablei    asum2 / 4 + .34, p9, 1, .5
amult1    =         asum2 * areedtab

; FORWARD PRESSURE
asum1     =         apressm + amult1

areedbell delay     asum1, ibore

aofilt    atone     areedbell, ifco

          out       aofilt * p4

          endin

          instr 8  ; DRUM STICK 1

gadrum    init      0

; FREQUENCY
  ifqc    =         cpspch(p5)

; AMP ENVELOPE
;kampenv  linseg    0, .01, 1, p3 - .01, 1

; INITIALIZE THE DELAY LINE WITH NOISE
ashape    linseg    0, 1/ifqc/8, -p4/2, 1/ifqc/4, p4/2, 1/ifqc/8, 0, p3-1/ifqc, 0
gadrum    tone      ashape, p6

          endin

instr 9  ; A SQUARE DRUM

itube     init      p7
ifdbck1   init      p8
ifdbck2   init      p9
iwidth    init      p10
ilength   init      p11
idiagnl   =         sqrt(iwidth * iwidth + ilength * ilength)
ifco      init      2000

anodea   init 0
anodeb   init 0
anodec   init 0
anoded   init 0
afiltr   init 0

; Ê
ifqc      =         cpspch(p5)
ipfilt    =         p6

; AMPLITUDE ENVELOPE
kampenv   linseg    0, .01, p4, p3-.02, p4, .01, 0

; DELAY LINES
alineab   delay     anodea + gadrum + afiltr, ilength / ifqc
alineba   delay     anodeb + gadrum + afiltr, ilength / ifqc
alinebc   delay     anodeb + gadrum + afiltr, iwidth / ifqc
alinecb   delay     anodec + gadrum + afiltr, iwidth / ifqc
alinecd   delay     anodec + gadrum + afiltr, ilength / ifqc
alinedc   delay     anoded + gadrum + afiltr, ilength / ifqc
alinead   delay     anodea + gadrum + afiltr, iwidth / ifqc
alineda   delay     anoded+gadrum+afiltr, iwidth/ifqc
alineac   delay     anodea+gadrum+afiltr, idiagnl/ifqc
alineca   delay     anodec+gadrum+afiltr, idiagnl/ifqc
alinebd   delay     anodeb+gadrum+afiltr, idiagnl/ifqc
alinedb   delay     anoded+gadrum+afiltr, idiagnl/ifqc

; FILTER THE DELAYED SIGNAL AND FEEDBACK INTO THE DELAY.
; IMPLEMENTS DC BLOCKING.
anodea    butterlp  -(alineba + alineca + alineda)/ifdbck1, ifco
anodeb    butterlp  -(alineba + alineca + alineda)/ifdbck1, ifco
anodec    butterlp  -(alineba + alineca + alineda)/ifdbck1, ifco
anoded    butterlp  -(alineba + alineca + alineda)/ifdbck1, ifco

; BODY RESONANCE
atube     delay     anodea, itube / ifqc
afiltr    tone      atube / ifdbck2, 1000

; SCALE AND OUTPUT
aout      butterhp  anodea, 20
          out       aout * kampenv *  1000

          endin

