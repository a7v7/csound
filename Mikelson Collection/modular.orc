;===========================================================================
; THIS INSTRUMENT IS AN ATTEMPT AT SIMULATING A MODULAR SYNTHESIZER.
;===========================================================================
; MODULES
; 1. SIMPLE TRIGGER
; 2. KEYBOARD TRIGGER
; 5. ENVELOPE
; 6. TABLE LFO
;15. VCO
;20. VCF
;25. VCA
;100. MIXER
;110. CHANNEL CLEAR

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

zakinit   30,30

;---------------------------------------------------------------------------
; SIMPLE TRIGGER
;---------------------------------------------------------------------------
         instr  1

idur     init       p3               ; JUST SEND THE DURATION OUT
idurch   init       p4               ; ON THE DURATION CHANNEL

         zkw        idur, idurch

         endin

;---------------------------------------------------------------------------
; KEYBOARD TRIGGER
;---------------------------------------------------------------------------
          instr     2

kdur      init      p3
kamp      init      p4
kfqc      init      cpspch(p5)
idurch    init      p6
iampch    init      p7
ifqcch    init      p8
                         
          zkw       kdur, idurch    ; JUST SEND OUT TRIGGERS FOR DURATION
          zkw       kamp, iampch    ; AMPLITUDE
          zkw       kfqc, ifqcch    ; AND PITCH AS IF SOMEONE HAD HIT A KEYBOARD
     
          endin

;---------------------------------------------------------------------------
; ENVELOPE
;---------------------------------------------------------------------------
          instr     5

idurch    init      p4
iamp      init      p5
itab1     init      p6
iout      init      p7

kdur      zkr       idurch
kenv      oscil     iamp, 1/kdur, itab1      ;ENVELOPE FOR THE DURATION ON THE CHANNEL

          zkw       kenv, iout               ;WRITE TO OUTPUT

          endin

;---------------------------------------------------------------------------
; TABLE LFO
;---------------------------------------------------------------------------
          instr     6
                    
iamp      init      p4
ifqc      init      p5
itab1     init      p6
ioffset   init      p7
iout      init      p8

koscil    oscil     iamp, ifqc, itab1        ;TABLE OSCILLATOR
kout      =         koscil+ioffset

          zkw       kout, iout               ;SEND TO OUTPUT CHANNEL

          endin

;---------------------------------------------------------------------------
; VCO  
; ALLOWS FOR PULSE WIDTH MOD
; SAW RAMP TRANSFORM AND OSCILLATOR SYNC ALL THOUGH NOT QUITE THE SAME TYPE
; OF OSCILLATOR SYNC AS MY MATRIX 6R.
;---------------------------------------------------------------------------
          instr     15   

ifqch     init      p4                       ; FREQUENCY CHANNEL
isynch    init      p5                       ; OSCILLATOR SYNCH CHANNEL
ipwmch    init      p6                       ; PULSE WIDTH MODULATION CHANNEL
ktri      init      -1                       ; INITIALIZE TRIANGLE WAVE GENERATOR
kmax      init      1                        ; USE A SCALE IT TO 1.
kpulse    init      1                        ; INITIALIZE THE PULSE
ksynch    init      -1                       ; INITIALIZE THE SYNCH VALUE
ioutch    init      p7                       ; AUDIO OUTPUT CHANNEL
isyncout  init      p8                       ; SYNCH OUTPUT CHANNEL (k)
ishape    init      p9                       ; SHAPE 0=TRIANGULAR, 1=SQUARE
ipwdth    init      p10                      ; INITIAL PULSE WIDTH -1 TO 1
ifqcadj   init      p11                      ; FREQUENCY MULTIPLIER
kdx       init      -1                       ; DELTA X

koldsync  =         ksynch                   ; SAVE THE OLD VALUE
kfqc      zkr       ifqch                    ; READ NEW VALUES FOR
kfqc      =         kfqc*ifqcadj
ksynch    zkr       isynch                   ; FREQUENCY, SYNCH AND PWM.
kpwmi     zkr       ipwmch

kpwm      =         kpwmi+ipwdth             ; IF THIS EQUALS 1 OR -1 IT WILL CRASH

kfsr      =         4*kfqc/kr                ; CALCULATE FREQUENCY/SAMPLE RATE CONSTANT
kdx1      =         kfsr/(1+kpwm)            ; THAT ALLOWS FOR GOING FROM -1 TO 1 IN 
kdx2      =         kfsr/(1-kpwm)            ; THE RIGHT AMOUNT OF TIME.  LIKEWISE 1 TO -1.
knew      =         ktri+kdx                 ; SUGGEST THE NEXT VALUE AND CHECK IT BELOW
                                             ; TO MAKE SURE IT IS OK.
if        (koldsync>=0 || ksynch<=0) goto next1  ; IF IT IS THE END OF A CYCLE
kdx       =         -kdx2                    ; RESET THE OSCILLATOR
kpulse    =         kmax
knew      =         kmax
goto      next4

next1:
if        (knew<=kmax) goto next3            ; THE NEW VALUE IS BEYOND THE MAXIMUM
knew      =         kmax-kdx2*(kdx1-kmax+ktri)/kdx1  ; SO CALCULATE THE CORRECT POSITION.
kdx       =         -kdx2                    ; AND NEW SLOPE, SET PULSE TO THE OTHER
kpulse    =         kmax                     ; EXTREME.
goto      next4

next3:
if        (knew>=-kmax) goto next4           ; SAME AS ABOVE
knew      =         -kmax+kdx1*(kdx2-kmax-ktri)/kdx2
kdx       =         kdx1
kpulse    =         -kmax

next4:
ktri     =          knew                     ; THE NEW VALUE IS NOW OK SO UPDATE.

aout     =          (ishape=0 ? ktri : kpulse)  ; OUTPUT EITHER PULSE OR TRIANGLE WAVEFORM

         zawm       aout, ioutch
         zkw        kdx, isyncout

         endin

;---------------------------------------------------------------------------
; 4 POLE LOW PASS RESONANT FILTER
;---------------------------------------------------------------------------
          instr     20

ifcoch    =         p4                       ; CUT-OFF FREQUENCY
irezch    =         p5                       ; RESONANCE
irzmix    =         p6                       ; RESONANCE MIX
izin      =         p7                       ; INPUT CHANNEL
izout     =         p8                       ; OUTPUT CHANNEL
icut      =         .000001

kfco      zkr       ifcoch                   ; CUT-OFF FREQUENCY ENVELOPE FROM CHANNEL
kfcort    =         sqrt(kfco)               ; NEEDED FOR THE FILTER
krezo     zkr       irezch                   ; RESONANCE ENVELOPE FROM CHANNEL
krez      =         krezo*kfco/500           ; ADD MORE RESONANCE AT HIGH FCO
kdclick   linseg    0, .002, 1, p3-.004, 1, .002, 0  ; DECLICK


axn       zar       izin                     ; READ INPUT CHANNEL
          
ka1       =         1000/krez/kfco-1         ; COMPUTE FILTER COEFF. A1
ka2       =         100000/kfco/kfco         ; COMPUTE FILTER COEFF. A2
kb        =         1+ka1+ka2                ; COMPUTE FILTER COEFF. B
ay1       nlfilt    axn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1  ; USE THE NON-LINEAR FILTER
ay        nlfilt    ay1/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1  ; AS AN ORDINARY FILTER.

ka1lp     =         1000/kfco-1              ; RESONANCE OF 1 IS A LOW PASS FILTER
ka2lp     =         100000/kfco/kfco
kblp      =         1+ka1lp+ka2lp
ay1lp     nlfilt    axn/kblp, (ka1lp+2*ka2lp)/kblp, -ka2lp/kblp, 0, 0, 1   ; LOW-PASS FILTER
aylp      nlfilt    ay1lp/kblp, (ka1lp+2*ka2lp)/kblp, -ka2lp/kblp, 0, 0, 1

ayrez     =         ay - aylp                ; EXTRACT THE RESONANCE PART.
ayrz      =         ayrez/kfco/(1+icut*kfco*kfco*kfco)  ; USE LOWER AMPLITUDES AT HIGHER FCO
;ayrz      =        ayrez/kfco               ; USE LOWER AMPLITUDES AT HIGHER FCO

ay2       =         aylp*6*(1-irzmix) + ayrz*300*irzmix  ; SCALE THE LOW PASS AND RESONANCE SEPARATELY

          zaw       ay2*kdclick, izout       ; WRITE TO THE OUTPUT CHANNEL

          endin

;---------------------------------------------------------------------------
; CONTOLLED AMPLIFIER
;---------------------------------------------------------------------------
          instr     25

imaxch    =         p4
igainch   =         p5
inch      =         p6
ioutch    =         p7

kmax      zkr       imaxch
kgain     zkr       igainch
asig      zar       inch

aout      =         kmax*kgain*asig  ; USE THE ENVELOPE TO CONTROL THE GAIN.

          zaw       aout, ioutch

          endin

;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
          instr     100

asig1     zar       p4                       ; READ INPUT CHANNEL 1
igl1      init      p5*p6                    ; LEFT GAIN
igr1      init      p5*(1-p6)                ; RIGHT GAIN

asig2     zar       p7                       ; READ INPUT CHANNEL 2
igl2      init      p8*p9                    ; LEFT GAIN
igr2      init      p8*(1-p9)                ; RIGHT GAIN

kdclick   linseg    0, .001, 1, p3-.002, 1, .001, 0  ; DECLICK

asigl     =         asig1*igl1 + asig2*igl2  ; SCALE AND SUM
asigr     =         asig1*igr1 + asig2*igr2

          outs      kdclick*asigl, kdclick*asigr   ; OUTPUT STEREO PAIR

          endin

; CLEAR AUDIO
          instr     110

          zacl      0, 30                    ; CLEAR AUDIO CHANNELS 0 TO 30

          endin
