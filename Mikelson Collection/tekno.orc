sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

; DRUM MACHINE
instr          1

kstep          init      0

; SEQUENCER SECTION
;-------------------------------------------------------------------------
  loop1:
;     READ ALL OF THE TABLE VALUES.
      kdur          table     kstep, p5
      kdrnum        table     kstep, p6
      kleft         table     kstep, p7
      kright        table     kstep, p8

      kdur1         =         kdur/8                   ; MAKE THE STEP SMALLER.

; ALL OF THE ENVELOPES WANT TO BE OUTSIDE OF THE IF FOR SOME REASON.
      kampenv1      linseg    0, .01, p4/2, .04, 0, .01, 0
      kampenv2      expseg    .0001, .01, p4, .04, .01
      kfreqenv      expseg    50,    .01, 200, .08, 50
      kampenv3      expseg    .0001, .01, p4*2,  .08, .01
      kampenv4      linseg    0, .001, 1,  i(kdur1)-.021, 1, .02, 0
      kfreqenv51    expseg    50,    .01, 200, .08, 50
      kfreqenv52    linseg    150,    .01, 1000, .08, 250, .01, 250
      kampenv5      linseg    0, .01, p4,  .08, 0, .01, 0
      kptchenv      linseg    100, .01, 300, .2, 200, .01, 200

      kampenv61     expseg    .01, .01, p4, .2, p4/100, .1, .001
      kampenv62     linseg    1, .1, 10,  .1, .5, .01, 1

; SOME OF THE SIGNAL GENERATORS MUST BE OUTSIDE OF THE IFS
      asig4         pluck     p4/2, kptchenv, 50, 2, 4, .8, 3
      asig5         foscil    kampenv61, 30, 1, 6.726, kampenv62, 1

; SWITCH BETWEEN THE DIFFERENT DRUMS
      if       (kdrnum != 0)  goto next1
        ; HIHAT
        aout        rand      kampenv1
        goto endswitch

next1:
      if       (kdrnum != 1)  goto next2
        ; DUMB DRUM
        asig        rand      kampenv2
        afilt       reson     asig, 1000, 100
        aout        balance   afilt, asig
        goto        endswitch

next2:
      if       (kdrnum != 2)  goto next3
        ; DUMB BASS DRUM
        asig        rand      kampenv3
        afilt       reson     asig, kfreqenv, kfreqenv/8
        aout        balance   afilt, asig
        goto        endswitch

next3:
      if       (kdrnum != 3)  goto next4
        ; KS SNARE
        aout        =         kampenv4*asig4
        goto        endswitch

next4:
      if       (kdrnum != 4)  goto next5
        ; SORTA COOL KNOCK SWEEP DRUM
        asig        rand      kampenv5
        afilt1      reson     asig, kfreqenv51, kfreqenv51/8
        afilt2      reson     asig, kfreqenv52, kfreqenv52/4
        aout1       balance   afilt1, asig
        aout2       balance   afilt2, asig
        aout        =         (aout1+aout2)/2
        goto        endswitch

next5:
      if       (kdrnum != 5)  goto endswitch
        ; FM METAL BOINK DRUM
        aout        =         asig5


endswitch:
;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND REINITIALIZE THE ENVELOPES.
                    timout    0, i(kdur1), cont1
        kstep       =         frac((kstep + 1)/8)*8
        reinit      loop1

  cont1:

                    outs      aout*kleft, aout*kright

endin

;-------------------------------------------------------------------------

instr 15            ; TABLE BASED REZZY SYNTH WITH ENVELOPED RESONANCE
;-------------------------------------------------------------------------
; A WHOLE BUNCH OF INITIALIZATIONS.
;-------------------------------------------------------------------------

inumsteps           =         16
idur                =         p3
iamp                =         p4
itabl1              =         p5
iaccent             =         p6
ienvdepth           =         p7
ifdecay             =         p8
iadecay             =         p9
kvalley             init      0
kpeak               init      0
knewval             init      1
knewpk              init      1
ksaveval            init      0
ksavepk             init      0
kynm1               init      0
kynm2               init      0
ktynm1              init      0
ktynm2              init      0
kfrangenm1          init      0
kfrangenm2          init      0
knewrez             init      0
kfsweep             init      30
kstep               init      0
knxtstp             init      1

; LFO FREQUENCY SWEEP
;-------------------------------------------------------------------------
  kfsweep           oscil     1, 1/idur, 130
  krez              oscil     1, 1/idur, 131

; SEQUENCER SECTION
;-------------------------------------------------------------------------
  loop1:
;     READ THE DURATION FOR THE CURRENT STEP OF THE SEQUENCE.
      kdur          table     kstep, 121
      kdur1         =         kdur/6                   ; MAKE THE STEP SMALLER.

;     FREQUENCY ENVELOPE
      kfco          expseg    (1-ienvdepth)*i(kfsweep)+10, .01, i(kfsweep), ifdecay, (1-ienvdepth)*i(kfsweep)+10

;     AMPLITUDE ENVELOPE
      kaenv         expseg    .00001, .01, 1, i(kdur1)-.02, iadecay, .01, .00001

;     PANNING
      kpanleft      table     kstep, 122
      kpanright     table     kstep, 123

;     PITCH FOR THE STEP OF THE SEQUENCE.
      kpch1         table     kstep, 120
      kfqc1         =         cpspch(kpch1)

;     PITCH FOR THE NEXT STEP NEED FOR SLIDING TO THE NEXT STEP.
      kpch2         table     knxtstp, 120
      kfqc2         =         cpspch(kpch2)

;     IF THE SLIDE IS TURNED ON THEN SLIDE UP TO THE NEXT STEP OTHERWISE 
;     DONT.
      kslide        table     knxtstp, 124

      if  (i(kslide) = 0)     goto skipslide
        kfqc        linseg    i(kfqc1), i(kdur1)-.06, i(kfqc1), .06, i(kfqc2)
        goto        nxtslide
      skipslide:
        kfqc        =         kfqc1
      nxtslide:

;     WHEN THE TIME RUNS OUT GO TO THE NEXT STEP OF THE SEQUENCE AND 
;     REINITIALIZE THE ENVELOPES.
                    timout    0, i(kdur1), cont1
        kstep       =         frac((kstep + 1)/inumsteps)*inumsteps
        knxtstp     =         frac((kstep + 1)/inumsteps)*inumsteps

        reinit      loop1
  cont1:

; START WITH MY LOW PASS RESONANT FILTER.

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ. FROM RES.
    ka1             =         100/krez/sqrt(kfco)-1
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
  kfrangen          = ((kta1+2*ka2)*kfrangenm1-ka2*kfrangenm2+krangen)/(1+kta1+ka2)

; THE FILTERED RANGE IS USED TO ENVELOPE THE RESONANCE THEN DISTORTION IS 
;ADDED.
  kclip1            = knewrez*kfrangen/krez/120000000
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
