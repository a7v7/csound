

;MID.ORC




sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


;DRUM
          instr     101
; INITIALIZATION
i1        =         1/p3           ; ONCE PER DURATION - FOR ENVELOPES
i2        =         cpspch(p5)     ; CONVERT OCT. POINT PCH-CLASS NOTATION TO Hz
i3        =         p4/2           ; THESE THREE ASSIGNMENTS BALANCE THE THREE
i4        =         p4/6           ; BRANCHES OF THE DRUM INSTRUMENT
i5        =         p4/2.5

; BRANCH 1 - NOISE
a1        oscili    i3,i1,2        ; GENERATE STEEP EXPONENTIAL ENVELOPE
a1        randi     a1,p6          ; GENERATE BAND OF NOISE WITH FREQ. GIVEN BY p6
a1        oscili    a1,500,4       ; USE NOISE BAND FOR AMP INPUT - RING MOD.

; BRANCH 2 - INHARM
a2        oscili    i4,i1,2        ; STEEP ENVELOPE WITH LOWER AMPLITUDE THAN a1
a2        oscili    a2,i2*.1,3     ; GENERATE INHARMONIC PARTIALS - 1,1.6,2.2,2.3

; BRANCH 3 - FUND
a3        oscili    i5,i1,1        ; DECAY OF f1 IS LESS STEEP THAN f2
a3        oscili    a3,i2,4        ; GENERATES FUNDAMENTAL TONE

; GLOBAL ENVELOPE TO PREVENT CLICKING
a4        linseg    1,p3-.05,1,.05,0,.01,0
          out       a4*(a1+a2+a3)
          endin


          instr     113
;p3=linendur,p4=amp,p5=freq,p6=waveshape(function),p7attack,p8=release
a1        oscil     p4, p5, p6
a4        linen     a1, p7, p3, p8
          out       a4
          endin

          instr     130
idur      =         p3
iamp      =         p4
ifrq      =         p5
iatk      =         p6
irel      =         p7
icut1     =         p8
icut2     =         p9
kenv      linen     iamp, iatk, idur, irel
kcut      expon     icut1, idur, icut2
anoise    rand      ifrq 
afilt2    tone      anoise, kcut
afilt1    tone      afilt2, kcut
          out       afilt1*kenv
          dispfft   afilt1, idur, 4096
          endin


          instr     135
idur      =         p3
iamp      =         p4
ifrq      =         p5
iatk      =         p6
irel      =         p7
irat1     =         p8
irat2     =         p9
imsdel    =         p10
kenv      expseg    .001, iatk, iamp, idur/8, iamp*.3, idur-(iatk+irel+idur/8), iamp*.7, irel,.01
krate     line      irat1, idur, irat2
alfo      oscil     imsdel, krate/idur, 19
anoise    rand      ifrq
adel4     vdelay    anoise, alfo, imsdel
adel3     vdelay    adel4, alfo, imsdel
adel2     vdelay    adel3, alfo, imsdel
adel1     vdelay    adel2, alfo, imsdel
adel0     vdelay    adel1, alfo, imsdel
amix      =         adel0+adel1+adel2+adel3+adel4 
          out       kenv*amix
          dispfft   amix, idur, 1024
          endin



