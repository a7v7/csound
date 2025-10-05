;===========================================================================
; TALK BOX
; HANS MIKELSON MARCH 1999
;===========================================================================
sr             =         44100
kr             =         22050
ksmps          =         2
nchnls         =         2
               zakinit   50, 50

;---------------------------------------------------------------------------
; PLUCK
;---------------------------------------------------------------------------
               instr     2

iamp           =         p4                  ; AMPLITUDE
ifqc           =         cpspch(p5)          ; CONVERT PITCH TO FREQUENCY
ioutch         =         p6                  ; OUTPUT CHANNEL

kamp           linseg    0, .002, iamp, p3-.004, iamp, .002, 0  ; Declick

aplk           pluck     kamp, ifqc, ifqc, 0, 1        ; PLUCK WAVEGUIDE MODEL
               zawm      aplk, ioutch                  ; WRITE TO OUTPUT
               endin

;---------------------------------------------------------------------------
; TALK-BOX
;---------------------------------------------------------------------------
               instr     10

idur           =         p3                  ; DURATION
ixtab          =         p4                  ; INDEX TABLE
ifmtab1        =         p5                  ; FORMANT TABLE 1
ifmtab2        =         p6                  ; FORMANT TABLE 2
ifmtab3        =         p7                  ; FORMANT TABLE 3
iatab1         =         p8                  ; AMPLITUDE TABLE 1
iatab2         =         p9                  ; AMPLITUDE TABLE 2
iatab3         =         p10                 ; AMPLITUDE TABLE 3
izin           =         p11                 ; INPUT CHANNEL

iptime         =         idur/16             ; TIME TO SLIDE HALF WAY TO NEXT FORMANT SET
ibw            =         8                   ; BANDWIDTH

kdeclick       linseg    0, .002, 1, p3-.004, 1, .002, 0         ; DECLICK
kformi         oscil     1, 1/idur, ixtab    ; READ THE FORMANT INDEX TABLE

kform1         table     kformi, ifmtab1     ; READ THE FIRST FORMANT FREQUENCY
kdb1           table     kformi, iatab1      ; READ THE FIRST FORMANT DBS
kamp1          =         dbamp(60+kdb1)      ; CONVERT FROM DECIBELS TO AMPLITUDE
kform2         table     kformi, ifmtab2     ; READ THE SECOND FORMANT FREQUENCY
kdb2           table     kformi, iatab2      ; READ THE SECOND FORMANT DBS
kamp2          =         dbamp(60+kdb2)      ; CONVERT DB TO AMP
kform3         table     kformi, ifmtab3     ; READ THE THIRD FORMANT FREQUENCY
kdb3           table     kformi, iatab3      ; READ THE THIRD FORMNAT DBS
kamp3          =         dbamp(60+kdb3)      ; CONVERT DB TO AMP

kfrm1p         port      kform1, iptime, 300      ; PORTAMENTO TO THE NEXT FORMANT
kamp1p         port      kamp1,    iptime, .15    ; PORTAMENTO TO THE NEXT AMPLITUDE
kfrm2p         port      kform2, iptime, 2000     ; REPEAT FOR SECOND
kamp2p         port      kamp2,    iptime, .15
kfrm3p         port      kform3, iptime, 4000     ; AND AGAIN FOR THE THIRD
kamp3p         port      kamp3,    iptime, .15

asig           zar       izin                     ; OUTPUT CHANNEL
adist          =         tanh(asig/4000)*8000

aform1         butterbp  adist, kfrm1p, kfrm1p/ibw          ; COMPUTE THE THREE RESONANCES
aform2         butterbp  adist, kfrm2p, kfrm2p/ibw
aform3         butterbp  adist, kfrm3p, kfrm3p/ibw

aout           =         (aform1*kamp1p+aform2*kamp2p+aform3*kamp3p)/5      ; SCALE AND SUM

               outs      aout*kdeclick, aout*kdeclick       ; WRITE TO THE OUTPUT CHANNEL

               endin

               instr     99
               zacl      0, 50
               endin

