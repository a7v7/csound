; PARAMETRIC EQUATION OSCILLATORS
sr             =              44100
kr             =              22050
ksmps          =              2
nchnls         =              2

; CYCLOID CURVE
; THIS SET OF PARAMETRIC EQUATIONS DEFINES THE PATH TRACED BY
; A POINT ON A CIRCLE OF RADIUS B ROTATING OUTSIDE OR INSIDE
; A CIRCLE OF RADIUS A.
               instr          2

idur           =              p3             ; DURATION
iamp           =              p4             ; AMPLITUDE
ifqc           =              cpspch(p5)     ; CONVERT PITCH TO FREQUENCY
ia             =              p6             ; RADIUS CIRCLE A
ib             =              p7             ; RADIUS CIRCLE B
ihole          =              p8             ; POSITION ALONG CIRCLE B RADIUS WHICH IS FOLLOWED
isgn           =              p9             ; SIGN +=OUTSIDE CIRCLE, -=INSIDE CIRCLE
ipbnd          =              p10            ; PITCH BEND TABLE
ibndrt         =              p11            ; PITCH BEND RATE
iscale         =              1/(ia+2*ib)    ; SCALING FACTOR TO NORMALIZE VOLUME

apbnd          oscil          1, ibndrt/idur, ipbnd                                  ; PITCH BEND
aamp           linseg         0, .02, iamp*iscale, idur-.04, iamp*iscale, .02, 0     ; DECLICK ENVELOPE
afqc           =               apbnd*ifqc                                            ; BEND THE PITCH

; SINE AND COSINE
acos1          oscil          ia+ib*isgn, afqc, 1, .25                ; COSINE EQUATION 1
acos2          oscil          ib*ihole, (ia-ib)/ib*afqc, 1, .25       ; COSINE EQUATION 2
ax             =              acos1 + acos2                           ; X VALUE IS THE SUM OF THE COSINES

asin1          oscil          ia+ib*isgn, afqc, 1                     ; SINE EQUATION 1
asin2          oscil          ib*ihole, (ia-ib)/ib*afqc, 1            ; SINE EQUATION 2
ay             =              asin1 - asin2                           ; Y VALUE IS THE DIFFERENCE OF THE SINES

               outs           aamp*ax, aamp*ay                        ; DECLICK AND OUTPUT

               endin

; BUTTERFLY CURVES
               instr          7

idur           =              p3                  ; DURATION
iamp           =              p4                  ; AMPLITUDE
ifqc           =              cpspch(p5)          ; CONVERT PITCH TO FREQUENCY
ia             =              p6                  ; PARAMETER A
ib             =              p7                  ; PARAMETER B
ic             =              p8                  ; PARAMETER C
id             =              p9                  ; PARAMETER D
ie             =              p10                 ; PARAMETER E

kamp           linseg         0, .001, iamp, idur-.002, iamp, .001, 0 ; DECLICK AMPLITUDE ENVELOPE

klfo1          oscil          .01, 6, 1                               ; LFO 1
krmp1          linseg         0, .1, 0, .2, 1, p3-.3, 1               ; RAMP 1

klfo2          oscil          .02, 4, 1                               ; LFO 2
krmp2          linseg         0, .4, 1, p3-.2, 1                      ; Ramp 2

kc             linseg         .5*ic, idur*.5, ic*2, idur*.5, .5*ic    ; MODULATE C WITH AN ENVELOPE
kb             =              ib*(1+klfo1*krmp1)                      ; MODULATE B WITH AN LFO
kd             =              id*(1+klfo2*krmp2)                      ; MODULATE D WITH AN LFO

; COSINES
acos1          oscil          1,  ifqc,    1, .25                     ; COSINE 1
acos2          oscil          ia, kb*ifqc, 1, .25                     ; COSINE 2
acos3          oscil          1, ifqc/kd,  1, .25                     ; COSINE 3

; SINES
asin1          oscil          1, ifqc,   1                            ; SINE 1
asin2          pow            asin1, ic                               ; SINE 2
asin3          oscil          1, ifqc/kd,   1                         ; SINE 3

arho           =              exp(ie*acos1)-acos2+asin2               ; GENERATE THE RADIUS

ax             =              arho*acos3                              ; GENERATE X VALUE
ay             =              arho*asin3                              ; GENERATE Y VALUE

               outs           ax*kamp, ay*kamp                        ; DECLICK AND OUTPUT

               endin

; SPHERICAL LISSAJOUS FIGURES
               instr     8

idur           =         p3                            ; DURATION
iamp           =         p4                            ; AMPLITUDE
ifqc           =         cpspch(p5)                    ; CONVERT PITCH TO FREQUENCY
iu             =         p6                            ; U PARAMETER
iv             =         p7                            ; V PARAMETER
irt2           =         sqrt(2)                       ; SQUARE ROOT OF 2
iradius        =         1                             ; RADIUS IS 1
                    
kamp           linseg    0, .002, iamp, idur-.004, iamp, .002, 0      ; DECLICK ENVELOPE

acos1          oscil     1, .5, 1, .25
asin1          oscil     1, .5, 1

; COSINES
acosu          oscil     1, iu*ifqc,    1, .25         ; COSINE OF FREQUENCY U
acosv          oscil     1, iv*ifqc,    1, .25         ; COSINE OF FREQUENCY V

; SINES
asinu          oscil     1, iu*ifqc,    1              ; SINE OF FREQUENCY U
asinv          oscil     1, iv*ifqc,    1              ; SINE OF FREQUENCY V

; COMPUTE X AND Y
ax             =         iradius*asinu*acosv           ; COMPUTE X VALUE
ay             =         iradius*asinu*asinv           ; COMPUTE Y VALUE
az             =         iradius*acosu                 ; COMPUTE Z VALUE
az1            =         az*acos1                      ; MODULATE Z VALUE FOR X
az2            =         az*asin1                      ; MODULATE Z VALUE FOR Y
               outs      (ax+az1)*kamp/2, (ay+az2)*kamp/2   ; SCALE X AND Y VALUES AND ADD Z

               endin


