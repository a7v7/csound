;
;-------------------------------------------------------------------------
; TB WANNABE
;-------------------------------------------------------------------------

sr             =         44100
kr             =         44100
ksmps          =         1
nchnls         =         2

;-------------------------------------------------------------------------

instr          15        ; TABLE BASED REZZY SYNTH WITH ENVELOPED RESONANCE
;-------------------------------------------------------------------------
; A WHOLE BUNCH OF INITIALIZATIONS.
;-------------------------------------------------------------------------

idur           =         p3
iamp           =         p4
ifqc           =         cpspch(p5)
irez           =         p7
itabl1         =         p8
kvalley        init      0
kpeak          init      0
knewval        init      1
knewpk         init      1
ksaveval       init      0
ksavepk        init      0
kynm1          init      0
kynm2          init      0
ktynm1         init      0
ktynm2         init      0
kfrangenm1     init      0
kfrangenm2     init      0
knewrez        init      0
kfsweep        init      30
kstep          init      0
knxtstp        init      1

; LFO FREQUENCY SWEEP
;-------------------------------------------------------------------------
  kfsweep      expseg    30, .5*p3, p6, .5*p3, 30

; SEQUENCER SECTION
;-------------------------------------------------------------------------
  loop1:
;     READ THE DURATION FOR THE CURRENT STEP OF THE SEQUENCE.
      kdur     table     kstep, 21
      kdur1    =         kdur/8                   ; MAKE THE STEP SMALLER.

;     FREQUENCY ENVELOPE
      kfco     expseg    20, .1, i(kfsweep), i(kdur1)-.1, 20

;     AMPLITUDE ENVELOPE
      kaenv    linseg    0, .01, 1, i(kdur1)-.02, 1, .01, 0

;     PANNING
      kpanleft      table     kstep, 22
      kpanright     table     kstep, 23

;     PITCH FOR THE STEP OF THE SEQUENCE.
      kpch1         table     kstep, 20
      kfqc1         =         cpspch(kpch1)

;     PITCH FOR THE NEXT STEP NEED FOR SLIDING TO THE NEXT STEP.
      kpch2         table     knxtstp, 20
      kfqc2         =         cpspch(kpch2)

;     IF THE SLIDE IS TURNED ON THEN SLIDE UP TO THE NEXT STEP OTHERWISE 
;DONT.
      if            (p9 = 0)  goto skipslide
        kfqc        linseg    i(kfqc1), i(kdur1)-.04, i(kfqc1), .04, i(kfqc2)
        goto        nxtslide
      skipslide:
        kfqc        =         kfqc1
      nxtslide:

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND 
;REINITIALIZE THE ENVELOPES.
                    timout    0, i(kdur1), cont1
        kstep       =         frac((kstep + 1)/8)*8
        knxtstp     =         frac((kstep + 1)/8)*8

        reinit      loop1
  cont1:

; START WITH MY LOW PASS RESONANT FILTER.

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ. FROM RES.
    ka1             =         100/irez/sqrt(kfco)-1
    kta1            =         100/sqrt(kfco)-1
    ka2             =         1000/kfco

; OSCILLATOR
  kxn               oscil     iamp, kfqc, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
  kyn               =         ((ka1+2*ka2)*kynm1-ka2*kynm2+kxn)/(1+ka1+ka2)
  ktyn              =         ((kta1+2*ka2)*ktynm1-ka2*ktynm2+kxn)/(1+kta1+ka2)

; EXTRACT THE RESONANCE FROM THE FILTERED SIGNAL.
  koldrez           =         knewrez
  knewrez           =         kyn-ktyn

; THIS SECTION DETERMINES CURRENT PEAK AND VALLEY VALUES AND THE RANGE.
; AS LONG AS THE SIGNAL RISES IT TRACKS PEAK.  WHEN IT FALLS IT UPDATES
; PEAK AND TRACKS VALLEY.

  if      (koldrez>=knewrez)  goto next1
    if    (knewval != 1)      goto next2
      knewval       =         0
      knewpk        =         1
      kvalley       =         ksaveval
next2:
    ksavepk         =         knewrez

next1:
  if      (koldrez<=knewrez)  goto next 3
    if    (knewpk != 1)       goto next4
      knewpk        =         0
      knewval       =         1
      kpeak         =         ksavepk
next4:
    ksaveval        =         knewrez

next3:
; THE CURRENT RANGE IS CALCULATED AND LOW PASS FILTERED.
  krangen           =         abs(kpeak-kvalley)
  kfrangen          =         ((kta1+2*ka2)*kfrangenm1-ka2*kfrangenm2+krangen)/(1+kta1+ka2)

; THE FILTERED RANGE IS USED TO ENVELOPE THE RESONANCE THEN DISTORTION IS 
;ADDED.
  kclip1            =         knewrez*kfrangen/irez/120000000
  kclip             tablei    kclip1, 7, 1, .5
  kout              =         ktyn + kclip*40000

; UPDATE EVERYTHING FOR THE NEXT PASS.
  kynm2             =         kynm1
  kynm1             =         kyn
  ktynm2            =         ktynm1
  ktynm1            =         ktyn
  kfrangenm2        =         kfrangenm1
  kfrangenm1        =         kfrangen

; CONVERT TO AUDIO RATES
  aout              =         kout

; AMP ENVELOPE, PAN AND OUTPUT
                    outs      kaenv*kpanleft*aout, kaenv*kpanright*aout

endin
