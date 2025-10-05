sr             =         44100
kr             =         22050
ksmps          =         2
nchnls         =         2
               zakinit   50, 50
gareverb       init      0

; ENVELOPE
               instr     5

idur           =         p3
iamp           =         p4
irate          =         p5
itab1          =         p6
ioutch         =         p7

kenv1          oscili    iamp, irate/idur, itab1
               zkw       kenv1, ioutch
               endin

; DRUM MACHINE
instr          30

idur           =         p3
iamp           =         p4
idurtab        =         p5
idrumtb        =         p6
iacctab        =         p7
iamptab        =         p8
ispeed         =         p9
isteps         =         p10
ikinch         =         p11
ioutch         =         p12

kstep          init      isteps-1
kspeed         oscili    1, 1/p3, ispeed

loop1:
;     READ TABLE VALUES.
      kdur     table     frac((kstep + 1)/isteps)*isteps, idurtab
      kdrnum   table     kstep, idrumtb
      kaccnt   table     kstep, iacctab
      kamp     table     kstep, iamptab
      kaccnt1  table     frac((kstep + 1)/isteps)*isteps, iacctab
      kdur1    =         kdur/kspeed                             ; MAKE THE STEP SMALLER.
      kdclick  linseg    0, .002, 1, i(kdur1)-.004, 1, .002, 0
      kaccin   zkr       ikinch
      kaccnt   =         kaccnt*kaccin
      kaccnt1  =         kaccnt1*kaccin

; SWITCH BETWEEN THE DIFFERENT DRUMS
      if            (kdrnum != 0)  kgoto next1
  ;     NOISE BLIP
        kampenv0    linseg         0, .01/i(kaccnt1), iamp/2, .04/i(kaccnt1), 0, .01, 0
        asig0       rand           kampenv0
        aflt1       butterlp       asig0, 400*kaccnt
        aflt2       butterbp       asig0, 2000*kaccnt, 400*kaccnt
        aout        =              aflt1*4+aflt2*2
        kgoto       endswitch
next1:
      if            (kdrnum != 1)  kgoto next2
;       DUMB DRUM
        kampenv1    expseg         .0001, .01/i(kaccnt1), iamp, .08/i(kaccnt1), .01
        arnd1       rand           kampenv1
        afilt       reson          arnd1, 500*kaccnt, 50*kaccnt
        aout        balance        afilt, arnd1
        kgoto       endswitch
next2:
      if            (kdrnum != 2)  kgoto next3
;       DUMB BASS DRUM
        kampenv2    linseg         0, .02, iamp*2,  .5/i(kaccnt1), 0
        kfreqenv    expseg         50,  .05, 200*i(kaccnt1)+.001,     .8, 10
        arnd2       rand           kampenv2
        afilt1      butterbp       arnd2, kfreqenv, kfreqenv/32
        aosc1       oscil          kampenv2, kfreqenv, 1
;        afilt2     butterbp       arnd2, kfreqenv*1.5, kfreqenv/32*1.5
;        aosc2      oscil          kampenv2, kfreqenv*1.5, 1
        aout        balance        afilt+aosc1, arnd2*.5
        kgoto       endswitch
next3:
      if            (kdrnum != 3)  kgoto next4
;       KS SNARE
        kampenv3    linseg         0, .002, 1,    i(kdur1)-.022, 1, .02, 0
        kptchenv    linseg         100, .01, 300, .2, 200, .01, 200
        aplk3       pluck          iamp/2, kptchenv, 50, 2, 4, 1/(1+i(kaccnt)), 3
        aout        =              aplk3*kampenv3
        kgoto       endswitch

next4:
      if            (kdrnum != 4)  kgoto next5
;       FM Boink
        kamp40      linseg         0, .002, 1,    i(kdur1)-.004, 1, .002, 0
        kamp41      linseg         0, .005, iamp, i(kdur1)-.03, iamp*.1, .025, 0
        kamp42      linseg         0, .005, 1,  i(kdur1)-.01, 0, .005, 0
        kamp4       =              kamp40*kamp41
        klfo        oscil          1, 8, 1
        aout        foscil         kamp4, 110*kaccnt, 1, 1.5+klfo, kamp42*kaccnt, 1
        kgoto       endswitch

next5:
      if            (kdrnum != 5)  kgoto next6
        ; SORTA COOL KNOCK SWEEP DRUM
        kfreqenv51  expseg         800*i(kaccnt1)+.001,  .04, 40, .01, 40
        kfreqenv52  expseg         2000*i(kaccnt1)+.001, .04, 150, .01, 150
        kampenv5    linseg         0, .001, iamp, .1, iamp*.5, .05, 0, .01, 0
        asig        rand           kampenv5
        afilt1      reson          asig, kfreqenv51, kfreqenv51/32
        afilt2      reson          asig, kfreqenv52, kfreqenv52/16
        aout1       balance        afilt1, asig
        aout2       balance        afilt2, asig
        aout        =              (aout1+aout2)/2
        kgoto       endswitch

next6:
      if            (kdrnum != 6)  kgoto next7
        ; RING MOD DRUM 1
        kampenv6    linseg         0, .01/i(kaccnt1), iamp, .04/i(kaccnt1), 0, .001, 0
        kpchenv6    linseg         100, .01/i(kaccnt1), 400*i(kaccnt1), .04/i(kaccnt1), 100, .001, 100
        asig1       oscil          kampenv6, kpchenv6, 1
        asig2       oscil          kampenv6, kpchenv6*kaccnt, 1
        aout        balance asig1*asig2, asig1
        kgoto       endswitch

next7:
      if            (kdrnum != 7)  kgoto next8
        ; THUNDER BOMB
        aop4        init           0
        kae70       linseg         0, .002, iamp, i(kdur1)-.004, iamp, .002, 0
        kae71       linseg         0, .1*i(kaccnt1), 1, .2*i(kdur1)-.1*i(kaccnt1), .8, .8*i(kdur1), 0
        kae72       linseg         0, .1*i(kaccnt1), 1, .2*i(kdur1)-.1*i(kaccnt1), .8, .8*i(kdur1), 0
        kae73       linseg         0, .1*i(kaccnt1), 1, .2*i(kdur1)-.1*i(kaccnt1), .8, .8*i(kdur1), 0
        kae74       linseg         0, .1*i(kaccnt1), 1, .2*i(kdur1)-.1*i(kaccnt1), .8, .8*i(kdur1), 0
        krnfqc      randh          165*kaccnt1, 200

        aop4        oscil          10*kae74, 3*(1+.8*aop4)*krnfqc, 1
        aop3        oscil          20*kae73,   .5*(1+aop4)*krnfqc, 1
        aop2        oscil          16*kae72,          5.19*krnfqc, 1
        aop1        oscil          2* kae71,.5*(1+aop2+aop3)*krnfqc, 1
        aout        tone           aop1*kae70, 200*kaccnt1

next8:
      if            (kdrnum != 8)  kgoto endswitch
        ; SORTA COOL KNOCK SWEEP DRUM 2
        kfreqenv81  expseg         220*i(kaccnt1)+.001,  .25/i(kaccnt1), 40, .01, 40
        kampenv8    expseg         .01, .001/i(kaccnt1), iamp, .002, iamp*.5, .06, iamp, .05, iamp*.5, .1, .3*iamp, .1, .05*iamp, .01, .05*iamp
        kdclick8    linseg         0, .002, 1, i(kdur1)-.04, 1, .002, 0
        asig        rand           kampenv8
        aflt        reson          asig, kfreqenv81, 1
        abal        balance        aflt, asig
        aout        =              abal*kdclick8
        kgoto       endswitch

endswitch:
;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
                    timout         0, i(kdur1), cont1
        kstep       =              frac((kstep + 1)/isteps)*isteps
        reinit      loop1

  cont1:

                    zaw            aout*kdclick*kamp, ioutch      ;, aout*kdclick*kamp

endin

;---------------------------------------------------------------------------
; COMPUTER CONTROLLED METAL ACID BASS
;---------------------------------------------------------------------------
                    instr          40

idur                =              p3
iamp                =              p4
idurtab             =              p5
ipchtb              =              p6
iacctab             =              p7
iamptab             =              p8
ispeed              =              p9
isteps              =              p10
ifcoch              =              p11
irezch              =              p12
ioutch              =              p13
idistab             =              p14
ipwmrate            =              1
iband               =              0
apwmdc1             init           0
apwmdc2             init           0
apwmdc3             init           0

kstep               init           isteps-1
kspeed              oscili         1, 1/p3, ispeed

loop1:
;     READ TABLE VALUES.
      kdur          table          frac((kstep + 1)/isteps)*isteps, idurtab
      kpch1         table          kstep, ipchtb
      kaccnt        table          kstep, iacctab
      kamp1         table          kstep, iamptab
      kamp2         table          frac((kstep + 1)/isteps)*isteps, iamptab
      kaccnt1       table          frac((kstep + 1)/isteps)*isteps, iacctab
      kdur1         =              kdur/kspeed                             ; MAKE THE STEP SMALLER.
      kdclick       linseg         0, .002, iamp, i(kdur1)-.004, iamp, .002, 0

; PLAY THE CURRENT NOTE
kamp           linseg    0, .004, i(kamp2), i(kdur1)-.024, i(kamp2)*.5, .02, 0
kfqc           =         cpspch(kpch1)

kfcoenv        zkr       ifcoch
krezenv        zkr       irezch

kfcoo          linseg    .3, .04, 1, .1, .6, i(kdur1)-.14, .3
kacct2         linseg    1/i(kaccnt1), .04, i(kaccnt1), .1, 1/i(kaccnt1), i(kdur1)-.14, 1/i(kaccnt1)
kfco           =         kfcoo*kfcoenv*kacct2
krez           =         krezenv*kacct2
ifqcadj        =         .149659863*sr
klfo1          oscili    .1, ipwmrate, 1
klfo2          oscili    .1, ipwmrate*1.1, 1, .21
klfo3          oscili    .1, ipwmrate*.9, 1, .43

apulse1        buzz      1,kfqc, sr/2/kfqc, 1 ; Avoid aliasing
apulse3        buzz      1,kfqc, sr/2/kfqc, 1
apulse2        vdelay    apulse3, 1000/kfqc/(klfo1+1)/2, 1000/22
avpw1          =         apulse1 - apulse2             ; TWO INVERTED PULSES AT VARIABLE DISTANCE
apwmdc1        integ     avpw1

apulse4        buzz      1,kfqc*.995, sr/2/kfqc, 1     ; AVOID ALIASING
apulse6        buzz      1,kfqc*.995, sr/2/kfqc, 1
apulse5        vdelay    apulse6, 1000/kfqc/(klfo2+1)/2*.995, 1000/22
avpw2          delay     apulse4 - apulse5, .05        ; TWO INVERTED PULSES AT VARIABLE DISTANCE
apwmdc2        integ     avpw2

apulse7        buzz      1,kfqc*.997, sr/2/kfqc, 1     ; AVOID ALIASING
apulse9        buzz      1,kfqc*.997, sr/2/kfqc, 1
apulse8        vdelay    apulse6, 1000/kfqc/(klfo2+1)/2*.997, 1000/22
avpw3          delay     apulse7 - apulse8, .02        ; TWO INVERTED PULSES AT VARIABLE DISTANCE
apwmdc3        integ     avpw3

axn            =         apwmdc1+apwmdc2+apwmdc3

; RESONANT LOWPASS FILTER (4 POLE)
kc             =         ifqcadj/kfco
krez2          =         krez/(1+exp(kfco/11000))
ka1            =         kc/krez2-(1+krez2*iband)
kasq           =         kc*kc
kb             =         1+ka1+kasq

ayn            nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
ayn2           nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

; RESONANT LOWPASS FILTER (4 POLE)
kcl            =         ifqcadj/kfco
krez2l         =         2.0/(1+exp(kfco/11000))
ka1l           =         kcl/krez2l-(1+krez2l*iband)
kasql          =         kcl*kcl
kbl            =         1+ka1l+kasql

aynl           nlfilt    axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
ayn2l          nlfilt    aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1

arez           =         (ayn2-ayn2l)*.5
aclip          tablei    arez, idistab, 1, .5
aout           =         aclip*.5+ayn2l

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
               timout    0, i(kdur1), cont1
        kstep  =         frac((kstep + 1)/isteps)*isteps
        reinit loop1

  cont1:


               zaw       aout*kdclick*kamp, ioutch

endin

;---------------------------------------------------------------------------
; WARBLY SYNTH WITH FIFTHS FILTER
;---------------------------------------------------------------------------
               instr     41

idur           =         p3
iamp           =         p4
idurtab        =         p5
ipchtb         =         p6
iacctab        =         p7
iamptab        =         p8
ispeed         =         p9
isteps         =         p10
ifcoch         =         p11
irezch         =         p12
ioutch         =         p13
idistab        =         p14
ipwmrate       =         1
iband          =         0

kstep          init      isteps-1
kspeed         oscili    1, 1/p3, ispeed

loop1:
;     READ TABLE VALUES.
      kdur     table     frac((kstep + 1)/isteps)*isteps, idurtab
      kpch1    table     kstep, ipchtb
      kaccnt   table     kstep, iacctab
      kamp1    table     kstep, iamptab
      kamp2    table     frac((kstep + 1)/isteps)*isteps, iamptab
      kaccnt1  table     frac((kstep + 1)/isteps)*isteps, iacctab
      kdur1    =         kdur/kspeed                        ; MAKE THE STEP SMALLER.
      kdclick  linseg    0, .002, iamp, i(kdur1)-.004, iamp, .002, 0

; PLAY THE CURRENT NOTE
kamp           linseg    0, .004, i(kamp2), i(kdur1)-.024, i(kamp2)*.5, .02, 0
kfqc           =         cpspch(kpch1)

kfcoenv        zkr       ifcoch
krezenv        zkr       irezch

kfcoo          linseg    .3, .01, 1, .1, .6, i(kdur1)-.14, .3
kacct2         linseg    1/i(kaccnt1), .04, i(kaccnt1), .1, 1/i(kaccnt1), i(kdur1)-.14, 1/i(kaccnt1)
kfco           =         kfcoo*kfcoenv*kacct2
krez           =         krezenv*kacct2
ifqcadj        =         .149659863*sr
klfo1          oscili    .1, ipwmrate, 1
klfo2          oscili    .1, ipwmrate*1.1, 1, .21
krtramp        linseg    1, i(kdur1), 8
klfo3          oscili    .04, krtramp, 1, .21

apulse1        buzz      1,kfqc/(klfo3+1), sr/2/kfqc, 1     ; AVOID ALIASING
apulse3        buzz      1,kfqc/(klfo3+1), sr/2/kfqc, 1
apulse2        vdelay    apulse3, 1000/kfqc/(klfo1+1)/2, 1000/22
avpw1          =         apulse1 - apulse2             ; TWO INVERTED PULSES AT VARIABLE DISTANCE
apwmdc1        integ     avpw1

apulse4        buzz      1,kfqc*1.5/(klfo3+1), sr/2/kfqc, 1 ; AVOID ALIASING
apulse6        buzz      1,kfqc*1.5/(klfo3+1), sr/2/kfqc, 1
apulse5        vdelay    apulse6, 1000/kfqc/(klfo2+1)/2, 1000/22
avpw2          delay     apulse4 - apulse5, .05        ; TWO INVERTED PULSES AT VARIABLE DISTANCE
apwmdc2        integ     avpw2

axn            =         apwmdc1+apwmdc2

; RESONANT LOWPASS FILTER (4 POLE)
kc             =         ifqcadj/kfco
krez2          =         krez/(1+exp(kfco/11000))
ka1            =         kc/krez2-(1+krez2*iband)
kasq           =         kc*kc
kb             =         1+ka1+kasq

ayn            nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
ayn2           nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

; RESONANT LOWPASS FILTER (4 POLE) FIFTH
kc5            =         ifqcadj/kfco/1.5
krez25         =         krez/(1+exp(kfco/1.5/11000))
ka15           =         kc5/krez2-(1+krez25*iband)
kasq5          =         kc5*kc5
kb5            =         1+ka15+kasq5

ayn5           nlfilt    axn/kb5, (ka15+2*kasq5)/kb5, -kasq5/kb5,  0, 0, 1
ayn25          nlfilt    ayn5/kb5, (ka15+2*kasq5)/kb5, -kasq5/kb5, 0, 0, 1

; RESONANT LOWPASS FILTER (4 POLE)
kcl            =         ifqcadj/kfco
krez2l         =         2.0/(1+exp(kfco/11000))
ka1l           =         kcl/krez2l-(1+krez2l*iband)
kasql          =         kcl*kcl
kbl            =         1+ka1l+kasql

aynl           nlfilt    axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
ayn2l          nlfilt    aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1

aout           =         ayn2-ayn2l+ayn25

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
               timout    0, i(kdur1), cont1
        kstep  =         frac((kstep + 1)/isteps)*isteps
        reinit loop1

  cont1:


               zaw       aout*kdclick*kamp, ioutch

endin

;---------------------------------------------------------------------------
; SYNTH WITH FM FILTER RESONANCE
;---------------------------------------------------------------------------
               instr     42

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
ifcoch         =         p6
irezch         =         p7
ibndtab        =         p8
ioutch         =         p9
ifmfqc         =         p10
ifmamp         =         p11
iband          =         0

kamp           linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; PLAY THE CURRENT NOTE
kfcoenv        zkr       ifcoch
krezenv        zkr       irezch
kpbend         oscili    1, 1/idur, ibndtab
kfqc           =         ifqc*kpbend

klfo1          =         1 ; oscili 1, imodfqc, imodtab, .5
kfco           =         kfcoenv*(klfo1+1.5)+30
krez           =          krezenv
ifqcadj        =         .149659863*sr

apulse1        buzz      1,kfqc, sr/2/kfqc, 1               ; AVOID ALIASING
asaw1          integ     apulse1

apulse2        buzz      1,kfqc*.505, sr/2/kfqc*.505, 1     ; AVOID ALIASING
asaw2          integ     apulse2

axn            =         asaw1+asaw2-1

; RESONANT LOWPASS FILTER (4 POLE)
kc             =         ifqcadj/kfco
krez2          =         krez/(1+exp(kfco/11000))
ka1            =         kc/krez2-(1+krez2*iband)
kasq           =         kc*kc
kb             =         1+ka1+kasq

ayn            nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
ayn2           nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

; RESONANT LOWPASS FILTER (4 POLE)
kcl            =         ifqcadj/kfco
krez2l         =         2.0/(1+exp(kfco/11000))
ka1l           =         kcl/krez2l-(1+krez2l*iband)
kasql          =         kcl*kcl
kbl            =         1+ka1l+kasql

aynl           nlfilt    axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
ayn2l          nlfilt    aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1

ares1          =         ayn2-ayn2l
krms           rms       ares1, 100
;              Amp   Fqc       Car  Mod     MAmp       Wave
ares2          foscil    krms, kfco,     1,   ifmfqc, ifmamp,    1
aout           butterhp  ayn2l+ares2/4, 20

               zaw       aout*kamp, ioutch
     
               endin

;---------------------------------------------------------------------------
; SEQUENCED SYNTH WITH FM RESONANCE FILTER
;---------------------------------------------------------------------------
               instr     43

idur           =         p3
iamp           =         p4
idurtab        =         p5
ipchtb         =         p6
iacctab        =         p7
iamptab        =         p8
ispeed         =         p9
isteps         =         p10
ifcoch         =         p11
irezch         =         p12
ioutch         =         p13
iband          =         0

kstep          init      isteps-1
kspeed         oscili    1, 1/p3, ispeed

loop1:
;     READ TABLE VALUES.
      kdur     table     frac((kstep + 1)/isteps)*isteps, idurtab
      kpch1    table     kstep, ipchtb
      kaccnt   table     kstep, iacctab
      kamp1    table     kstep, iamptab
      kamp2    table     frac((kstep + 1)/isteps)*isteps, iamptab
      kaccnt1  table     frac((kstep + 1)/isteps)*isteps, iacctab
      kdur1    =         kdur/kspeed                             ; MAKE THE STEP SMALLER.
      kdclick  linseg    0, .002, iamp, i(kdur1)-.004, iamp, .002, 0

; PLAY THE CURRENT NOTE
kamp           linseg    0, .004, i(kamp2), i(kdur1)-.024, i(kamp2)*.5, .02, 0
kfcoenv        zkr       ifcoch
krezenv        zkr       irezch
kfqc           =         cpspch(kpch1)

kfcoo          linseg    .6, .01, 1.5, .1, 1, i(kdur1)-.14, .6
kacct2         linseg    1/i(kaccnt1), .04, i(kaccnt1), .1, 1/i(kaccnt1), i(kdur1)-.14, 1/i(kaccnt1)
kfco           =         kfcoo*kfcoenv*kacct2
krez           =         krezenv
ifqcadj        =         .149659863*sr

apulse1        buzz      1,kfqc, sr/2/kfqc, 1               ; AVOID ALIASING
asaw1          integ     apulse1

apulse2        buzz      1,kfqc*.505, sr/2/kfqc*.505, 1     ; AVOID ALIASING
asaw2          integ     apulse2

axn            =         asaw1+asaw2-1

; RESONANT LOWPASS FILTER (4 POLE)
kc             =         ifqcadj/kfco
krez2          =         krez/(1+exp(kfco/11000))
ka1            =         kc/krez2-(1+krez2*iband)
kasq           =         kc*kc
kb             =         1+ka1+kasq

ayn            nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
ayn2           nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

; RESONANT LOWPASS FILTER (4 POLE)
kcl            =         ifqcadj/kfco
krez2l         =         2.0/(1+exp(kfco/11000))
ka1l           =         kcl/krez2l-(1+krez2l*iband)
kasql          =         kcl*kcl
kbl            =         1+ka1l+kasql

aynl           nlfilt    axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
ayn2l          nlfilt    aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1

ares1          =         ayn2-ayn2l
krms           rms       ares1, 100
;              Amp   Fqc       Car  Mod      MAmp  Wave
ares2          foscil    krms, kfco,     1,   kaccnt1, 2,    1
aout           =         ayn2l+ares2/4

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
               timout    0, i(kdur1), cont1
        kstep  =         frac((kstep + 1)/isteps)*isteps
        reinit loop1

  cont1:


               zaw       aout*kdclick*kamp, ioutch

               endin

;---------------------------------------------------------------------------
; SYNTH WITH NOISE FILTER RESONANCE
;---------------------------------------------------------------------------
               instr     44

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
ifcoch         =         p6
irezch         =         p7
ibndtab        =         p8
ioutch         =         p9
iband          =         0

kamp           linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; PLAY THE CURRENT NOTE
kfcoenv        zkr       ifcoch
krezenv        zkr       irezch
kpbend         oscili    1, 1/idur, ibndtab
kfqc           =         ifqc*kpbend

klfo1          =         1 ; oscili 1, imodfqc, imodtab, .5
kfco           =         kfcoenv*(klfo1+1.5)+30
krez           =         krezenv
ifqcadj        =         .149659863*sr

apulse1        buzz      1,kfqc, sr/2/kfqc, 1                    ; AVOID ALIASING
asaw1          integ     apulse1

apulse2        buzz      1,kfqc*.505, sr/2/kfqc*.505, 1          ; AVOID ALIASING
asaw2          integ     apulse2

axn            =         asaw1+asaw2-1

; RESONANT LOWPASS FILTER (4 POLE)
kc             =         ifqcadj/kfco
krez2          =         krez/(1+exp(kfco/11000))
ka1            =         kc/krez2-(1+krez2*iband)
kasq           =         kc*kc
kb             =         1+ka1+kasq

ayn            nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
ayn2           nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

; RESONANT LOWPASS FILTER (4 POLE)
kcl            =         ifqcadj/kfco
krez2l         =         2.0/(1+exp(kfco/11000))
ka1l           =         kcl/krez2l-(1+krez2l*iband)
kasql          =         kcl*kcl
kbl            =         1+ka1l+kasql

aynl           nlfilt    axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
ayn2l          nlfilt    aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1

ares1          =         ayn2-ayn2l
krms           rms       ares1, 100

arand1         rand      krms
ares2          butterbp  arand1, kfco, kfco/8
ares3          butterbp  arand1, kfco*1.5, kfco/32*1.5
aout           =         ayn2l+(ares2+ares3)

               zawm      aout*kamp, ioutch

               endin


;---------------------------------------------------------------------------
; SPHERICAL LISSAJOUS OSCILLATORS
;---------------------------------------------------------------------------
               instr     45

ifqc           init      cpspch(p5)
iu             init      p6
iv             init      p7
irt2           init      sqrt(2)
iradius        init      1
ioutx          init      p8
iouty          init      p9
ioutz          init      p10

kampenv        linseg    0, .01, p4, p3-.03, p4*.5, .02, 0

; COSINES
acosu          oscil     1, iu*ifqc,      1, .25
acosv          oscil     1, iv*ifqc,      1, .25

; SINES
asinu          oscil     1, iu*ifqc,      1
asinv          oscil     1, iv*ifqc,      1

; COMPUTE X AND Y
ax             =         iradius*asinu*acosv
ay             =         iradius*asinu*asinv
az             =         iradius*acosu

               zaw       kampenv*ax, ioutx
               zaw       kampenv*ay, iouty
               zaw       kampenv*az, ioutz

endin

;----------------------------------------------------------------------------------
; GRANULAR SYNTHESIS V. 2
;----------------------------------------------------------------------------------
               instr     46

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
igrtab         =         p6
iwintab        =         p7
ifrngtab       =         p8
idens          =         p9
iattk          =         p10
idecay         =         p11
ibndtab        =         p12
igdur          =         .2

kamp           linseg    0, iattk, 1, idur-iattk-idecay, 1, idecay, 0
kbend          oscil     1, 1/idur, ibndtab
kfrng          oscil     1, 1/idur, ifrngtab

;              Amp  Fqc         Dense  AmpOff PitchOff    GrDur  GrTable   WinTable  MaxGrDur
aoutl          grain     p4,  ifqc*kbend, idens, 100,   ifqc*kfrng, igdur, igrtab,   iwintab,  5
aoutr          grain     p4,  ifqc*kbend, idens, 100,   ifqc*kfrng, igdur, igrtab,   iwintab,  5

               outs      aoutl*kamp, aoutr*kamp

               endin

;---------------------------------------------------------------------------
; WARBLY SYNTH WITH FIFTHS FILTER 2
;---------------------------------------------------------------------------
               instr     47

idur           =         p3
iamp           =         p4
idurtab        =         p5
ipchtb         =         p6
iacctab        =         p7
iamptab        =         p8
ispeed         =         p9
isteps         =         p10
ifcoch         =         p11
irezch         =         p12
ioutch         =         p13
idistab        =         p14
ivibr          =         p15
ipwmrate       =         1
iband          =         0

kstep          init      isteps-1
kspeed         oscili    1, 1/p3, ispeed

loop1:
;     READ TABLE VALUES.
      kdur     table     frac((kstep + 1)/isteps)*isteps, idurtab
      kpch1    table     kstep, ipchtb
      kaccnt   table     kstep, iacctab
      kamp1    table     kstep, iamptab
      kamp2    table     frac((kstep + 1)/isteps)*isteps, iamptab
      kaccnt1  table     frac((kstep + 1)/isteps)*isteps, iacctab
      kdur1    =         kdur/kspeed                                  ; MAKE THE STEP SMALLER.
      kdclick  linseg    0, .002, iamp, i(kdur1)-.004, iamp, .002, 0

; PLAY THE CURRENT NOTE
kamp           linseg    0, .004, i(kamp2), i(kdur1)-.024, i(kamp2)*.5, .02, 0
kfqc           =         cpspch(kpch1)

kfcoenv        zkr       ifcoch
krezenv        zkr       irezch

kfcoo          linseg    .3, .01, 1, .1, .6, i(kdur1)-.14, .3
kacct2         linseg    1/i(kaccnt1), .04, i(kaccnt1), .1, 1/i(kaccnt1), i(kdur1)-.14, 1/i(kaccnt1)
kfco           =         kfcoo*kfcoenv*kacct2
krez           =         krezenv*kacct2
ifqcadj        =         .149659863*sr
klfo1          oscili    .1, ipwmrate, 1
klfo2          oscili    .1, ipwmrate*1.1, 1, .21
krtramp        linseg    1, i(kdur1), 8
klfo3          oscili    .04*ivibr, krtramp, 1, .21

apulse1        buzz      1,kfqc/(klfo3+1), sr/2/kfqc, 1     ; AVOID ALIASING
apulse3        buzz      1,kfqc/(klfo3+1), sr/2/kfqc, 1
apulse2        vdelay    apulse3, 1000/kfqc/(klfo1+1)/2, 1000/22
avpw1          =         apulse1 - apulse2             ; TWO INVERTED PULSES AT VARIABLE DISTANCE
apwmdc1        integ     avpw1

apulse4        buzz      1,kfqc*1.5/(klfo3+1), sr/2/kfqc, 1 ; AVOID ALIASING
apulse6        buzz      1,kfqc*1.5/(klfo3+1), sr/2/kfqc, 1
apulse5        vdelay    apulse6, 1000/kfqc/(klfo2+1)/2, 1000/22
avpw2          delay     apulse4 - apulse5, .05        ; TWO INVERTED PULSES AT VARIABLE DISTANCE
apwmdc2        integ     avpw2

axn            =         apwmdc1+apwmdc2

; RESONANT LOWPASS FILTER (4 POLE)
kc             =         ifqcadj/kfco
krez2          =         krez/(1+exp(kfco/11000))
ka1            =         kc/krez2-(1+krez2*iband)
kasq           =         kc*kc
kb             =         1+ka1+kasq

ayn            nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
ayn2           nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

; RESONANT LOWPASS FILTER (4 POLE) FIFTH
kc5            =         ifqcadj/kfco/1.5
krez25         =         krez/(1+exp(kfco/1.5/11000))
ka15           =         kc5/krez2-(1+krez25*iband)
kasq5          =         kc5*kc5
kb5            =         1+ka15+kasq5

ayn5           nlfilt    axn/kb5, (ka15+2*kasq5)/kb5, -kasq5/kb5,  0, 0, 1
ayn25          nlfilt    ayn5/kb5, (ka15+2*kasq5)/kb5, -kasq5/kb5, 0, 0, 1

; RESONANT LOWPASS FILTER (4 POLE)
kcl            =         ifqcadj/kfco
krez2l         =         2.0/(1+exp(kfco/11000))
ka1l           =         kcl/krez2l-(1+krez2l*iband)
kasql          =         kcl*kcl
kbl            =         1+ka1l+kasql

aynl           nlfilt    axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
ayn2l          nlfilt    aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1

aout           =         ayn2-ayn2l+ayn25

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
               timout    0, i(kdur1), cont1
        kstep  =         frac((kstep + 1)/isteps)*isteps
        reinit loop1

  cont1:


               zaw       aout*kdclick*kamp, ioutch

endin

;---------------------------------------------------------------------------
; PLANAR ROTATION IN THREE DIMENSIONS
;---------------------------------------------------------------------------
               instr     50

ifqc           =         p4
iphase         =         p5
iplane         =         p6
inx            =         p7
iny            =         p8
inz            =         p9
ioutx          =         p10
iouty          =         p11
ioutz          =         p12

kcost          oscil     1, ifqc,   1, .25+iphase
ksint          oscil     1, ifqc,   1, iphase
kamp           linseg    0, .002, 1, p3-.004, 1, .002, 0

ax             zar       inx
ay             zar       iny
az             zar       inz

; ROTATION IN X-Y PLANE
  if      (iplane!=1)    goto next1
    axr        =         ax*kcost + ay*ksint
    ayr        =         -ax*ksint + ay*kcost
    azr        =         az
    goto       next3

; ROTATION IN X-Z PLANE
next1:
  if      (iplane!=2)    goto next2
    axr        =         ax*kcost + az*ksint
    ayr        =         ay
    azr        =         -ax*ksint + az*kcost
    goto       next 3

; ROTATION IN Y-Z PLANE
next2:
    axr        =         ax
    ayr        =         ay*kcost + az*ksint
    azr        =         -ay*ksint + az*kcost

next3:
               zaw       axr*kamp, ioutx
               zaw       ayr*kamp, iouty
               zaw       azr*kamp, ioutz

endin

;---------------------------------------------------------------------------
; DELAY
;---------------------------------------------------------------------------
               instr     100

idtime         =         p4
ifdback        =         p5
iinch          =         p6
ioutch         =         p7
aout           init 0

ain            zar       iinch
aout           delay     (aout+ain)*ifdback, idtime
               zaw       aout+ain, ioutch
               endin


;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
               instr     190

idur           init      p3
iamp           init      p4
inch           init      p5
ipan           init      p6
ifader         init      p7

asig1          zar       inch                                    ; READ INPUT CHANNEL 1

kfader         oscil     1, 1/idur, ifader
kpanner        oscil     1, 1/idur, ipan

kgl1           =         kfader*sqrt(kpanner)                    ; LEFT GAIN
kgr1           =         kfader*sqrt(1-kpanner)                  ; RIGHT GAIN

kdclick        linseg    0, .002, iamp, p3-.004, iamp, .002, 0   ; DECLICK

asigl          =         asig1*kgl1                              ; SCALE AND SUM
asigr          =         asig1*kgr1

               outs      kdclick*asigl, kdclick*asigr            ; OUTPUT STEREO PAIR

               endin

;----------------------------------------------------------------------------------
; MEDIUM ROOM REVERB WITH CONTROLS
;----------------------------------------------------------------------------------
               instr     192

idur           =         p3
iamp           =         p4
iinch1         =         p5
iinch2         =         p6
iinch3         =         p7
iinch4         =         p8
iinch5         =         p9
iinch6         =         p10
idecay         =         2.0
idense         =         .82
idense2        =         .9
ipreflt        =         5000
ihpfqc         =         4100
ilpfqc         =         200

adel71         init      0
adel11         init      0
adel12         init      0
adel13         init      0
adel31         init      0
adel61         init      0
adel62         init      0

kdclick        linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
ain1           zar       iinch1
ain2           zar       iinch2
ain3           zar       iinch3
ain4           zar       iinch4
ain5           zar       iinch5
ain6           zar       iinch6

asig0          =         ain1+ain2+ain3+ain4+ain5+ain6

aflt01         butterlp  asig0, ipreflt                          ; PRE-FILTER
aflt02         butterhp  .4*adel71*idense2, ihpfqc               ; FEED-BACK FILTER
aflt03         butterlp  .4*aflt02, ilpfqc                       ; FEED-BACK FILTER
asum01         =         aflt01+.5*aflt03                        ; INITIAL MIX

; DOUBLE NESTED ALL-PASS
asum11         =         adel12-.35*adel11*idense                ; FIRST  INNER FEEDFORWARD
asum12         =         adel13-.45*asum11*idense                ; SECOND INNER FEEDFORWARD
aout11         =         asum12-.25*asum01*idense                ; OUTER FEEDFORWARD
adel11         delay     asum01+.25*aout11*idense, .0047*idecay  ; OUTER FEEDBACK
adel12         delay     adel11+.35*asum11*idense, .0083*idecay  ; FIRST  INNER FEEDBACK
adel13         delay     asum11+.45*asum12*idense, .0220*idecay  ; SECOND INNER FEEDBACK

adel21         delay     aout11, .005*idecay                     ; DELAY 1

; ALL-PASS 1
asub31         =         adel31-.45*adel21*idense                ; FEEDFORWARD
adel31         delay     adel21+.45*asub31*idense, .030*idecay   ; FEEDBACK

adel41         delay     asub31, .067*idecay                     ; DELAY 2
adel51         delay     .4*adel41, .015*idecay                  ; DELAY 3
aout51         =         aflt01+adel41

; SINGLE NESTED ALL-PASS
asum61         =         adel62-.35*adel61*idense                ; INNER FEEDFORWARD
aout61         =         asum61-.25*aout51*idense                ; OUTER FEEDFORWARD
adel61         delay     aout51+.25*aout61*idense, .0292*idecay  ; OUTER FEEDBACK
adel62         delay     adel61+.35*asum61*idense, .0098*idecay  ; INNER FEEDBACK

aout           =         .5*aout11+.5*adel41+.5*aout61           ; COMBINE OUTPUTS
     
adel71         delay     aout61, .108*idecay                     ; DELAY 4

               outs      aout*kdclick, -aout*kdclick

               endin

;---------------------------------------------------------------------------
; ZAK CLEAR
;---------------------------------------------------------------------------
               instr     195

               zacl      0, 50
               zkcl      0, 50

               endin


