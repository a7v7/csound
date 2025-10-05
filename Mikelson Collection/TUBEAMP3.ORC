sr             =         44100
kr             =         22050
ksmps          =         2
nchnls         =         1

gasig          init      0

; SIMPLE SIN
instr          1

  iamp         init      p4
  ifqc         init      p5
  kamp         linseg    0, .01, p4, p3-.02, p4, .01, 0

  asin1        oscil     kamp, ifqc, 1
;              out       asin1
  gasig        =         gasig + asin1

endin

; PLUCK
instr          2

  ifqc         =         cpspch(p5)
  kamp         linseg    0, .01, p4, p3-.02, p4/2, .01, 0

  asin1        pluck     kamp, ifqc, ifqc, p6, p7
  asig1        butterhp  asin1, 10
  asig         butterlp  asig1, 5000
;  out         asig
  gasig        =         gasig + asig

endin

; TUBE AMP
instr          10

asig           init      0
kamp           linseg    0, .002, 1, p3-.004, 1, .002, 0
igaini         =         p4
igainf         =         p5
iduty          =         p6
islope         =         p7

aold           =         asig
asig           =         igaini*gasig/40000       ; DISTORTION EFFECT USING WAVESHAPING.
aclip          tablei    asig,5,1,.5              ; A LAZY "S" CURVE, USE TABLE 6 FOR INCREASED
;aclip         =         asig
aclip          =         igainf*aclip*10000       ; DISTORTION.

; TUBE AMPLIFIERS SHOW A SHIFTED DUTY CYCLE WHICH I TRY TO EMULATE WITH
; A DELAY LINE.  THE SLOPE BIT IS JUST SOMETHING GOOFY I THOUGHT I WOULD ADD.
atemp          delayr    .1
adel1          deltapi   (1-iduty*asig)/1500 + (1+islope*(asig-aold))/1500
               delayw    aclip

               out       adel1*kamp

  gasig        =         0

endin

