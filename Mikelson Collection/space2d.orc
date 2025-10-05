;----------------------------------------------------------------------------------
; SPATIAL AUDIO
; CODED BY HANS MIKELSON OCTOBER 1998
; THIS SPATIAL AUDIO SYSTEM INCLUDED THE FOLLOWING FEATURES:
;
;  1. MOVING SOUND SOURCE WITH TABLE SUPPLIED MOVING X AND Y COORDINATES
;  2. VOLUME DECREASES AS 1/R^2
;  3. FILTERING OF SOUND DUE TO AIR ABSORPTION
;  4. DOPPLER EFFECT DUE TO MOVING SOUND
;  5. SIMPLIFIED HRTF FOR HEAD SHADOW FILTERING
;  6. INTER EAR TIME DELAY
;  7. SPEAKER CROSS-TALK CANCELLATION BASED ON BOTH INTER EAR TIME DELAY & HEAD SHADOWING
;----------------------------------------------------------------------------------

sr             =         44100
kr             =         22050
ksmps          =         2
nchnls         =         2
               zakinit   50,50

; ENVELOPE
               instr     2

idur           =         p3
iamp           =         p4
irate          =         p5
itab1          =         p6
ioutch         =         p7

kenv1          oscili    iamp, irate/idur, itab1
               zkw       kenv1, ioutch
               endin

;----------------------------------------------------------------------------------
; BLIP
;----------------------------------------------------------------------------------
               instr     3

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
ioutch         =         p6

aamp           linseg    0, idur/2, 100, idur/2, 0
kfbw           linseg    10, idur, 1000
kfqc           linseg    ifqc/2, idur, ifqc*2
asig           rand      iamp
aout           butterbp  asig, kfqc, ifqc/kfbw

               zawm      aout*aamp, ioutch
          
               endin

; DRUM MACHINE
instr          4

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
      kdur1    =         kdur/kspeed                        ; MAKE THE STEP SMALLER.
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
        kampenv1    expseg         .001, .02/i(kaccnt1), iamp, .02*i(kaccnt1), .01
        arnd1       rand           kampenv1
        arvb1       reverb2        arnd1, i(kdur1)*kaccnt1, 1/(1+kaccnt1)
        aout        butterhp       arvb1, 1000/(kaccnt+.1)
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
        aout        balance        afilt1+aosc1, arnd2*.5
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
;       FM BOINK
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
        aout        balance        asig1*asig2, asig1
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
      if            (kdrnum != 8)  kgoto next9
        ; KICK DRUM
        kfreqenv81  expseg         220*i(kaccnt1)+.001,  .25/i(kaccnt1), 40, .01, 40
        kampenv8    expseg         .01, .001/i(kaccnt1), iamp, .2, iamp*.5, .1, .3*iamp, .1, .05*iamp, .01, .05*iamp
        kdclick8    linseg         0, .002, 1, i(kdur1)-.04, 1, .002, 0
        asig        rand           kampenv8
        aflt        reson          asig, kfreqenv81, 1
        abal        balance        aflt, asig
        krms        rms            abal, 1000
        kcmp1       =              (krms>10000) ? .1 : 1
        kcmp        port           kcmp1, .01
        acmp        =              abal*kcmp   
        aout        =              acmp*kdclick8
        kgoto       endswitch

; NOISE DRUM
next9:
      if            (kdrnum != 9)  kgoto endswitch

       ifqc9        =              500
       iq9          =              i(kaccnt1)
       ivol9        =              .1
       iton9        =              10
       kfqcl9       expseg         .1*ifqc9, i(kdur1), 2*ifqc9        ; LOW SHELF FREQUENCY
       kq9          expseg         .1*ifqc9, i(kdur1), 2*ifqc9        ; EQ SWEEP QUALITY
       kfqch9       expseg         10*ifqc9, i(kdur1), .5*ifqc9       ; HIGH SHELF FREQUENCY

       anz9         rand           .5                                 ; WHITE NOISE

       a19          pareq          anz9, kfqcl9, ivol9,     iq9, 1    ; LOW SHELF SWEEP
       a29          pareq          anz9, ifqc9,    1/ivol9, kq9, 0    ; EQ SWEEP
       a39          pareq          anz9, kfqch9, ivol9,     iq9, 2    ; HIGH SHELF SWEEP

       adclk9       expseg         iamp/10+.001, .002, iamp+.001, i(kdur1)-.002, iamp/100+.001           ; AMPLITUDE ENVELOPE

       aout         =              ((a29-a39)+(a29-a19)*iton9)*adclk9      ; MIX IT UP TO SOUND NICE

endswitch:
;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
                    timout         0, i(kdur1), cont1
        ; kstep     =              frac((kstep + 1)/isteps)*isteps
        kstep       =              int(frac((kstep + 1)/isteps)*isteps+.5)+.1
        reinit      loop1

  cont1:

     zaw            aout*kdclick*kamp, ioutch          ;, AOUT*KDCLICK*KAMP

endin

;---------------------------------------------------------------------------
; SEQUENCED SYNTH WITH FM RESONANCE FILTER
;---------------------------------------------------------------------------
               instr     8

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

;               Amp, Fqc,       Wave, PWM, Sine, MaxDelay
asaw1          vco       1,    kfqc,      1,    .5,  1,    1/i(kfqc)
asaw2          vco       1,    kfqc*.505, 1,    .5,  1,    1/i(kfqc)
asaw3          vco       1,    kfqc*1.01, 1,    .5,  1,    1/i(kfqc)
     
axn            =         asaw1+asaw2

; RESONANT LOWPASS FILTER (4 POLE)
ayn            rezzy     axn, kfco, krez
ayn2           rezzy     ayn, kfco, krez

; RESONANT LOWPASS FILTER (4 POLE)
aynl           rezzy     axn, kfco, 1
ayn2l          rezzy     aynl, kfco, 1

ares1          =         ayn2-ayn2l
krms           rms       ares1, 100
;              Amp   Fqc       Car  Mod               MAmp    Wave
ares2          foscil    krms, kfco,     1,   kaccnt1+ares1/4,  3.5,    1
aout           =         ayn2l+ares2/2

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
               timout    0, i(kdur1), cont1
        kstep  =         int(frac((kstep + 1)/isteps)*isteps+.5)+.1
;              printk    .1, kstep
        reinit loop1

  cont1:

               zaw       aout*kdclick*kamp, ioutch
;              outs      aout*kdclick*kamp, aout*kdclick*kamp

     endin

;---------------------------------------------------------------------------
; SEQUENCED SYNTH WITH VCO RESONANCE FILTER
;---------------------------------------------------------------------------
               instr     9

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
kamp           linseg    0, .04, i(kamp2), i(kdur1)-.08, i(kamp2)*.8, .04, 0
kfcoenv        zkr       ifcoch
krezenv        zkr       irezch
kfqc           =         cpspch(kpch1)

kfcoo          linseg    .8, .1, 1.2, .1, 1, i(kdur1)-.2, .8
kacct2         linseg    1/i(kaccnt1), .04, i(kaccnt1), .1, 1/i(kaccnt1), i(kdur1)-.14, 1/i(kaccnt1)
kfco           =         kfcoo*kfcoenv*kacct2
krez           =         krezenv

;               Amp, Fqc,       Wave, PWM, Sine, MaxDelay
asaw1          vco       1,    kfqc,      1,    .5,  1,    1/i(kfqc)
asaw2          vco       1,    kfqc*.505, 1,    .5,  1,    1/i(kfqc)
     
axn            =         asaw1+asaw2

; RESONANT LOWPASS FILTER (4 POLE)
ayn            rezzy     axn, kfco, krez
ayn2           rezzy     ayn, kfco, krez
     
; RESONANT LOWPASS FILTER (4 POLE)
aynl           rezzy     axn, kfco, 1
ayn2l          rezzy     aynl, kfco, 1

ares1          =         ayn2-ayn2l
krms           rms       ares1, 100

;              Amp,  Fqc,   Wave, PWM, Sine, MaxDelay
ares3          vco       krms, kfco,  1,    .5,  1,    .1
ares2          rezzy     ares3, 4000, 10
aout           =         ayn2l+ares2/2

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
               timout    0, i(kdur1), cont1
        kstep  =         int(frac((kstep + 1)/isteps)*isteps+.5)+.1
;              printk    .1, kstep
        reinit loop1

  cont1:

               zaw       aout*kdclick*kamp, ioutch
;              outs      aout*kdclick*kamp, aout*kdclick*kamp

               endin

;---------------------------------------------------------------------------
; SEQUENCED SYNTH WITH VCO RESONANCE FILTER
;---------------------------------------------------------------------------
               instr     10

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

;               Amp, Fqc,       Wave, PWM, Sine, MaxDelay
asaw1          vco       1,    kfqc,      2,    .5,  1,    1/i(kfqc)
asaw2          vco       1,    kfqc*1.01, 2,    .5,  1,    1/i(kfqc)

axn            =         asaw1+asaw2

; RESONANT LOWPASS FILTER (4 POLE)
ayn            rezzy     axn, kfco, krez
ayn2           rezzy     ayn, kfco, krez

; Resonant Lowpass Filter (4 Pole)
aynl           rezzy     axn, kfco, 1
ayn2l          rezzy     aynl, kfco, 1

ares1          =         ayn2-ayn2l
krms           rms       ares1, 100

;              Amp,  Fqc,   Wave, PWM, Sine, MaxDelay
ares3          vco       krms, kfco,  2,    .5,  1,    .1
ares2          rezzy     ares3, 5000, 20
aout           =         ayn2l+ares2

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
      timout   0, i(kdur1), cont1
        kstep  =         int(frac((kstep + 1)/isteps)*isteps+.5)+.1
;              printk    .1, kstep
        reinit loop1

  cont1:

               zaw       aout*kdclick*kamp, ioutch
;              outs      aout*kdclick*kamp, aout*kdclick*kamp

               endin

;---------------------------------------------------------------------------
; BASS SYNTH PWM
;---------------------------------------------------------------------------
               instr     11

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
kpwm           oscili    .2, 1, 71

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
kamp           linseg    0, .004, i(kamp2), .02, i(kamp2), i(kdur1)-.044, i(kamp2)*.5, .02, 0
kfcoenv        zkr       ifcoch
krezenv        zkr       irezch
kfqc           =         cpspch(kpch1)

kfcoo          linseg    .6, .01, 1.5, .1, 1, i(kdur1)-.14, .6
kacct2         linseg    1/i(kaccnt1), .04, i(kaccnt1), .1, 1/i(kaccnt1), i(kdur1)-.14, 1/i(kaccnt1)
kfco           =         kfcoo*kfcoenv*kacct2
krez           =         krezenv

;               Amp, Fqc,       Wave, PWM, Sine, MaxDelay
asaw1          vco       1,    kfqc,      2,    .7+kpwm,  1,    1/i(kfqc)

axn            =         asaw1

; RESONANT LOWPASS FILTER (4 POLE)
ayn            rezzy     axn, kfco, krez
aout           rezzy     ayn, kfco, krez

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
               timout    0, i(kdur1), cont1
        kstep  =         int(frac((kstep + 1)/isteps)*isteps+.5)+.1
;              printk    .1, kstep
        reinit loop1

  cont1:

               zaw       aout*kdclick*kamp, ioutch
;              outs      aout*kdclick*kamp, aout*kdclick*kamp

               endin

;---------------------------------------------------------------------------
; SEQUENCED SYNTH WITH PLUCK
;---------------------------------------------------------------------------
               instr     12

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
kspeed    oscili         1, 1/p3, ispeed

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

;               Amp, Fqc,       Fqc  Wave Method
aplk1          pluck     1,    kfqc*.998,  100, 0,   1
aplk2          pluck     1,    kfqc*1.002, 100, 0,   1
adel2          delay     aplk2, .01
aout           rezzy     (aplk1+adel2)/2, kfco, krez

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
               timout    0, i(kdur1), cont1
        kstep  =         int(frac((kstep + 1)/isteps)*isteps+.5)+.1
;              printk    .1, kstep
        reinit loop1

  cont1:

               zaw       aout*kdclick*kamp, ioutch
;              outs      aout*kdclick*kamp, aout*kdclick*kamp

               endin

;----------------------------------------------------------------------------------
; DIGITAL DELAY
;----------------------------------------------------------------------------------
               instr     15

idur           =         p3
iamp           =         p4
itime          =         p5
ifdbk          =         p6
iinch          =         p7
ioutch         =         p8

aout           init      0
aamp           linseg    0, .002, iamp, idur-.04, iamp, .002, 0
asig           zar       iinch
adel           delay     ifdbk*aout, itime
aout           =         adel+asig
               zaw       aout*aamp, ioutch

               endin

;----------------------------------------------------------------------------------
; SPATIAL AUDIO
; CODED BY HANS MIKELSON OCTOBER 1998
; THIS SPATIAL AUDIO SYSTEM INCLUDED THE FOLLOWING FEATURES:
;
; 1. MOVING SOUND SOURCE WITH TABLE SUPPLIED MOVING X AND Y COORDINATES
; 2. VOLUME DECREASES AS 1/R^2
; 3. FILTERING OF SOUND DUE TO AIR ABSORPTION
; 4. DOPPLER EFFECT DUE TO MOVING SOUND
; 5. SIMPLIFIED HRTF FOR HEAD SHADOW FILTERING
; 6. INTER EAR TIME DELAY
; 7. SPEAKER CROSS-TALK CANCELLATION BASED ON BOTH INTER EAR TIME DELAY & HEAD SHADOWING
;----------------------------------------------------------------------------------
               instr      20

idur           =          p3            ; DURATION
iamp           =          p4            ; AMPLITUDE
iexl           =          p5            ; FIXED LEFT EAR LOCATION X COORDINATE
iexr           =          iexl+.23      ; FIXED RIGHT EAR LOCATION X COORDINATE
iey            =          p6            ; FIXED EAR LOCATION Y COORDINATE (FACING +Y AXIS)
isxtab         =          p7            ; MOVING SOURCE TABLE FOR X COORDINATE IN M
isytab         =          p8            ; MOVING SOURCE TABLE FOR Y COORDINATE IN M
iinch          =          p9            ; AUDIO INPUT CHANNEL
ihrtabl        =          p10           ; HEAD SHADOWING FILTER FOR LEFT EAR
ihrtabr        =          p11           ; HEAD SHADOWING FILTER FOR RIGHT EAR
imax           =          500           ; MAXIMUM DELAY TIME IN MS
ipi            =          3.14159265    ; PI
ics            =          .333          ; APPROX. SPEED OF SOUND IN M/MS

kamp           linseg     0, .002, iamp, idur-.004, iamp, .002, 0     ; DECLICK ENEVELOPE

ksx            oscili     1, 1/idur, isxtab                           ; MOVING SOURCE X
ksy            oscili     1, 1/idur, isytab                           ; MOVING SOURCE Y

ksmexl         =          ksx-iexl                          ; DELTA X LEFT
ksmexr         =          ksx-iexr                          ; DELTA X RIGHT
ksmey          =          ksy-iey                           ; DELTA Y
kdistl         =          sqrt(ksmexl*ksmexl+ksmey*ksmey)   ; DISTANCE FROM LEFT EAR TO SOURCE
kdistr         =          sqrt(ksmexr*ksmexr+ksmey*ksmey)   ; DISTANCE FROM RIGHT EAR TO SOURCE
kdistlnz       =          (kdistl==0 ? 1 : kdistl)          ; AVOID DIVIDE BY ZERO PROBLEM
kdistrnz       =          (kdistr==0 ? 1 : kdistr)          ; AVOID DIVIDE BY ZERO PROBLEM

kangl          =          cosinv(ksmexl/kdistlnz)      ; GET THE MAGNITUDE OF THE ANGLE (0 TO PI)
kangr          =          cosinv(ksmexr/kdistrnz)      ; GET THE MAGNITUDE OF THE ANGLE (0 TO PI)
ksmeynz        =          (ksmey==0 ? 1 : ksmey)       ; MAKE SURE IT IS NOT ZERO
ksign          =          ksmeynz/abs(ksmeynz)/2/ipi   ; GET THE SIGN
kanglel        =          kangl*ksign                  ; GET THE TRUE ANGLE -PI TO PI
kangler        =          kangr*ksign                  ; GET THE TRUE ANGLE -PI TO PI
kdd4l          =          kdistl/4                     ; FACTOR FOR DISTANCE AND AIR ABSORPTION
kdd4r          =          kdistr/4                     ; FACTOR FOR DISTANCE AND AIR ABSORPTION

ain            zar        iinch                        ; INPUT AUDIO

adoppl         vdelay3    ain/(1+kdistl*kdistl), kdistl/ics, imax ; VOLUME DECREASES AS DISTANCE^2.
adoppr         vdelay3    ain/(1+kdistr*kdistr), kdistr/ics, imax ; VOLUME DECREASES AS DISTANCE^2.
               ; ARRIVAL TIME IS DELAYED BY SPEED OF SOUND, DOPPLER EFFECT 
afltail        pareq      adoppl, 20000/(1+kdd4l), 1/(1+kdd4l), .707, 2 ; AIR ABSORPTION OF DISTANT SOUND
afltair        pareq      adoppr, 20000/(1+kdd4r), 1/(1+kdd4r), .707, 2 ; AIR ABSORPTION OF DISTANT sound

khrtfl         tablei     kanglel, ihrtabl, 1, .5      ; GET THE "POOR MANS" HRTF FOR LEFT EAR
khrtfr         tablei     kangler, ihrtabr, 1, .5      ; GET THE "POOR MANS" HRTF FOR RIGHT EAR

ahrtfl         butterlp   afltail, khrtfl         ; APPLY THE FILTER FOR HEAD SHADOWING LEFT EAR
ahrtfr         butterlp   afltair, khrtfr         ; APPLY THE FILTER FOR HEAD SHADOWING RIGHT EAR

asctcl         butterlp   ahrtfl, 8000            ; SIMPLIFIED HEAD SHADOWING FOR SPEAKER CROSS-TALK
asctcr         butterlp   ahrtfr, 8000            ; SIMPLIFIED HEAD SHADOWING FOR SPEAKER CROSS-TALK

asctcdl        delay      asctcl, .0003           ; SPEAKER CROSS-TALK CANCELLATION DELAY LEFT
asctcdr        delay      asctcr, .0003           ; SPEAKER CROSS-TALK CANCELLATION DELAY RIGHT

               outs      (ahrtfl-asctcdr*.4)*kamp, (ahrtfr-asctcdl*.4)*kamp     ; CANCEL SPEAKER CROSS-TALK AND OUPUT
        
;              zacl      iinch, iinch             ; CLEAN UP THE ZAK CHANNEL

               endin

;----------------------------------------------------------------------------------
; SPATIAL AUDIO
; CODED BY HANS MIKELSON OCTOBER 1998
; THIS SPATIAL AUDIO SYSTEM INCLUDED THE FOLLOWING FEATURES:
;
; 1. MOVING SOUND SOURCE WITH TABLE SUPPLIED MOVING X AND Y COORDINATES
; 2. VOLUME DECREASES AS 1/R^2
; 3. FILTERING OF SOUND DUE TO AIR ABSORPTION
; 4. DOPPLER EFFECT DUE TO MOVING SOUND
; 5. SIMPLIFIED HRTF FOR HEAD SHADOW FILTERING
; 6. INTER EAR TIME DELAY
; 7. SPEAKER CROSS-TALK CANCELLATION BASED ON BOTH INTER EAR TIME DELAY & HEAD SHADOWING
;----------------------------------------------------------------------------------
               instr     21

idur           =         p3             ; DURATION
iamp           =         p4             ; AMPLITUDE
iexl           =         p5             ; FIXED LEFT EAR LOCATION X COORDINATE
iexr           =         iexl+.23       ; FIXED RIGHT EAR LOCATION X COORDINATE
iey            =         p6             ; FIXED EAR LOCATION Y COORDINATE (FACING +Y AXIS)
isxtab         =         p7             ; MOVING SOURCE TABLE FOR X COORDINATE IN M
isytab         =         p8             ; MOVING SOURCE TABLE FOR Y COORDINATE IN M
iinch          =         p9             ; AUDIO INPUT CHANNEL
ihrtabl        =         p10            ; HEAD SHADOWING FILTER FOR LEFT EAR
ihrtabr        =         p11            ; HEAD SHADOWING FILTER FOR RIGHT EAR
imax           =         500            ; MAXIMUM DELAY TIME IN MS
ipi            =         3.14159265     ; PI
ics            =         .333           ; APPROX. SPEED OF SOUND IN M/MS
iloop          =         p12

kamp           linseg    0, .002, iamp, idur-.004, iamp, .002, 0      ; DECLICK ENEVELOPE

ksx            oscili    1, iloop/idur, isxtab                        ; MOVING SOURCE X
ksy            oscili    1, iloop/idur, isytab                        ; MOVING SOURCE Y

ksmexl         =         ksx-iexl                           ; DELTA X LEFT
ksmexr         =         ksx-iexr                           ; DELTA X RIGHT
ksmey          =         ksy-iey                            ; DELTA Y
kdistl         =         sqrt(ksmexl*ksmexl+ksmey*ksmey)    ; DISTANCE FROM LEFT EAR TO SOURCE
kdistr         =         sqrt(ksmexr*ksmexr+ksmey*ksmey)    ; DISTANCE FROM RIGHT EAR TO SOURCE
kdistlnz       =         (kdistl==0 ? 1 : kdistl)           ; AVOID DIVIDE BY ZERO PROBLEM
kdistrnz       =         (kdistr==0 ? 1 : kdistr)           ; AVOID DIVIDE BY ZERO PROBLEM

kangl          =         cosinv(ksmexl/kdistlnz)       ; GET THE MAGNITUDE OF THE ANGLE (0 TO PI)
kangr          =         cosinv(ksmexr/kdistrnz)       ; GET THE MAGNITUDE OF THE ANGLE (0 TO PI)
ksmeynz        =         (ksmey==0 ? 1 : ksmey)        ; MAKE SURE IT IS NOT ZERO
ksign          =         ksmeynz/abs(ksmeynz)/2/ipi    ; GET THE SIGN
kanglel        =         kangl*ksign                   ; GET THE TRUE ANGLE -PI TO PI
kangler        =         kangr*ksign                   ; GET THE TRUE ANGLE -PI TO PI
kdd4l          =         kdistl/4                      ; FACTOR FOR DISTANCE AND AIR ABSORPTION
kdd4r          =         kdistr/4                      ; FACTOR FOR DISTANCE AND AIR ABSORPTION

ain            zar       iinch                         ; INPUT AUDIO

adoppl         vdelay3   ain/(1+kdistl*kdistl), kdistl/ics, imax ; VOLUME DECREASES AS DISTANCE^2.
adoppr         vdelay3   ain/(1+kdistr*kdistr), kdistr/ics, imax ; VOLUME DECREASES AS DISTANCE^2.
                         ; ARRIVAL TIME IS DELAYED BY SPEED OF SOUND, DOPPLER EFFECT 
afltail        pareq     adoppl, 20000/(1+kdd4l), 1/(1+kdd4l), .707, 2 ; AIR ABSORPTION OF DISTANT SOUND
afltair        pareq     adoppr, 20000/(1+kdd4r), 1/(1+kdd4r), .707, 2 ; AIR ABSORPTION OF DISTANT SOUND

khrtfl         tablei    kanglel, ihrtabl, 1, .5       ; GET THE "POOR MANS" HRTF FOR LEFT EAR
khrtfr         tablei    kangler, ihrtabr, 1, .5       ; GET THE "POOR MANS" HRTF FOR RIGHT EAR

ahrtfl         butterlp  afltail, khrtfl     ; APPLY THE FILTER FOR HEAD SHADOWING LEFT EAR
ahrtfr         butterlp  afltair, khrtfr     ; APPLY THE FILTER FOR HEAD SHADOWING RIGHT EAR

asctcl         butterlp  ahrtfl, 8000        ; SIMPLIFIED HEAD SHADOWING FOR SPEAKER CROSS-TALK
asctcr         butterlp  ahrtfr, 8000        ; SIMPLIFIED HEAD SHADOWING FOR SPEAKER CROSS-TALK

asctcdl        delay     asctcl, .0003       ; SPEAKER CROSS-TALK CANCELLATION DELAY LEFT
asctcdr        delay     asctcr, .0003       ; SPEAKER CROSS-TALK CANCELLATION DELAY RIGHT

               outs      (ahrtfl-asctcdr*.4)*kamp, (ahrtfr-asctcdl*.4)*kamp     ; CANCEL SPEAKER CROSS-TALK AND OUPUT
        
;              zacl      iinch, iinch        ; CLEAN UP THE ZAK CHANNEL

               endin

;----------------------------------------------------------------------------------
; 4 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
               instr     36

idur           =         p3
iamp           =         p4
iinch          =         p5
ifdbk          =         p6/4
ifco1          =         p7
ifco2          =         p7*p9/(p9+p10*(1-p8))
ifco3          =         p7*p9/(p9+p11*(1-p8))
ifco4          =         p7*p9/(p9+p12*(1-p8))
itim1          =         p9/1000
itim2          =         p10/1000
itim3          =         p11/1000
itim4          =         p12/1000
ioutch         =         p13
ifchp          =         p14

aflt1          init      0
aflt2          init      0
aflt3          init      0
aflt4          init      0

;asig          zar       iinch
asig1          zar       iinch
asig           reverb2   asig1, .5, 1

adel1          delay     asig+( aflt1+aflt2-aflt3-aflt4)*ifdbk, itim1      ; LOOP 1
adel2          delay     asig+(-aflt1+aflt2-aflt3+aflt4)*ifdbk, itim2      ; LOOP 2
adel3          delay     asig+( aflt1-aflt2+aflt3-aflt4)*ifdbk, itim3      ; LOOP 3
adel4          delay     asig+(-aflt1-aflt2+aflt3+aflt4)*ifdbk, itim4      ; LOOP 4

;                        Fc, Vol, Q
aflt1          pareq     adel1,  ifco1, .5, .4, 2
aflt2          pareq     adel2,  ifco2, .5, .4, 2
aflt3          pareq     adel3,  ifco3, .5, .4, 2
aflt4          pareq     adel4,  ifco4, .5, .4, 2

;arvb          reverb2   aflt1+aflt2+aflt3+aflt4, .5, .5
;aout          butterhp  arvb, 140 ; Combine outputs
aout           butterhp  aflt1+aflt2+aflt3+aflt4, 140                      ; COMBINE OUTPUTS

               zaw       aout, ioutch

               endin

;----------------------------------------------------------------------------------
; 3 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
               instr     37

idur           =         p3
iamp           =         p4
iinch          =         p5
ifdbk          =         p6/3
ifco1          =         p7
ifco2          =         p7*p9/(p9+p10*(1-p8))
ifco3          =         p7*p9/(p9+p11*(1-p8))
itim1          =         p9/1000
itim2          =         p10/1000
itim3          =         p11/1000
ioutch         =         p12

aflt1          init      0
aflt2          init      0
aflt3          init      0

asig1          zar       iinch
asig           reverb2   asig1, .5, 1
;asig          zar       iinch

adel1          delay     asig+( aflt1-aflt2-aflt3)*ifdbk, itim1       ; LOOP 1
adel2          delay     asig+(-aflt1+aflt2-aflt3)*ifdbk, itim2       ; LOOP 2
adel3          delay     asig+(-aflt1-aflt2+aflt3)*ifdbk, itim3       ; LOOP 3

aflt1          pareq     adel1, ifco1, .5, .4, 2
aflt2          pareq     adel2, ifco2, .5, .4, 2
aflt3          pareq     adel3, ifco3, .5, .4, 2

;arvb          reverb2   aflt1+aflt2+aflt3, .5, .5
aout           butterhp  aflt1+aflt2+aflt3, 140                       ; COMBINE OUTPUTS
               zaw       aout, ioutch

               endin

;----------------------------------------------------------------------------------
; 2 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
               instr     38

idur           =         p3
iamp           =         p4
iinch          =         p5
ifdbk          =         p6/2
ifco1          =         p7
ifco2          =         p7*p9/(p9+p10*(1-p8))
itim1          =         p9/1000
itim2          =         p10/1000
ioutch         =         p11

aflt1          init      0
aflt2          init      0

asig1          zar       iinch
asig           reverb2   asig1, .5, 1
;asig          zar       iinch

adel1          delay     asig+(aflt1-aflt2)*ifdbk, itim1
adel2          delay     asig+(aflt2-aflt1)*ifdbk, itim2

aflt1          pareq     adel1, ifco1, .5, .4, 2
aflt2          pareq     adel2, ifco2, .5, .4, 2

;aout          butterhp  arvb, 140 ; Combine outputs
aout           butterhp  aflt1+aflt2, 140
               zaw       aout, ioutch

               endin

;----------------------------------------------------------------------------------
; OUTPUT FOR MONO REVERB
;----------------------------------------------------------------------------------
               instr     90

idur           =         p3
igain          =         p4
iinch          =         p5

kdclik         linseg    0, .002, igain, idur-.004, igain, .002, 0

ain            zar       iinch
               outs      ain*kdclik, -ain*kdclik       ; INVERTING ONE SIDE MAKES THE SOUND
               endin                                   ; SEEM TO COME FROM ALL AROUND YOU.
                                                       ; THIS MAY CAUSE SOME PROBLEMS WITH CERTAIN
                                                       ; SURROUND SOUND SYSTEMS

;----------------------------------------------------------------------------------
; OUTPUT FOR STEREO REVERB
;----------------------------------------------------------------------------------
               instr     91

idur           =         p3
igain          =         p4
iinch1         =         p5
iinch2         =         p6

kdclik         linseg    0, .002, igain, idur-.004, igain, .002, 0

ain1           zar       iinch1
ain2           zar       iinch2
               outs      ain1*kdclik, ain2*kdclik

               endin

;----------------------------------------------------------------------------------
; CLEAR ZAK
;----------------------------------------------------------------------------------
               instr     99
               zacl      0,50
               endin

