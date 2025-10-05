; ************************************************************************
; ADVANCED RESONANT LOW-PASS FILTER INSTRUMENTS
;*************************************************************************
; 1. FM BASED REZZY SYNTH
; 2. 4 POLE REZZY
; 3. 6 POLE FORMANT FILTER
;*************************************************************************

sr             =         44100
kr             =         44100
ksmps          =         1
nchnls         =         2
;******************************************************************
instr          1                   ; FM BASED REZZY SYNTH

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
irez           =         p7
itabl1         =         p8

; AMPLITUDE ENVELOPE
kaenv          linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0
kfmenv         linseg    .2, .2*p3, 2, .6*p3, .5, .2*p3, .2

; FREQUENCY SWEEP
kfco           linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1            =         100/irez/sqrt(kfco)-1
ka2            =         1000/kfco

; INITIALIZE YN-1 & YN-2 TO ZERO
aynm1          init      0
aynm2          init      0

; OSCILLATOR
  axn          foscil    iamp, ifqc, p9, p10, kfmenv, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
  ayn          =         ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
  aynm2        =         aynm1
  aynm1        =         ayn

; AMP ENVELOPE AND OUTPUT
  aoutl        =         ayn * kaenv
  aoutr        delay     aoutl, .01
               outs      aoutl, aoutr

               endin

;******************************************************************
instr          2                        ; 4 POLE FILTER

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
irez1          =         p7
irez2          =         p9
itabl1         =         p10

; AMPLITUDE ENVELOPE
kaenv          linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1          linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6
kfco2          linseg    .1*p8, .5*p3, p8, .5*p3, .1*p8

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1            =         100/irez1/sqrt(kfco1)-1
ka2            =         1000/kfco1
kb1            =         100/irez2/sqrt(kfco2)-1
kb2            =         1000/kfco2

; INITIALIZE YN-1 TO YN-4 TO ZERO
ayn1m1         init      0
ayn1m2         init      0
ayn2m1         init      0
ayn2m2         init      0

; OSCILLATOR
  axn          oscil     iamp, ifqc, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
  ayn1         =         ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2       =         ayn1m1
  ayn1m1       =         ayn1

  ayn          =         ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2       =         ayn2m1
  ayn2m1       =         ayn

; AMP ENVELOPE AND OUTPUT
  aoutl        =         ayn * kaenv
  aoutr        delay     aoutl, .01
               outs      aoutl, aoutr

               endin

;******************************************************************
instr          3                             ; 6 POLE FORMANT FILTER

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
irez1          =         p7
irez2          =         p9
irez3          =         p11
itabl1         =         p12

; AMPLITUDE ENVELOPE
kaenv          linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1          linseg    .1*p6,     .5*p3, p6,  .5*p3, .1*p6
kfco2          linseg    .1*p8,     .5*p3, p8,  .5*p3, .1*p8
kfco3          linseg    .1*p10, .5*p3, p10, .5*p3, .1*p10

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1            =         100/irez1/sqrt(kfco1)-1
ka2            =         1000/kfco1
kb1            =         100/irez2/sqrt(kfco2)-1
kb2            =         1000/kfco2
kc1            =         100/irez3/sqrt(kfco3)-1
kc2            =         1000/kfco3

; INITIALIZE YN-1 TO YN-2 TO ZERO
ayn1m1         init      0
ayn1m2         init      0
ayn2m1         init      0
ayn2m2         init      0
ayn3m1         init      0
ayn3m2         init      0

; OSCILLATOR
  axn          oscil     iamp, ifqc, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
  ayn1         =         ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2       =         ayn1m1
  ayn1m1       =         ayn1

  ayn2         =         ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2       =         ayn2m1
  ayn2m1       =         ayn2

  ayn          =         ((kc1+2*kc2)*ayn3m1-kc2*ayn3m2+ayn2)/(1+kc1+kc2)

  ayn3m2       =         ayn3m1
  ayn3m1       =         ayn

; AMP ENVELOPE AND OUTPUT
  aoutl        =         ayn * kaenv
  aoutr        delay     aoutl, .01
               outs      aoutl, aoutr

               endin

;******************************************************************
instr          4                                  ; MANDELBROT'S SNOWFLAKE 4 POLE FILTER

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
irez1          =         p7
irez2          =         p7
iamp2          =         p8
iamp3          =         p9

; AMPLITUDE ENVELOPE
kaenv          linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1          linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6
kfco2          linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1            =         100/irez1/sqrt(kfco1)-1
ka2            =         1000/kfco1
kb1            =         100/irez2/sqrt(kfco2)-1
kb2            =         1000/kfco2

; INITIALIZE YN-1 TO YN-4 TO ZERO
ayn1m1         init      0
ayn1m2         init      0
ayn2m1         init      0
ayn2m2         init      0

; OSCILLATOR
  ax1          oscil     iamp,  ifqc, 6
  ax2          oscil     iamp2, ifqc*4, 6
  ax3          oscil     iamp3, ifqc/4, 6
  axn          =         ax1 + ax2 + ax3

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
  ayn1         =         ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2       =         ayn1m1
  ayn1m1       =         ayn1

  ayn          =         ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2       =         ayn2m1
  ayn2m1       =         ayn

; AMP ENVELOPE AND OUTPUT
  aoutl        =         ayn * kaenv
  aoutr        =         axn * kaenv
               outs      aoutl, aoutr

               endin

;******************************************************************
instr          5                             ; SNOWFLAKE 4 POLE FILTER

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
irez1          =         p7
irez2          =         p7
iamp2          =         p8
iamp3          =         p9
iamp4          =         p10
iamp5          =         p11

; AMPLITUDE ENVELOPE
kaenv          linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1          linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6
kfco2          linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1            =         100/irez1/sqrt(kfco1)-1
ka2            =         1000/kfco1
kb1            =         100/irez2/sqrt(kfco2)-1
kb2            =         1000/kfco2

; INITIALIZE YN-1 TO YN-4 TO ZERO
ayn1m1         init      0
ayn1m2         init      0
ayn2m1         init      0
ayn2m2         init      0

; OSCILLATOR
  ax1          oscil     iamp,  ifqc, 4
  ax2          oscil     iamp2, ifqc*2, 4
  ax3          oscil     iamp3, ifqc*4, 4
  ax4          oscil     iamp3, ifqc/2, 4
  ax5          oscil     iamp3, ifqc/4, 4
  axn          =         ax1 + ax2 + ax3 + ax4 + ax5

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
  ayn1         =         ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2       =         ayn1m1
  ayn1m1       =         ayn1

  ayn          =         ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2       =         ayn2m1
  ayn2m1       =         ayn

; AMP ENVELOPE AND OUTPUT
  aoutl        =         ayn * kaenv
  aoutr        =         axn * kaenv
               outs      aoutl, aoutr

               endin

;******************************************************************
instr          6                                       ; SAMPLE HOLD GENERATOR

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
irez1          =         p7
irez2          =         p7
iamp2          =         p8
iamp3          =         p9
iamp4          =         p10
iamp5          =         p11

; AMPLITUDE ENVELOPE
kaenv          linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1          linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6
kfco2          linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1            =         100/irez1/sqrt(kfco1)-1
ka2            =         1000/kfco1
kb1            =         100/irez2/sqrt(kfco2)-1
kb2            =         1000/kfco2

; INITIALIZE YN-1 TO YN-4 TO ZERO
ayn1m1         init      0
ayn1m2         init      0
ayn2m1         init      0
ayn2m2         init      0

; OSCILLATOR
  axn          randi     iamp, ifqc

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
  ayn1         =         ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2       =         ayn1m1
  ayn1m1       =         ayn1

  ayn          =         ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2       =         ayn2m1
  ayn2m1       =         ayn

; AMP ENVELOPE AND OUTPUT
  aoutl        =         ayn * kaenv
  aoutr        =         ayn * kaenv
               outs      aoutl, aoutr

               endin

;******************************************************************
instr          7                                  ; SAW/RAMP /\ TRANSFORMATION

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
irez1          =         p7
itabl1         =         p8

; AMPLITUDE ENVELOPE
kaenv          linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1          linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1            =         100/irez1/sqrt(kfco1)-1
ka2            =         1000/kfco1

; INITIALIZE YN-1 TO YN-4 TO ZERO
aynm1          init      0
aynm2          init      0
adx            init      20000/sr*ifqc
kdx            init      1

; OSCILLATOR
start:
               timout    0, 1/ifqc, continue
  axn          =         -10000
  kdx          =         -kdx
  kslope       =         (kdx<0 ? 10 : 1/10)
  
  reinit       start

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
continue: axn  =         axn + kdx

  ayn          =         ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
  aynm2        =         aynm1
  aynm1        =         ayn

; AMP ENVELOPE AND OUTPUT
  aoutl        =         ayn * kaenv
  aoutr        =         ayn * kaenv
               outs      aoutl, aoutr

               endin
