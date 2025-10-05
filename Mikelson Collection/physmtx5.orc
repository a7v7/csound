;-------------------------------------------------------------
; BIG DOOR
; CODED:        1/22/97 HANS MIKELSON
;-------------------------------------------------------------
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1    
          zakinit   30, 30

;---------------------------------------------------------------------------
; BIG DOOR
;---------------------------------------------------------------------------
          instr  1

idur      =         p3
iamp      =         p4          ; AMPLITUDE
ifqc      =         cpspch(p5)  ; CONVERT TO FREQUENCY
itab1     =         p6          ; INITIAL TABLE
imeth     =         p7          ; METHOD
iruff     =         p8

kamp      linseg    0, .001, iamp, idur-.002, iamp, .001, 0      ; DECLICK

aplk      pluck     kamp, ifqc, ifqc, itab1, imeth, iruff        ; PLUCK WAVEGUIDE MODEL
          out       aplk                                         ; WRITE TO OUTPUT
          endin

          instr   8  ; DRUM STICK 1

idur      init      p3
iamp      init      p4
ifqc      =         cpspch(p5)
itab      init      p6
ifco      init      p7
imeth     init      p8
ioutch    init      p9

if (imeth!=1) goto next1
ashape    oscil     iamp, ifqc, itab
          goto finish
          next1:
ashape    rand      iamp
finish:

astick    tone      ashape, ifco
          zawm      astick, ioutch

          endin

          instr 9  ; A SQUARE DRUM

iamp      init      p4
ifqc      init      cpspch(p5)
ilength   init      p6
iwidth    init      p7
ifdbkdrum init      p8/3
ifcodrum  init      p9
itube     init      p10
ifdbktube init      p11
ifcotube  init      p12
inch      init      p13
idiagnl   =         sqrt(iwidth * iwidth + ilength * ilength)

anodea    init      0
anodeb    init      0
anodec    init      0
anoded    init      0
afiltr    init      0

astick    zar       inch

; AMPLITUDE ENVELOPE
kampenv   linseg    0, .001, p4, p3 - .002, p4, .001, 0

; DELAY LINES
alineab   delay     anodea + astick + afiltr, ilength / ifqc
alineba   delay     anodeb + astick + afiltr, ilength / ifqc
alinebc   delay     anodeb + astick + afiltr, iwidth / ifqc
alinecb   delay     anodec + astick + afiltr, iwidth / ifqc
alinecd   delay     anodec + astick + afiltr, ilength / ifqc
alinedc   delay     anoded + astick + afiltr, ilength / ifqc
alinead   delay     anodea + astick + afiltr, iwidth / ifqc
alineda   delay     anoded + astick + afiltr, iwidth / ifqc
alineac   delay     anodea + astick + afiltr, idiagnl / ifqc
alineca   delay     anodec + astick + afiltr, idiagnl / ifqc
alinebd   delay     anodeb + astick + afiltr, idiagnl / ifqc
alinedb   delay     anoded + astick + afiltr, idiagnl / ifqc

; FILTER THE DELAYED SIGNAL AND FEEDBACK INTO THE DELAY.
; IMPLEMENTS DC BLOCKING.
asuma     =         -(alineba + alineca + alineda) * ifdbkdrum
afilta    butterlp  asuma, ifcodrum
anodea    butterhp  afilta, 10

; NODE B
asumb     =         -(alineba + alineca + alineda) * ifdbkdrum
afiltb    butterhp  asumb, ifcodrum
anodeb    butterhp  afiltb, 10

; NODE C
asumc     =         -(alineba + alineca + alineda) * ifdbkdrum
afiltc    butterhp  asumc, ifcodrum
anodec    butterhp  afiltc, 10

; NODE D
asumd     =         -(alineba + alineca + alineda) * ifdbkdrum
afiltd    butterhp  asumd, ifcodrum
anoded    butterhp  afiltd, 10

; BODY RESONANCE
atube     delay     anodea, itube / ifqc
afiltr    butterlp  atube, ifcotube
afiltr    =         afiltr * ifdbktube

; SCALE AND OUTPUT
          out       anodea*kampenv
          zacl      0,30

          endin
