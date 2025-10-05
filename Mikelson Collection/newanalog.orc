sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 2
       zakinit 50, 50

; Crunchy synth
      instr 4

idur  =     p3
iamp  =     p4            ; Amplitude
ifqc  =     cpspch(p5)    ; Frequency
ipbnd =     p6            ; Pitch bend
ifco  =     p7            ; Fqc cut-off
irez  =     p8            ; Resonance
iovrd =     p9            ; Overdrive
ipanl =     sqrt(p10)     ; Pan left
ipanr =     sqrt(1-p10)   ; Pan right
ifqc1 =     p11
ifqc2 =     p12
iesnd =     p13

asaw  init  0
asaw2 init  0
asaw3 init  0

kpbnd oscil 1, 1/idur, ipbnd ; Pitch bend table
kfco  linseg .2, .1*idur, 1, .2*idur, .8, .6*idur, .7, .1*idur, .3
kamp  linseg 0, .01, 1, .2*idur, 1, .8*idur-.11, 1, .1, 0
kdclk linseg 0, .002, 1, idur-.004, 1, .002, 0

; Band-limited impulse train
apls  buzz    1, ifqc*kpbnd,  sr/4/ifqc/kpbnd, 1
asaw  =       .999*asaw + apls

apls2 buzz    1, ifqc*kpbnd*1.01,  sr/4/ifqc/kpbnd*ifqc1, 1
asaw2 =       .999*asaw2 + apls2

apls3 buzz    1, ifqc*kpbnd*.99,  sr/4/ifqc/kpbnd*ifqc2, 1
asaw3 =       .999*asaw3 + apls3

arez   rezzy  (asaw+asaw2*.5)*.7, ifco*kfco*ifqc*.1/iovrd, 20
arezl1 rezzy  (asaw+asaw2*.5)*.7, ifco*kfco*ifqc*.1/iovrd, 1
arezl2 rezzy  (asaw+asaw3*.5)*.7, ifco*kfco*ifqc*.1/iovrd, 1
adif1 =       arez-arezl1
adif2 =       arez-arezl2
aclp1 =       (arezl1 + 4*tanh(iovrd*adif1))*.5
aclp2 =       (arezl2 + 4*tanh(iovrd*adif2))*.5

aoutl butterlp aclp1, 10000
aoutr butterlp aclp2, 10000

      outs   aclp1*iamp*kamp*ipanl*kdclk, aclp2*iamp*kamp*ipanr*kdclk
      zawm   aclp1*iamp*kamp*ipanl*kdclk*iesnd, 1
      zawm   aclp2*iamp*kamp*ipanr*kdclk*iesnd, 2

      endin

;---------------------------------------------------------------------------
; Stereo delay with feedback and cross-feedback & lp-filter
;---------------------------------------------------------------------------
        instr   16

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itiml   =       p5                                 ; Left delay time
ifdbkl  =       p6                                 ; Left feedback
ixfbl   =       p7                                 ; Left cross feedback
itimr   =       p8                                 ; Right delay time
ifdbkr  =       p9                                 ; Right feedback
ixfbr   =       p10                                ; Right cross feedback
inchl   =       p11                                ; Left input
inchr   =       p12                                ; Right input
ifco    =       p13                                ; Filter cut off

afltl   init    0                                  ; Initialize adel to zero
afltr   init    0                                  ; Initialize adel to zero

kamp    linseg  0, .002, iamp, idur-.006, iamp, .002, 0, .002, 0  ; Declick envelope

asigl   zar     inchl                              ; Read the left channel
asigr   zar     inchr                              ; Read the right channel

adell   delay   asigl + afltl*ifdbkl + afltr*ixfbl, itiml  ; Delay the signal
adelr   delay   asigr + afltr*ifdbkr + afltl*ixfbr, itimr  ; Delay the signal

afltl   butterlp adell, ifco
afltr   butterlp adelr, ifco

        outs    afltl*kamp, afltr*kamp             ; Output the delayed signal

        endin

;---------------------------------------------------------------------------
; Clear Zak
;---------------------------------------------------------------------------
         instr   99
         zacl    0, 50                             ; Clear the audio channels
         zkcl    0, 50                             ; Clear the control channels
         endin

