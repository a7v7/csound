;------------------------------------------------------------------------------
; HEAVY GUITAR BY HANS MIKELSON
;------------------------------------------------------------------------------
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
zakinit   50, 50


;------------------------------------------------------------------------------
; PLUCKED INSTRUMENT
;------------------------------------------------------------------------------
        instr   1

idur      =         p3                                 ; DURATION
iamp      =         p4                                 ; AMPLITUDE
ipch      =         cpspch(p5)                         ; PITCH
itab1     =         p6
ioutch    =         p7                                 ; OUT CHANNEL

asig      pluck     iamp, ipch, ipch, itab1, 1         ; GENERATE A PLUCKED TONE
          zawm      asig, ioutch                       ; MIX TO THE ZAK CHANNEL

          endin

;------------------------------------------------------------------------------
; DISTORTION
;------------------------------------------------------------------------------
          instr     10

idur      =         p3
kpregn    =         p4/1000                          ; PREGAIN/OVERDRIVE
kpostg    =         p5*20000                         ; POSTGAIN/VOLUME
ka1       =         (p6-.5)/8000                     ; SHAPE 1 0=FLAT
ka2       =         (p7-.5)/8000                     ; SHAPE 2
iinch     =         p8                               ; INPUT CHANNEL
ioutch    =         p9                               ; OUTPUT CHANNEL
ioutlvl   =         p10                              ; OUTPUT LEVEL
                    
kdclick   linseg    0, .002, 1, idur-.004, 1, .002, 0  ; DECLICK ENVELOPE

asig      zar       iinch

ax1       =         asig*(kpregn+ka1)                ; PRECALCULATE A FEW VALUES TO SAVE TIME
ax2       =         -asig*(kpregn+ka2)
ax3       =         asig*kpregn

aout      =         (exp(ax1)-exp(ax2))/(exp(ax3)+exp(-ax3))*kpostg  ; MODIFIED TANH DISTORTION

          zaw       aout*kdclick, ioutch         ; OUTPUT THE RESULT
          outs      aout*kdclick*ioutlvl, aout*kdclick*ioutlvl   ; OUTPUT THE RESULT

          endin

;---------------------------------------------------------------------------
; WAH-WAH
;---------------------------------------------------------------------------
          instr     16

irate     =         p4                ; AUTO WAH RATE
idepth    =         p5                ; LOW PASS DEPTH
ilow      =         p6                ; MINIMUM FREQUENCY
ifmix     =         p7/1000           ; FORMANT MIX
itab1     =         p8                ; WAVE FORM TABLE
izin      =         p9                ; INPUT CHANNEL
     
kosc1     oscil     .5, irate, itab1, .25        ; OSCILATOR
kosc2     =         kosc1 + .5                   ; RESCALE FOR 0-1
kosc3     =         kosc2                        ; FORMANT DEPTH 0-1
     
klopass   =         idepth*kosc2+ilow            ; LOW PASS FILTER RANGE
kform1    =         430*kosc2 + 300              ; FORMANT 1 RANGE
kamp1     =         ampdb(-2*kosc3 + 59)*ifmix   ; FORMANT 1 LEVEL
kform2    =         220*kosc2 + 870              ; FORMANT 2 RANGE
kamp2     =         ampdb(-14*kosc3 + 55)*ifmix  ; FORMANT 2 LEVEL
kform3    =         200*kosc2 + 2240             ; FORMANT 3 RANGE
kamp3     =         ampdb(-15*kosc3 + 32)*ifmix  ; FORMANT 3 LEVEL

asig      zar       izin                       ; READ INPUT CHANNEL

afilt     butterlp  asig, klopass               ; LOW PASS FILTER

ares1     reson     afilt, kform1, kform1/8     ; COMPUTE SOME FORMANTS
ares2     reson     afilt, kform2, kform1/8     ; TO ADD CHARACTER TO THE
ares3     reson     afilt, kform3, kform1/8     ; SOUND

aresbal1  balance   ares1, afilt                ; ADJUST FORMANT LEVELS
aresbal2  balance   ares2, afilt
aresbal3  balance   ares3, afilt

aout      =         afilt+kamp1*aresbal1+kamp2*aresbal2+kamp3*aresbal3

          outs      aout, aout

          endin

;------------------------------------------------------------------------------
; CLEAR ZAK
;------------------------------------------------------------------------------
          instr     99
          zacl      0, 50
          zkcl      0, 50
          endin
