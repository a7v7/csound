;-----------------------------------------------------------
; TERRAIN MAPPING EXAMPLE
; CODED BY HANS MIKELSON
; JULY 15, 1998
;-----------------------------------------------------------

sr        =         44100               ; SAMPLE RATE
kr        =         22050               ; CONTROL RATE
ksmps     =         2                   ; SR/KR
nchnls    =         2                   ; STEREO OUTPUT
          zakinit   50, 50              ; INITIALIZE THE ZAK CHANNELS

;-----------------------------------------------------------
; Sine Modulation
;-----------------------------------------------------------
          instr     3

idur      =         p3                  ; DURATION
iamp      =         p4                  ; AMPLITUDE
ifqc      =         p5                  ; FREQUENCY
iphase    =         p6                  ; PHASE OFFSET
ioutch    =         p7                  ; OUTPUT CHANNEL

krad1     oscili    iamp, ifqc, 1, iphase    ; SINE WAVE OSCILLATOR
kout      =         krad1+2*iamp             ; MAKE IT POSITIVE
          zkw       kout, ioutch             ; SEND IT OUT ON THE K-CHANNEL

          endin

;-----------------------------------------------------------
; 4D
; w=sin^2*(sqrt(x^2+y^2+z^2))
;-----------------------------------------------------------
          instr     5

idur      =         p3                       ; DURATION
iamp      =         p4                       ; AMPLITUDE
ifqc      =         cpspch(p5)               ; CONVERT PITCH TO FREQUENCY
iwamp     =         p6                       ; AMPLITUDE OF THE W DIMENSION
ioutch1   =         p7                       ; OUTPUT AUDIO CHANNEL 1
ioutch2   =         p8                       ; OUTPUT AUDIO CHANNEL 2
ioutch3   =         p9                       ; OUTPUT AUDIO CHANNEL 3
ioutch4   =         p10                      ; OUTPUT AUDIO CHANNEL 4

kdclick   linseg    0, .02, iamp, idur-.04, iamp, .02, 0    ; DE-CLICK ENVELOPE
krminor   oscil     5, .2, 1                                ; MODULATE THE MINOR RADIUS
krminor   =         krminor+6                               ; MAKE IT POSITIVE
krmajor   =         krminor+1                               ; MAJOR RADIUS IS 1 BIGGER THAN MINOR

asin1     oscil     krminor, ifqc, 1                        ; MINOR CIRCLE Y COORDINATE
acos1     oscil     krminor, ifqc, 1, .25                   ; MINOR CIRCLE X COORDINATE
asin2     oscil     krmajor, ifqc/4, 1                      ; MAJOR CIRCLE Y COORDINATE
acos2     oscil     krmajor, ifqc/4, 1, .25                 ; MAJOR CIRCLE X COORDINATE

ax        =         asin1+acos2                   ; THIS ORBIT IS A SPIRAL ON
ay        =         acos1                         ; THE SURFACE OF A TORUS WHOSE
az        =         asin2                         ; RADIUS IS BEING MODULATED.

aw1       =         sin(sqrt(ax*ax+ay*ay+az*az))  ; COMPUTE THE SURFACE A BUMPY 4 DIMENSIONAL SURFACE
aw        =         aw1*aw1-.5                    ; REMOVE SOME DC OFFSET

          zawm      ax*kdclick, ioutch1           ; OUTPUT TO THE ZAK AUDIO CHANNELS
          zawm      ay*kdclick, ioutch2
          zawm      az*kdclick, ioutch3
          zawm      aw*kdclick*iwamp, ioutch4

          endin

;-----------------------------------------------------------
; Z=X-1/12*X^3-1/4*Y^2
; LEAD 1
;-----------------------------------------------------------
          instr     12

idur      =         p3                            ; DURATION
iamp      =         p4                            ; AMPLITUDE
ifqc      =         cpspch(p5)                    ; CONVERT PITCH TO FREQUENCY
imodch    =         p6                            ; CONTROL CHANNEL INPUT
ipetal    =         p7                            ; NUMBER OF PETALS ON THE ROSE CURVE
ioutch    =         p8                            ; OUTPUT AUDIO CHANNEL

kmod1     zkr       imodch                        ; READ CONTROL CHANNEL

kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0      ; DE-CLICK ENVELOPE
kpfade    linseg    0, .2, 0, .2, .01, idur-.4, .005             ; VIBRATO FADE
kplfo     oscil     kpfade, 6, 1                                 ; VIBRATO
kfqc      =         (1+kplfo)*ifqc                               ; MODULATE THE PITCH

arose     oscil     kmod1, ipetal*kfqc, 1                        ; ROSE CURVE
ax        oscil     arose, kfqc, 1                               ; CONVERT FROM POLAR TO
ay        oscil     arose, kfqc, 1, .25                          ; RECTANGULAR COORDINATES

az        =         ax-ax*ax*ax/12-ay*ay/4+.5                    ; COMPUTE THE SURFACE
adcblk    butterhp  az, 20                                       ; REMOVE THE DC COMPONENT

          zaw       adcblk*kdclick, ioutch                       ; OUTPUT TO A ZAK AUDIO CHANNEL

          endin

;-----------------------------------------------------------
; Z=-5*X/(X^2+Y^2+1)
; SQUARISH LEAD 2
;-----------------------------------------------------------
          instr     13

idur      =         p3                            ; DURATION
iamp      =         p4                            ; AMPLITUDE
ifqc      =         cpspch(p5)                    ; CONVERT PITCH TO FREQUENCY
imodch    =         p6                            ; CONTROL CHANNEL
ipetal    =         p7                            ; NUMBER OF PETALS ON THE ROSE CURVE
idetun    =         p8                            ; DETUNE AMOUNT

ifqc1     =         ifqc*(1+idetun)               ; ADD SOME CHORUSING
ifqc2     =         ifqc*(1-idetun*.9)            ; AND STEREO DETUNING

kmod1     zkr       imodch                        ; READ FROM THE MODULATION CONTROL CHANNEL
kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0      ; DE-CLICK ENVELOPE

arose     oscil     kmod1+1, ipetal*ifqc, 1       ; ROSE CURVE
ax        oscil     arose, ifqc, 1                ; CONVERT FROM POLAR TO
ay        oscil     arose, ifqc, 1, .25           ; RECTANGULAR COORDINATES
az        =         -5*ax/(ax*ax+ay*ay+1)         ; COMPUTE THE SURFACE FOR OSCILLATOR 1

arose1    oscil     kmod1+1, ipetal*ifqc1, 1      ; ROSE CURVE
ax1       oscil     arose1, ifqc1, 1              ; CONVERT FROM POLAR TO
ay1       oscil     arose1, ifqc1, 1, .25         ; RECTANGULAR COORDINATES
az1       =         -5*ax1/(ax1*ax1+ay1*ay1+1)    ; COMPUTE THE SURFACE FOR OSCILLATOR 2

arose2    oscil     kmod1+1, ipetal*ifqc2, 1      ; ROSE CURVE
ax2       oscil     arose2, ifqc2, 1              ; CONVERT FROM POLAR TO
ay2       oscil     arose2, ifqc2, 1, .25         ; RECTANGULAR COORDINATES
az2       =         -5*ax2/(ax2*ax2+ay2*ay2+1)    ; COMPUTE THE SURFACE FOR OSCILLATOR 3

adcblkl   butterhp  (az+az1)/2, 20                ; BLOCK DC
adcblkr   butterhp  (az+az2)/2, 20                ; BLOCK DC

          outs      adcblkl*kdclick, adcblkr*kdclick   ; OUTPUT STEREO

          endin

;-----------------------------------------------------------
; Z=-5*X/(X^2+Y^2+1)
; SQUARISH LEAD 2
;-----------------------------------------------------------
          instr     14

idur      =         p3                                 ; DURATION
iamp      =         p4                                 ; AMPLITUDE
ifqc      =         cpspch(p5)                         ; CONVERT PITCH TO FREQUENCY
imodch    =         p6                                 ; CONTROL CHANNEL
ipetal    =         p7                                 ; NUMBER OF PETALS ON THE ROSE CURVE
idetun    =         p8                                 ; DETUNE AMOUNT
ifade     =         p9                                 ; FADE IN AND OUT

ifqc1     =         ifqc*(1+idetun)                    ; ADD SOME CHORUSING
ifqc2     =         ifqc*(1-idetun*.9)                 ; AND STEREO DETUNING

kmod1     zkr       imodch                             ; READ FROM THE MODULATION CONTROL CHANNEL
kdclick   linseg    0, ifade, iamp, idur-2*ifade, iamp, ifade, 0  ; De-Click envelope

arose     oscil     kmod1+1, ipetal*ifqc, 1            ; ROSE CURVE
ax        oscil     arose, ifqc, 1                     ; CONVERT FROM POLAR TO
ay        oscil     arose, ifqc, 1, .25                ; RECTANGULAR COORDINATES
az        =         -5*ax/(ax*ax+ay*ay+1)              ; COMPUTE THE SURFACE FOR OSCILLATOR 1

arose1    oscil     kmod1+1, ipetal*ifqc1, 1           ; ROSE CURVE
ax1       oscil     arose1, ifqc1, 1                   ; CONVERT FROM POLAR TO
ay1       oscil     arose1, ifqc1, 1, .25              ; RECTANGULAR COORDINATES
az1       =         -5*ax1/(ax1*ax1+ay1*ay1+1)         ; COMPUTE THE SURFACE FOR OSCILLATOR 2

arose2    oscil     kmod1+1, ipetal*ifqc2, 1           ; ROSE CURVE
ax2       oscil     arose2, ifqc2, 1                   ; CONVERT FROM POLAR TO
ay2       oscil     arose2, ifqc2, 1, .25              ; RECTANGULAR COORDINATES
az2       =         -5*ax2/(ax2*ax2+ay2*ay2+1)         ; COMPUTE THE SURFACE FOR OSCILLATOR 3

adcblkl   butterhp  (az+az1)/2, 20                     ; BLOCK DC
adcblkr   butterhp  (az+az2)/2, 20                     ; BLOCK DC

          outs      adcblkl*kdclick, adcblkr*kdclick   ; OUTPUT STEREO

          endin

;-----------------------------------------------------------
; TERRAIN MAPPED BASS
; z=sqrt(x^4+y^4-x^2-y^2-x^2Y^2+1)
;-----------------------------------------------------------
          instr     19

idur      =         p3                                 ; DURATION
iamp      =         p4                                 ; AMPLITUDE
aamp1     init      iamp                               ; USED TO BALANCE THE SIGNAL
ifqc      =         cpspch(p5)                         ; CONVERT PITCH TO FREQUENCY
ikch1     =         p6                                 ; INPUT CONTROL 1
ikch2     =         p7                                 ; INPUT CONTROL 2
ibndtab   =         p8                                 ; PITCH BEND TABLE

kamp      linseg    0, .01, 2, .1, 1.5, idur-.21, 1, .1, 0       ; AMP ENVELOPE

krad1     zkr       ikch1                              ; READ IN RADIUS 1
krad2     zkr       ikch2                              ; READ IN RADIUS 2

kbend     oscil      1, 1/idur, ibndtab                 ; PITCH BEND
kfqc      =         kbend*ifqc                         ; ADJUST FREQUENCY BY PITCH BEND

asin1     oscil     krad1, kfqc, 1                     ; Y COMPONENT OF CIRCLE RADIUS 1 
acos1     oscil     krad1, kfqc, 1, .25                ; X COMPONENT OF CIRCLE RADIUS 1
asin2     oscil     krad2, kfqc, 1, .5                 ; Y COMPONENT OF CIRCLE RADIUS 2
acos2     oscil     krad2, kfqc, 1, .75                ; X COMPONENT OF CIRCLE RADIUS 2

ax1       =         asin1+.35                          ; OFFSET THE CIRCLE CENTERS A BIT
ay1       =         acos1-.80                          ; SO THE WAVES ARE ASSYMMETRICAL.
ax2       =         asin2+.5
ay2       =         acos2-.20

axsq1     =         ax1*ax1                            ; COMPUTE X^2 AND Y^2 IN ADVANCE
aysq1     =         ay1*ay1                            ; TO SAVE TIME.
axsq2     =         ax2*ax2
aysq2     =         ay2*ay2

; COMPUTE THE SURFACE
az1       =         sqrt(axsq1*axsq1+aysq1*aysq1-axsq1-aysq1-axsq1*aysq1+1)
az2       =         sqrt(axsq2*axsq2+aysq2*aysq2-axsq2-aysq2-axsq2*aysq2+1)

abal1     balance   az1, aamp1                         ; BALANCE THE SIGNAL
abal2     balance   az2, aamp1                         ; BALANCE THE SIGNAL

aout1     butterhp  abal1, 10                          ; DC BLOCKING FILTER
aout2     butterhp  abal2, 10                          ; DC BLOCKING FILTER

          outs      aout1*kamp, aout2*kamp             ; STEREO OUTPUT

          endin

;-----------------------------------------------------------
; PULSAR
; z=sqrt((1-x^2)*((1-y)+y*cos(1/x)))
;-----------------------------------------------------------
          instr     8

idur      =         p3                                 ; DURATION
iamp      =         p4                                 ; AMPLITUDE
ifqc      =         p5                                 ; FREQUENCY
imodch    =         p6                                 ; MODULATION CHANNEL
ipantab   =         p7                                 ; PANNER TABLE
iamptab   =         p8                                 ; FADER TABLE

kmod      zkr       imodch                             ; READ THE MODULATION
kpan      oscili    1, 1/idur, ipantab                 ; PANNER
kpanl     =         sqrt(kpan)                         ; PAN LEFT
kpanr     =         sqrt(1-kpan)                       ; PAN RIGHT
kamp      oscili    iamp, 1/idur, iamptab              ; AMPLITUDE FADER
ka        =         .01+kmod                           ; CARDIOID A
kb        =         .1+kmod*.2                         ; CARDIOID B

acardi    oscil     kb, ifqc, 1                        ; CARDIOID CURVE
ax1       oscil     ka+acardi, ifqc, 1                 ; CONVERT FROM POLAR TO
ax        =         ax1
ay        oscil     ka+acardi, ifqc, 1, .25            ; RECTANGULAR COORDINATES
az        =         sqrt((1-ax*ax)*((1-ay)+ay*cos(1/(ax*ax+.01))))-1       ; COMPUTE THE SURFACE

aout      butterhp  az, 20                             ; REMOVE DC
          outs      aout*kamp*kpanl, aout*kamp*kpanr   ; OUTPUT STEREO WITH PANNING AND FADING

          endin

;-----------------------------------------------------------
; 4 SPACE PLANAR ROTATIONS
;-----------------------------------------------------------
          instr     51

ifqc      =         p4                                 ; FREQUENCY
iphase    =         p5                                 ; PHASE OFFSET
iplane    =         p6                                 ; PLANE NUMBER
inx       =         p7                                 ; INPUT FOR X COORDINATE
iny       =         p8                                 ; INPUT FOR Y COORDINATE
inz       =         p9                                 ; INPUT FOR Z COORDINATE
inw       =         p10                                ; INPUT FOR W COORDINATE
ioutx     =         p11                                ; OUTPUT FOR X COORDINATE
iouty     =         p12                                ; OUTPUT FOR Y COORDINATE
ioutz     =         p13                                ; OUTPUT FOR Z COORDINATE
ioutw     =         p14                                ; OUTPUT FOR W COORDINATE

kcost     oscil     1, ifqc,   1, .25+iphase           ; COSINE
ksint     oscil     1, ifqc,   1, iphase               ; SINE

ax        zar       inx                                ; READ IN AUDIO CHANNELS X, Y, Z AND W
ay        zar       iny
az        zar       inz
aw        zar       inw

; ROTATION IN X-Y PLANE
  if (iplane!=1)    goto next1
    axr   =         ax*kcost + ay*ksint
    ayr   =         -ax*ksint + ay*kcost
    azr   =         az
    awr   =         aw
    goto  nextend

; ROTATION IN X-Z PLANE
next1:
  if (iplane!=2)    goto next2
    axr   =         ax*kcost + az*ksint
    ayr   =         ay
    azr   =         -ax*ksint + az*kcost
    awr   =         aw
    goto  nextend

; ROTATION IN Y-Z PLANE
next2:
  if (iplane!=3)    goto next3
    axr   =         ax
    ayr   =         ay*kcost + az*ksint
    azr   =         -ay*ksint + az*kcost
    awr   =         aw
    goto  nextend

; ROTATION IN X-W PLANE
next3:
  if (iplane!=4)    goto next4
    axr   =         ax*kcost + aw*ksint
    ayr   =         ay
    azr   =         az
    awr   =         -ax*ksint + aw*kcost
    goto   nextend

; ROTATION IN Y-W PLANE
next4:
  if (iplane!=5)    goto next5
    axr   =         ax
    ayr   =         ay*kcost + aw*ksint
    azr   =         az
    awr   =         -ay*ksint + aw*kcost
    goto  nextend

; ROTATION IN Z-W PLANE
next5:
  if (iplane!=6)    goto nextend
    axr   =         ax
    ayr   =         ay
    azr   =         az*kcost + aw*ksint
    awr   =         -az*ksint + aw*kcost

nextend:
          zaw       axr, ioutx                         ; Output audio X, Y, Z and W
          zaw       ayr, iouty
          zaw       azr, ioutz
          zaw       awr, ioutw

endin

;---------------------------------------------------------------------------
; Mixer Section
;---------------------------------------------------------------------------
          instr     95

idur      =         p3                                 ; Duration
iamp      =         p4                                 ; Amplitude
ifadtab   =         p5                                 ; Fader Table
iinch     =         p6                                 ; Input Channel
ipantab   =         p7                                 ; Panner Table

ain1      zar       iinch                              ; Read audio input channel

kamp      oscili    iamp, 1/idur, ifadtab              ; Fader
kpan      oscili    1, 1/idur, ipantab                 ; Panner
kpanl     =         sqrt(kpan)                         ; Pan Left
kpanr     =         sqrt(1-kpan)                       ; Pan Right
          outs      ain1*kamp*kpanl, ain1*kamp*kpanr   ; Output stereo with fader and panner

          endin

;---------------------------------------------------------------------------
; CLEAR AUDIO & CONTROL CHANNELS
;---------------------------------------------------------------------------
          instr     99

          zacl      0, 50                              ; CLEAR AUDIO CHANNELS 0 TO 30
          zkcl      0, 50                              ; CLEAR CONTROL CHANNELS 0 TO 30

          endin
