
;---------------------------------------------------------------------------
; MIKELSON'S MULTI-FX SYSTEM
;---------------------------------------------------------------------------
; THIS ORCHESTRA IS DESIGNED AS A MULTI EFFECTS UNIT AND MIXER.
; IT CAN BE USED AS A GUITAR SIMULATOR USING THE PLUCK ALGORITHM OR TO
; PROCESS EXISTING DIGITAL AUDIO FILES.
;---------------------------------------------------------------------------
; 3401. SIMPLE SINE WAVE
; 3402. PLUCK
; 3404. NOISE
; 3409. ENHANCER
; 3410. NOISE GATE
; 3411. COMPRESSOR/LIMITER/EXPANDER
; 3412. DE-ESSER
; 3413. TUBE AMP DISTORTION
; 3414. FEEDBACK GENERATOR
; 3415. LOW PASS RESONANT FILTER
; 3416. WAH-WAH
; 3417. TALK-BOX
; 3418. 3 BAND EQUALIZER
; 3419. RESONATOR
; 3420. VIBRATO
; 3421. TREMELO
; 3422. PITCH SHIFTER
; 3423. PANNER
; 3424. RING MODULATOR
; 3426. DISTORTION FEEDBACK
; 3430. FLANGER
; 3435. CHORUS
; 3437. PHASOR

; 3440. STEREO DELAY
; 3445. REVERB
; 3450. SUBMIX
; 3499. MIX
;---------------------------------------------------------------------------
sr        =         44100
kr        =         22050
ksmps     =         2
nchnls    =         2
;---------------------------------------------------------------------------
          zakinit   30, 30
;---------------------------------------------------------------------------
; Sound Sources
;---------------------------------------------------------------------------
; Simple Sine Wave Generator
;---------------------------------------------------------------------------
          instr     3401
iamp      init      p4
ifqc      init      p5
izout     init      p6
kamp      linseg    0, .002, p4, p3-.004, p4, .002, 0                 ; Declick
asin1     oscil     kamp, ifqc, 1                                     ; Sine oscillator
          zawm      asin1, izout                                      ; Mix to zak channel
          endin
;---------------------------------------------------------------------------
; Pluck Physical Model
;---------------------------------------------------------------------------
          instr     3402
iamp      =         p4                                                ; Amplitude
ifqc      =         cpspch(p5)                                        ; Convert to frequency
itab1     =         p6                                                ; Initial table
imeth     =         p7                                                ; Decay method
ioutch    =         p8                                                ; Output channel
kamp      linseg    0, .002, iamp, p3-.004, iamp, .002, 0             ; Declick
aplk      pluck     kamp, ifqc, ifqc, itab1, imeth                    ; Pluck waveguide model
          zawm      aplk, ioutch                                      ; Write to output
gifqc     =         ifqc
          endin
;---------------------------------------------------------------------------
; Noise
;---------------------------------------------------------------------------
          instr     3404
iamp      init      p4
izout     init      p5
kamp      linseg    0, .002, p4, p3-.004, p4, .002, 0
arnd1     rand      kamp                                              ; Random generator
afilt     tone      arnd1, 1000                                       ; Low pass filter
          zawm      afilt, izout                                      ; Mix to zak channel
          endin
;---------------------------------------------------------------------------
; Effects Section
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
; Enhancer
;---------------------------------------------------------------------------
          instr     3409
ilogain   =         p4                                                ; Low Gain
imidgain  =         p5                                                ; Midrange Gain
ihigain   =         p6                                                ; High Gain
ilofco    =         p7                                                ; Low frequency cut-off
ihifco    =         p8                                                ; High frequency cut-off
iloshft   =         p9/1000                                           ; Low phase shift
imidshft  =         p10/1000                                          ; Mid phase shift
ihishft   =         p11/1000                                          ; High phase shift
izin      =         p12                                               ; Input channel
izout     =         p13                                               ; Output channel
asig      zar       izin                                              ; Read from input channel
alosig    butterlp  asig, ilofco+ilofco/4                             ; Low pass filter overlap a bit
atmpsig   butterhp  asig, ilofco-ilofco/4                             ; High pass at low frequency cut-off
amidsig   butterlp  atmpsig, ihifco+ihifco/4                          ; then low pass at high frequency cut-off
ahisig    butterhp  asig, ihifco-ihifco/4                             ; Hi pass filter
alodel    delayr    iloshft                                           ; Low frequency delay
          delayw    alosig
amiddel   delayr    imidshft                                          ; Midrange delay
          delayw    amidsig
ahidel    delayr    ihishft                                           ; High frequency delay
          delayw    ahisig
aout      =         ilogain*alodel+imidgain*amiddel+ihigain*ahidel    ; Apply gain and reconstruct signal
          zaw       aout, izout                                       ; Write to output channel
          endin
;---------------------------------------------------------------------------
; Noise Gate
;---------------------------------------------------------------------------
          instr     3410

ifqc      =         1/p4                                              ; RMS calculation frequency
ideltm    =         p5                                                ; Delay time to open gate just before signal start
itab      =         p6                                                ; Noise gate table
ipostgain =         p7                                                ; Post gain
iinch     =         p8                                                ; Input channel
ioutch    =         p9                                                ; Output channel

kenv      linseg    0, .02, 1, p3-.04, 1, .02, 0                      ; Declick envelope

asig      zar       iinch                                             ; Read from input channel

adel1     delayr    ideltm                                            ; Delay the signal
           delayw   asig

kamp      rms       adel1, ifqc                                       ; Calculate RMS on the delayed signal
kampn     =         kamp/30000                                        ; Normalize to 0-1
kcomp     tablei    kampn,itab,1,0                                    ; Reference the noise gate table
acomp     =         kcomp*asig*ipostgain                              ; Apply noise gate to original signal
          zaw       acomp*kenv, ioutch                                ; Declick and write to the output channel 
          endin
;---------------------------------------------------------------------------
; Compressor/Limiter
;---------------------------------------------------------------------------
          instr     3411
ifqc      =         1/p4                                              ; RMS calculation frequency
ideltm    =         p5                                                ; Delay time to apply compression to initial dynamics
itab      =         p6                                                ; Compressor/limiter table
ipostgain =         p7                                                ; Post gain
iinch     =         p8                                                ; Input Channel
ioutch    =         p9                                                ; Output Channel
kenv      linseg    0, .02, 1, p3-.04, 1, .02, 0                      ; Amp envelope to declick.
asig      zar       iinch                                             ; Read input channel
kamp      rms       asig, ifqc                                        ; Find rms level
kampn     =         kamp/30000                                        ; Normalize rms level 0-1.
kcomp     tablei    kampn,itab,1,0                                    ; Look up compression value in table
adel1     delayr    ideltm                                            ; Delay for the input delay time, 1/ifqc/2 is typical
          delayw    asig                                              ; Write to delay line
acomp     =         kcomp*adel1*ipostgain                             ; Compress the delayed signal and post gain,
          zaw       acomp*kenv, ioutch                                ; declick and write to output channel
          endin
;---------------------------------------------------------------------------
; De-Esser
;---------------------------------------------------------------------------
          instr     3412
ifqc      =         1/p4                                              ; RMS calculation frequency
ideltm    =         p5                                                ; Delay time is usually 1/fqc/2
itab      =         p6                                                ; De-Ess table
ifco      =         p7                                                ; Cut off frequency
ipostgain =         p8                                                ; Post gain
iinch     =         p9                                                ; Input channel
ioutch    =         p10                                               ; Output channel
kenv      linseg    0, .02, 1, p3-.04, 1, .02, 0                      ; Declick envelope
asig      zar       iinch                                             ; Read input channel
afilt     butterhp  asig, ifco                                        ; High pass filter the signal
kamp      rms       afilt, ifqc                                       ; Calculate rms on the high pass signal
kampn     =         kamp/30000                                        ; Normalize rms 0-1
kcomp     tablei    kampn,itab,1,0                                    ; Look up de-esser value in table
adel1     delayr    ideltm                                            ; Delay signal for delay time
          delayw    asig
acomp     =         kcomp*adel1*ipostgain                             ; Apply de-ess and post gain
          zaw       acomp*kenv, ioutch                                ; Declick and write to output channel
          endin
;---------------------------------------------------------------------------
; Distortion
;---------------------------------------------------------------------------
          instr     3413
igaini    =         p4                                                ; Pre gain
igainf    =         p5                                                ; Post gain
iduty     =         p6                                                ; Duty cycle offset
islope    =         p7                                                ; Slope offset
izin      =         p8                                                ; Input channel
izout     =         p9                                                ; Output channel
asign     init      0                                                 ; Delayed signal
kamp      linseg    0, .002, 1, p3-.004, 1, .002, 0                   ; Declick
asig      zar       izin                                              ; Read input channel
aold      =         asign                                             ; Save the last signal
asign     =         igaini*asig/60000                                 ; Normalize the signal
aclip     tablei    asign,5,1,.5                                      ; Read the waveshaping table
aclip     =         igainf*aclip*15000                                ; Re-amplify the signal
atemp     delayr    .1                                                ; Amplitude and slope based delay
aout      deltapi   (2-iduty*asign)/1500 + islope*(asign-aold)/300
          delayw    aclip
          zaw       aout, izout                                       ; Write to output channel
          endin
;---------------------------------------------------------------------------
; Distortion Feedback Generator
;---------------------------------------------------------------------------
          instr     3414
igaini    =         p4                                                ; Pre Gain
igainf    =         p5                                                ; Post Gain
iduty     =         p6                                                ; Duty cycle shift
itabd     =         p7                                                ; Distortion table
iresfqc   =         p8                                                ; Resonance frequency
ideltim   =         p9                                                ; Feedback delay time
ifeedbk   =         p10                                               ; Feedback gain
itabc     =         p11                                               ; Limiter table
izin      =         p12                                               ; Input channel
izout     =         p13                                               ; Output channel
asign     init      0                                                 ; Initialize last value
kdclick   linseg    0, .1, 1, p3-.3, 1, .2, 0                         ; Ramp feedback in and out
kamp      linseg    0, .002, 1, p3-.004, 1, .002, 0                   ; Declick
asig      zar       izin                                              ; Read input channel
afdbk     =         asig/100                                          ; Reduce original signal
adel1     delayr    ideltim                                           ; Feed back delay
afilt     butterbp  adel1, iresfqc, iresfqc/4                         ; Filter the delayed signal
kamprms   rms       afilt                                             ; Find rms level
kampn     =         kamprms/30000                                     ; Normalize rms level 0-1.
kcomp     tablei    kampn,itabc,1,0                                   ; Look up compression value in table
          delayw    afdbk+kcomp*ifeedbk*afilt                         ; Add limited feedback
aold      =         asign                                             ; Save the old value
asign     =         (afilt*kdclick)/60000                             ; Normalize
aclip     tablei    asign,itabd,1,.5                                  ; Waveshape with distortion table
aclip     =         igainf*aclip*15000                                ; Rescale
atemp     delayr    .1                                                ; Amplitude based delays
aout      deltapi   (2-iduty*asign)/1500 + iduty*(asign-aold)/300
          delayw    aclip
          zaw       aout, izout                                       ; Write to the output channels
          endin
;---------------------------------------------------------------------------
; Low Pass Resonant Filter
;---------------------------------------------------------------------------
          instr     3415
idur      =         p3
itab1     =         p4                                                ; Cut-Off Frequency
itab2     =         p5                                                ; Resonance
ilpmix    =         p6                                                ; Low-Pass signal multiplier
irzmix    =         p7                                                ; Resonance signal multiplier
izin      =         p8                                                ; Input channel
izout     =         p9                                                ; Output channel
kfco      oscil     1,1/idur,itab1                                    ; Cut-off Frequency envelope from table
kfcort    =         sqrt(kfco)                                        ; Needed for the filter
krezo     oscil     1,1/idur,itab2                                    ; Resonance envelope from table
krez      =         krezo*kfco/500                                    ; Add more resonance at high Fco
kamp      linseg    0, .002, 1, p3-.004, 1, .002, 0                   ; Declick
axn       zar       izin                                              ; Read input channel
ka1       =         1000/krez/kfco-1                                  ; Compute filter coeff. a1
ka2       =         100000/kfco/kfco                                  ; Compute filter coeff. a2
kb        =         1+ka1+ka2                                         ; Compute filter coeff. b
ay1       nlfilt    axn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1          ; Use the non-linear filter
ay        nlfilt    ay1/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1          ; as an ordinary filter.
ka1lp     =         1000/kfco-1                                       ; Resonance of 1 is a low pass filter
ka2lp     =         100000/kfco/kfco
kblp      =         1+ka1lp+ka2lp
ay1lp     nlfilt    axn/kblp, (ka1lp+2*ka2lp)/kblp, -ka2lp/kblp, 0, 0, 1        ; Low-pass filter
aylp      nlfilt    ay1lp/kblp, (ka1lp+2*ka2lp)/kblp, -ka2lp/kblp, 0, 0, 1
ayrez     =         ay - aylp                                                   ; Extract the resonance part.
ayrz      =         ayrez/kfco                                                  ; Use lower amplitudes at higher Fco
ay2       =         aylp*6*ilpmix + ayrz*300*irzmix                             ; Scale the low pass and resonance separately
          zaw       ay2, izout                                                  ; Write to the output channel
          endin
;---------------------------------------------------------------------------
; Wah-Wah
;---------------------------------------------------------------------------
          instr     3416
irate     =         p4                                                          ; Auto Wah Rate
idepth    =         p5                                                          ; Low Pass Depth
ilow      =         p6                                                          ; Minimum Frequency
ifmix     =         p7/1000                                                     ; Formant Mix
itab1     =         p8                                                          ; Wave form table
izin      =         p9                                                          ; Input Channel
izout     =         p10                                                         ; Output Channel
kosc1     oscil     .5, irate, itab1, .25                                       ; Oscilator
kosc2     =         kosc1 + .5                                                  ; Rescale for 0-1
kosc3     =         kosc2                                                       ; Formant Depth 0-1
klopass   =         idepth*kosc2+ilow                                           ; Low pass filter range
kform1    =         430*kosc2 + 300                                             ; Formant 1 range
kamp1     =         ampdb(-2*kosc3 + 59)*ifmix                                  ; Formant 1 level
kform2    =         220*kosc2 + 870                                             ; Formant 2 range
kamp2     =         ampdb(-14*kosc3 + 55)*ifmix                                 ; Formant 2 level
kform3    =         200*kosc2 + 2240                                            ; Formant 3 range
kamp3     =         ampdb(-15*kosc3 + 32)*ifmix                                 ; Formant 3 level
asig      zar       izin                                                        ; Read input channel
afilt     butterlp  asig, klopass                                               ; Low pass filter
ares1     reson     afilt, kform1, kform1/8                                     ; Compute some formants
ares2     reson     afilt, kform2, kform1/8                                     ; to add character to the
ares3     reson     afilt, kform3, kform1/8                                     ; sound
aresbal1  balance   ares1, afilt                                                ; Adjust formant levels
aresbal2  balance   ares2, afilt
aresbal3  balance   ares3, afilt
          zaw       afilt+kamp1*aresbal1+kamp2*aresbal2+kamp3*aresbal3, izout
          endin
;---------------------------------------------------------------------------
; Talk-Box
;---------------------------------------------------------------------------
          instr     3417
idur      =         p3                                                          ; Duration
ixtab     =         p4                                                          ; Index table
ifrmtab   =         p5                                                          ; Formant table
iamptab   =         p6                                                          ; Formant amplitude table
izin      =         p7                                                          ; Input channel
izout     =         p8                                                          ; Output channel
iptime    =         idur/128                                                    ; Time to slide half way to next formant set
kdeclick  linseg    1, p3-.002, 1, .002, 0                                      ; Declick
kformi    oscil     1, 1/idur, ixtab                                            ; Read the formant index table
kform1    table     3*kformi,   ifrmtab                                         ; Read the first formant frequency
kdb1      table     3*kformi, ifrmtab                                           ; Read the first formant dB's
kamp1     =         dbamp(60+kdb1)/200                                          ; Convert from decibels to amplitude
kform2    table     3*kformi+1, ifrmtab                                         ; Read the second formant frequency
kdb2      table     3*kformi+1, ifrmtab                                         ; Read the second formant dB's
kamp2     =         dbamp(60+kdb2)/200                                          ; Convert dB to amp
kform3    table     3*kformi+2, ifrmtab                                         ; Read the third formant frequency
kdb3      table     3*kformi+2, ifrmtab                                         ; Read the third formnat dB's
kamp3     =         dbamp(60+kdb3)/200                                          ; Convert dB to amp
kfrm1p    port      kform1, iptime, 300                                         ; Portamento to the next formant
kamp1p    port      kamp1,    iptime, .15                                       ; Portamento to the next amplitude
kfrm2p    port      kform2, iptime, 2000                                        ; Repeat for second
kamp2p    port      kamp2,    iptime, .15
kfrm3p    port      kform3, iptime, 4000                                        ; and again for the third
kamp3p    port      kamp3,    iptime, .15
asig      zar       izin                                                        ; Output channel
aform1    reson     asig, kfrm1p, kfrm1p/8                                      ; Compute the three resonances
aform2    reson     asig, kfrm2p, kfrm2p/8
aform3    reson     asig, kfrm3p, kfrm3p/8
abal1     balance   aform1, asig                                                ; Adjust the levels
abal2     balance   aform2, asig
abal3     balance   aform3, asig
aout      =         abal1*kamp1p+abal2*kamp2p+abal3*kamp3p                      ; Scale and sum
          zaw       aout*kdeclick, izout                                        ; Write to the output channel
          endin
;---------------------------------------------------------------------------
; 3 Band Equalizer
;---------------------------------------------------------------------------
          instr     3418
ilogain   =         p4                                                          ; Low Gain
imidgain  =         p5*1.2                                                      ; Midrange Gain
ihigain   =         p6                                                          ; High Gain
ilofco    =         p7                                                          ; Low frequency cut-off
ihifco    =         p8                                                          ; High frequency cut-off
izin      =         p9                                                          ; Input channel
izout     =         p10                                                         ; Output channel
asig      zar       izin                                                        ; Read from input channel
alosig    butterlp  asig, ilofco                                                ; Low pass filter
atmpsig   butterhp  asig, ilofco-ilofco/4                                       ; High pass at low frequency cut-off
amidsig   butterlp  atmpsig, ihifco+ihifco/4                                    ; then low pass at high frequency cut-off
ahisig    butterhp  asig, ihifco                                                ; Hi pass filter
aout      =         ilogain*alosig+imidgain*amidsig+ihigain*ahisig              ; Apply gain and reconstruct signal
          zaw       aout, izout                                                 ; Write to output channel
          endin
;---------------------------------------------------------------------------
; Resonator
;---------------------------------------------------------------------------
          instr     3419
itabres   =         p4                                                          ; Resonance table
itabdb    =         p5                                                          ; Amplitude table
izin      =         p6                                                          ; Input channel
izout     =         p7                                                          ; Output channel
ires1     table     1, itabres                                                  ; Read the four resonance frequencies
ires2     table     2, itabres                                                  ; from the table.
ires3     table     3, itabres
ires4     table     4, itabres
idb1      table     1, itabdb                                                   ; Read the amplitudes from the table
idb2      table     2, itabdb
idb3      table     3, itabdb
idb4      table     4, itabdb
iamp1     =         dbamp(idb1)/300                                             ; Convert dB to amplitude
iamp2     =         dbamp(idb2)/300
iamp3     =         dbamp(idb3)/300
iamp4     =         dbamp(idb4)/300
asig      zar       izin                                                        ; Read from input channel
ares1     reson     asig, ires1, ires1/8                                        ; Filter the resonances
ares2     reson     asig, ires2, ires2/8
ares3     reson     asig, ires3, ires3/8
ares4     reson     asig, ires4, ires4/8
abal1     balance   ares1, asig                                                 ; Balance the resonances
abal2     balance   ares2, asig                                                 ; Scale each and output
abal3     balance   ares3, asig
abal4     balance   ares4, asig
          zaw       iamp1*abal1+iamp2*abal2+iamp3*abal3+iamp4*abal4, izout
          endin
;---------------------------------------------------------------------------
; Vibrato
;---------------------------------------------------------------------------
          instr     3420
iamp      =         p4/1000                                                     ; Vibrato amplitude
ifqc      =         p5                                                          ; Vibrato frequency
itab1     =         p6                                                          ; Wave shape
iphase    =         p7                                                          ; Phase shift
idelay    =         p8                                                          ; Delay time before vibrato begins
irmptim   =         p9                                                          ; Ramp time for vibrato
izin      =         p10                                                         ; Input channel
izout     =         p11                                                         ; Output channel
asig      zar       izin                                                        ; Read input channel
kramp     linseg    0, idelay, 0, irmptim, 1, p3-idelay-irmptim, 1              ; Delay and ramp vibrato
kosc      oscil     kramp*iamp, ifqc, itab1                                     ; Low frequency oscillator
atmp      delayr    3*iamp                                                      ; Delay the signal
aout      deltapi   kosc+1.5*iamp                                               ; Variable delay tap
          delayw    asig
          zaw       aout,izout                                                  ; Write to the output channel
          endin
;---------------------------------------------------------------------------
; Tremelo
;---------------------------------------------------------------------------
          instr     3421
iamp      =         p4
ifqc      =         p5
itab1     =         p6
iphase    =         p7
izin      =         p8
izout     =         p9
asig      zar       izin
kosc      oscil     iamp, ifqc, itab1, iphase
aout      =         asig*(kosc+1)/2
          zaw       aout, izout
          endin
;---------------------------------------------------------------------------
; Pitch Shifter
;---------------------------------------------------------------------------
          instr     3422
;ipshift  =         p4
ipshift   =         (p4<=1 ? p4-1 : p4/2)
itab1     =         p5
izin      =         p6
izout     =         p7
asig      zar       izin
kosc      oscil     1/gifqc, gifqc*ipshift, itab1
atmp      delayr    .1
aout      deltapi   kosc+1/gifqc
          delayw    asig
          zaw       aout,izout
          endin
;---------------------------------------------------------------------------
; Panner
;---------------------------------------------------------------------------
          instr     3423
iamp      =         p4
ifqc      =         p5
itab1     =         p6
iphase    =         p7
izin      =         p8
izoutl    =         p9
izoutr    =         p10
asig      zar       izin
kosc      oscil     iamp, ifqc, itab1, iphase
kpanl     =         (kosc+1)/2
kpanr     =         1-kpanl
aoutl     =         asig*kpanl
aoutr     =         asig*kpanr
          zaw       aoutl, izoutl
          zaw       aoutr, izoutr
          endin
;---------------------------------------------------------------------------
; Ring Modulator
;---------------------------------------------------------------------------
          instr     3424
izin1     =         p4
izin2     =         p5
izout     =         p6
asig1     zar       izin1
asig2     zar       izin2
armod     =         asig1*asig2
aout      balance   armod, (asig1+asig2)/2
          zaw       aout, izout
          endin
;---------------------------------------------------------------------------
; Flanger
;---------------------------------------------------------------------------
          instr     3430
irate     =         p4
idepth    =         p5/1000
iwave     =         p6
ifdbk     =         p7
imix      =         p8
ideloff   =         p9/1000
iphase    =         p10
izin      =         p11
izout     =         p12
adel1     init      0
kamp      linseg    0, .002, 1, p3-.004, 1, .002, 0
asig      zar       izin
asig1     =         asig+ifdbk*adel1
aosc1     oscil     idepth, irate, iwave, iphase
aosc2     =         aosc1+ideloff
atemp     delayr    idepth+ideloff
adel1     deltapi   aosc2
          delayw    asig1
aout      =         (imix*adel1+asig)/2
          zaw       aout, izout
          endin
;---------------------------------------------------------------------------
; Chorus
;---------------------------------------------------------------------------
          instr     3435
irate     =         p4
idepth    =         p5/1000
iwave     =         p6
imix      =         p7
ideloff   =         p8/1000
iphase    =         p9
izin      =         p10
izout     =         p11
kamp      linseg    0, .002, 1, p3-.004, 1, .002, 0
asig      zar       izin
aosc1     oscil     idepth, irate, iwave, iphase
aosc2     =         aosc1+ideloff
atemp     delayr    idepth+ideloff
adel1     deltapi   aosc2
          delayw    asig
aout      =         (adel1*imix+asig)/2*kamp
          zaw       aout, izout
          endin
;---------------------------------------------------------------------------
; Phasor
;---------------------------------------------------------------------------
          instr     3437
irate     =         p4
idepth    =         p5/1000
iwave     =         p6
ifdbk     =         p7
imix      =         p8
ideloff   =         p9/1000
iphase    =         p10
izin      =         p11
izout     =         p12
aout      init      0
kamp      linseg    0, .002, 1, p3-.004, 1, .002, 0
asig      zar       izin
asig1     =         asig+ifdbk*aout
kosc1     oscil     idepth, irate, iwave, iphase
kosc2     =         kosc1+ideloff
atemp     delayr    idepth+ideloff
adel1     deltapi   kosc2
          delayw    asig1
aout      =         adel1-ifdbk*asig
          zaw       aout/2, izout
          endin
;---------------------------------------------------------------------------
; Delay
;---------------------------------------------------------------------------
          instr     3440
itim1     =         p4
ifdbk1    =         p5
ixfdbk1   =         p6
itim2     =         p7
ifdbk2    =         p8
ixfdbk2   =         p9
izinl     =         p10
izinr     =         p11
izoutl    =         p12
izoutr    =         p13
aoutl     init      0
aoutr     init      0
asigl     zar       izinl
asigr     zar       izinr
aoutl     delayr    itim1
          delayw    asigl+ifdbk1*aoutl+ixfdbk1*aoutr                  ; Sum delayed signal with
                                                                      ; with original and add 
aoutr     delayr    itim2                                             ; cross-feedback signal.
          delayw    asigr+ifdbk2*aoutr+ixfdbk2*aoutl
          zaw       aoutl, izoutl
          zaw       aoutr, izoutr
          endin
;---------------------------------------------------------------------------
; Reverb
;---------------------------------------------------------------------------
          instr     3445
irvtime   =         p4
irvfqc    =         p5
izin      =         p6
izout     =         p7
asig      zar       izin
aout      nreverb   asig, irvtime, irvfqc
          zaw       aout/5, izout
          endin
;---------------------------------------------------------------------------
; Submix
;---------------------------------------------------------------------------
          instr     3450
izin1     =         p4
igain1    =         p5
izin2     =         p6
igain2    =         p7
izout     =         p8
asig1     zar       izin1
asig2     zar       izin2
          zaw       igain1*asig1+igain2*asig2, izout
          endin
;---------------------------------------------------------------------------
; Mixer
;---------------------------------------------------------------------------
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
;---------------------------------------------------------------------------
          instr     3499 ; Mixer
asig1     zar       p4
igl1      init      p5*p6
igr1      init      p5*(1-p6)
asig2     zar       p7
igl2      init      p8*p9
igr2      init      p8*(1-p9)
asig3     zar       p10
igl3      init      p11*p12
igr3      init      p11*(1-p12)
asig4     zar       p13
igl4      init      p14*p15
igr4      init      p14*(1-p15)
asigl     =         asig1*igl1 + asig2*igl2 + asig3*igl3 + asig4*igl4
asigr     =         asig1*igr1 + asig2*igr2 + asig3*igr3 + asig4*igr4
          outs      asigl, asigr
          zacl      0, 30
          endin
