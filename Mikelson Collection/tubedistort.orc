; ORCHESTRA BEGINS HERE.

sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         1

gasig          init      0

; PLUCK
instr          2

  iamp         =         p4*4
  ifqc         =         cpspch(p5)
  kamp         linseg    0, .002, p4, p3-.004, p4, .002, 0

  asin1        pluck     kamp, ifqc, ifqc, p6, p7
  gasig        =         gasig + asin1

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
asig           =         igaini*gasig/40000 
; DISTORTION EFFECT USING WAVESHAPING.
aclip          tablei    asig,5,1,.5         
; A LAZY "S" CURVE, USE TABLE 6 FOR INCREASED DISTORTION.
aclip          =         igainf*aclip*10000

; TUBE AMPLIFIERS SHOW A SHIFTED DUTY CYCLE WHICH I TRY TO EMULATE WITH
; A DELAY LINE.  THE SLOPE BIT IS JUST SOMETHING GOOFY I THOUGHT I WOULD ADD.
atemp          delayr    .1
adel1          deltapi   (1-iduty*asig)/3000 + (1+islope*(asig-aold))/3000
               delayw    aclip

               out       adel1*kamp

  gasig        =         0

endin
