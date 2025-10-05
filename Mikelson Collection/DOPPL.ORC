sr             =         44100
kr             =         22050
ksmps          =         2
nchnls         =         2

;-------------------------------------------------------------
; SOME NOISE BASED DOPPLER EFFECT SOUNDS.
;-------------------------------------------------------------
instr          1
; INITIALIZATIONS
;-------------------------------------------------------------
idlen          init      .2                  ;LENGTH OF THE DELAY LINE.
iphaz          init      .01                 ;PHASE DIFFERENCE BETWEEN RIGHT AND LEFT EARS.
ifqc           =         cpspch(p5)          ;CONVERT PITCH TO FREQUENCY.

; ENVELOPES
;-------------------------------------------------------------
kpanl          linseg    0, p3/3, .1, p3/3, .9, p3/3, 1               ;PAN LEFT
kpanr          =         1-kpanl                                      ;PAN RIGHT
kdopl          expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3       ;DOPPLER ENVELOPE
kdist          linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1        ;THE SOUND IS QUIETER 
                                                                      ;THE FARTHER AWAY IT IS.

; GENERATE NOISE BANDS
;-------------------------------------------------------------
anoize         rand      p4                       ;TAKE A NOISE
af1            reson     anoize, ifqc, 10         ;AND GENERATE SOME FREQUENCY
af2            reson     anoize, ifqc*2, 20       ;BANDS TO ADD TOGETHER
af3            reson     anoize, ifqc*8, 100      ;FOR INPUT TO THE DOPPLER EFFECT.
asamp          =         af1+af2+af3

; DOPPLER EFFECTS
;-------------------------------------------------------------
adel1          delayr    idlen                    ;THERE HAS TO BE ENOUGH ROOM FOR
atap1          deltapi   idlen/2+kdopl            ;AN OBJECT COMING FROM A LONG WAYS
atap2          deltapi   idlen/2+kdopl+iphaz      ;AWAY.  TAKE TWO TAPS FOR RIGHT AND
               delayw    asamp*kdist              ;LEFT EARS.

; SCALE AND OUTPUT
;-------------------------------------------------------------
               outs      atap1*kpanl, atap2*kpanr

               endin

;-------------------------------------------------------------
; SOME NOISE BASED DOPPLER EFFECT SOUNDS.
;-------------------------------------------------------------
instr          2
; INITIALIZATIONS
;-------------------------------------------------------------
idlen          init      .2                  ;LENGTH OF THE DELAY LINE.
iphaz          init      .01                 ;PHASE DIFFERENCE BETWEEN RIGHT AND LEFT EARS.
ifqc           =         cpspch(p5)          ;CONVERT PITCH TO FREQUENCY.

; ENVELOPES
;-------------------------------------------------------------
kpanl          linseg    0, p3/3, .1, p3/3, .9, p3/3, 1               ;PAN LEFT
kpanr          =         1-kpanl                                      ;PAN RIGHT
kdopl          expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3       ;DOPPLER ENVELOPE
kdist          linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1        ;THE SOUND IS QUIETER 
                                                                      ;THE FARTHER AWAY IT IS.

; GENERATE NOISE BANDS
;-------------------------------------------------------------
anoize         rand      p4                                           ;TAKE A NOISE
af1            reson     anoize, ifqc, 10                             ;AND GENERATE SOME FREQUENCY
af2            reson     anoize, ifqc*2, 20                           ;BANDS TO ADD TOGETHER
af3            reson     anoize, ifqc*8, 100                          ;FOR INPUT TO THE DOPPLER EFFECT.
asamp          =         af1+af2+af3

; DOPPLER EFFECTS
;-------------------------------------------------------------
adel1          delayr    idlen                                        ;THERE HAS TO BE ENOUGH ROOM FOR
atap1          deltapi   idlen/2+kdopl                                ;AN OBJECT COMING FROM A LONG WAYS
atap2          deltapi   idlen/2+kdopl+iphaz                          ;AWAY.  TAKE TWO TAPS FOR RIGHT AND
               delayw    asamp*kdist                                  ;LEFT EARS.

; SCALE AND OUTPUT
;-------------------------------------------------------------
               outs      atap2*kpanr, atap1*kpanl

               endin


;-------------------------------------------------------------
; SAMPLE BASED DOPPLER EFFECTS.
;-------------------------------------------------------------
               instr     3

idlen          init      .2
iphaz          init      .01
ifqc           =         p5

kpanl          linseg    0, p3/3, .1, p3/3, .9, p3/3, 1
kpanr          =         1-kpanl
kdopl          expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3
kdist          linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1

;SAMPLER
asamp          loscil    p4, p5, p6, 440, 1, p7, p8

adel1          delayr    idlen
atap1          deltapi   idlen/2+kdopl
atap2          deltapi   idlen/2+kdopl+iphaz
               delayw    asamp*kdist

               outs      atap1*kpanl, atap2*kpanr

               endin

;-------------------------------------------------------------
; SAMPLE BASED DOPPLER EFFECTS.
;-------------------------------------------------------------
               instr     4

idlen          init      .2
iphaz          init      .01
ifqc           =         p5

kpanl          linseg    0, p3/3, .1, p3/3, .9, p3/3, 1
kpanr          =         1-kpanl
kdopl          expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3
kdist          linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1

;SAMPLER
asamp          loscil    p4, p5, p6, 440, 1, p7, p8

adel1          delayr    idlen
atap1          deltapi   idlen/2+kdopl
atap2          deltapi   idlen/2+kdopl+iphaz
               delayw    asamp*kdist

               outs      atap2*kpanr, atap1*kpanl
     
               endin


;-------------------------------------------------------------
; SOME MORE NOISE BASED DOPPLER EFFECT SOUNDS.
;-------------------------------------------------------------
instr          5
; INITIALIZATIONS
;-------------------------------------------------------------
idlen          init      .5                  ;LENGTH OF THE DELAY LINE.
iphaz          init      .01                 ;PHASE DIFFERENCE BETWEEN RIGHT AND LEFT EARS.
ifqc           =         cpspch(p5)          ;CONVERT PITCH TO FREQUENCY.

;USE THE LORENZ ATTRACTOR FOR THE MOTION OF THE SOUND
;--------------------------------------------------------------------
kx             init      p10
ky             init      p11
kz             init      p12
kh             init      p6
ks             init      p7
kr1            init      p8
kb             init      p9
kdoplr         init      idlen/2

;--------------------------------------------------------------------
kdx            =         kh*ks*(ky-kx)
kdy            =         kh*(-kx*kz+kr1*kx-ky)
kdz            =         kh*(kx*ky-kb*kz)

;--------------------------------------------------------------------
kx             =         kx+kdx
ky             =         ky+kdy
kz             =         kz+kdz

kxscale        =         kx
kyscale        =         ky
kdxscale       =         kdx
kdyscale       =         kdy

; SOUND MODIFICATIONS.  
; PANNING GOES TO 1,0 AT -inf, 0,1 AT +inf AND 1/2,1/2 AT 0
;-------------------------------------------------------------
kpanl          =         1/(1+exp(kxscale/10))                             ;COMPUTE PAN LEFT
kpanr          =         1/(1+exp(-kxscale/10))                            ;COMPUTE PAN RIGHT
kdist          =         sqrt(kxscale*kxscale+kyscale*kyscale+1)           ;FIND THE DISTANCE TO THE SOURCE.
kddoplr        =         (kxscale*kdxscale+kyscale*kdyscale)*10/kdist      ;DOPPLER EFFECT OR DELTAP INCREMENT.
kdoplr         =          kdoplr+kddoplr/20000

; GENERATE NOISE BANDS
;-------------------------------------------------------------
;anoize        rand      p4                            ;TAKE A NOISE
;af1           reson     anoize, ifqc, 10              ;AND GENERATE SOME FREQUENCY
;af2           reson     anoize, ifqc*2, 20            ;BANDS TO ADD TOGETHER
;af3           reson     anoize, ifqc*8, 100           ;FOR INPUT TO THE DOPPLER EFFECT.
;asamp         =         af1+af2+af3
asamp          buzz      p4, ifqc, 10, 2

; DOPPLER EFFECTS
;-------------------------------------------------------------
adel1          delayr    idlen                         ;THERE HAS TO BE ENOUGH ROOM FOR
atap1          deltapi   kdoplr                        ;AN OBJECT COMING FROM A LONG WAYS
atap2          deltapi   kdoplr+iphaz                  ;AWAY.     TAKE TWO TAPS FOR RIGHT AND
               delayw    asamp/kdist                   ;LEFT EARS.

; SCALE AND OUTPUT
;-------------------------------------------------------------
               outs      atap1*kpanl, atap2*kpanr

;ax            =         kx
;ay            =         ky

               ;outs     ax*100, ay*100

               endin

;-------------------------------------------------------------
; SOME MORE NOISE BASED DOPPLER EFFECT SOUNDS.
;-------------------------------------------------------------
instr          6
; INITIALIZATIONS
;-------------------------------------------------------------
idlen          init      .5                       ;LENGTH OF THE DELAY LINE.
iphaz          init      .01                      ;PHASE DIFFERENCE BETWEEN RIGHT AND LEFT EARS.
ifqc           =         cpspch(p5)               ;CONVERT PITCH TO FREQUENCY.

;INITIALIZE x, y, dx, dy
;--------------------------------------------------------------------
kx             init      p6
ky             init      p7
kdx            init      p8
kdy            init      p9
kdoplr         init      idlen/2

;--------------------------------------------------------------------
kx             =         kx+kdx
ky             =         ky+kdy

; SOUND MODIFICATIONS.  
; PANNING GOES TO 1,0 at -inf, 0,1 at +inf and 1/2,1/2 at 0
;-------------------------------------------------------------
kpanl          =         1/(1+exp(kx/20))                        ;COMPUTE PAN LEFT
kpanr          =         1/(1+exp(-kx/20))                       ;COMPUTE PAN RIGHT
kdist          =         sqrt(kx*kx+ky*ky+1)                     ;FIND THE DISTANCE TO THE SOURCE.
kddoplr        =         (kx*kdx+ky*kdy)/kdist                   ;DOPPLER EFFECT OR DELTAP INCREMENT.
kdoplr         =         kdoplr+kddoplr/4000

; GENERATE NOISE BANDS
;-------------------------------------------------------------
;anoize        rand      p4                                      ;TAKE A NOISE
;af1           reson     anoize, ifqc, 10                        ;AND GENERATE SOME FREQUENCY
;af2           reson     anoize, ifqc*2, 20                      ;BANDS TO ADD TOGETHER
;af3           reson     anoize, ifqc*8, 100                     ;FOR INPUT TO THE DOPPLER EFFECT.
;asamp         =         af1+af2+af3
asamp          buzz      p4, ifqc, 10, 2

; DOPPLER EFFECTS
;-------------------------------------------------------------
adel1          delayr    idlen                         ;THERE HAS TO BE ENOUGH ROOM FOR
atap1          deltapi   kdoplr                        ;AN OBJECT COMING FROM A LONG WAYS
atap2          deltapi   kdoplr+iphaz                  ;AWAY.     TAKE TWO TAPS FOR RIGHT AND
               delayw    asamp/kdist                   ;LEFT EARS.

; SCALE AND OUTPUT
;-------------------------------------------------------------
               outs      atap1*kpanl, atap2*kpanr

               endin

;-------------------------------------------------------------
; SAMPLER WITH HRTF.
;-------------------------------------------------------------
               instr     7

kaz            linseg    0, p3, -360
kel            linseg    -40, p3, 45

;SAMPLER
;asamp         loscil    p4, p5, p6, 440, 1, p7, p8
asamp          oscili    p4, p5, 3
aleft, aright  hrtfer    asamp, kaz, kel, "hrtfcomp"
               outs      aleft*100, aright*100

               endin

;-------------------------------------------------------------
; DISKIN WITH HRTF.
;-------------------------------------------------------------
               instr     8

iamp           =         p4
irate          =         p5
isndin         =         p6

kaz            linseg    -180, p3, 180
kel            linseg    -20, p3, 20

ain            diskin    isndin, irate
al, ar         hrtfer    ain, kaz, kel, "hrtfcomp"
; TRY TO ELIMINATE CLICKING
kl1            downsamp  al
kr1            downsamp  ar
klout          port      kl1, 1/sr
krout          port      kr1, 1/sr
alout          =         klout
arout          =         krout
               outs      alout*iamp, arout*iamp

               endin


