sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Low level implementation
; of the classic Karplus-Strong algorithm
; fixed pitches : no vibratos or glissandi !
; implemented by Josep M Comajuncosas / Aug«98
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ipluck    =         p5; pluck position ( 0 to 1 )
ifreq     =         cpspch(p4)
idlts     =         int(kr/ifreq-.5)         ; SET WAVEGUIDE LENGTH (AN INTEGER NUMBER OF >SAMPLES)
idlt      =         idlts/kr                 ; CONVERT SO SECONDS
kdlt      init      idlts                    ; COUNTER FOR STRING INITIALISATION

irems     =         kr/ifreq - idlts +.5     ; REMAINING TIME IN FRACTIONS OF A SAMPLE
; SET PHASE DELAY INDUCED BY THE FIR LOWPASS FILTER
; AND THE FRACTIONAL DELAY IN THE WAVEGUIDE

iph       =         (1-irems)/(1+irems)      ; ALLPASS FILTER PARAMETER
; APPROXIMATION VALID AT LOW FREQUENCIES RELATIVE TO sr

awgout    init      0

;         timout    0, idlt, initialise
;timout   CAUSED PROBLEMS WITH DELAY INITIALISATION
;SO I USED kdlt AS A COUNTER...

          if        kdlt < 0 goto continue

initialise:

anoise    trirand   32000
; FILL THE BUFFER WITH RANDOM NUMBERS

anoise    butterlp  anoise, p6, 1
; SMOOTH A BIT THE NOISE BURST
; HARMONIC RICHNESS GROWS WITH VOLUME
; FINAL VOLUME DETERMINED BY THE FILTER GAIN

acomb     delay     anoise, ipluck/idlt
anoize    =         anoise - acomb
; IMPLEMENT PLUCK POINT AS A FIR COMB FILTER


continue:


areturn   delayr    idlt
ainput    =         anoize + areturn


alpf      filter2   ainput, 2, 0, .5, .5
; LOWPASS FILTER TO SIMULATE ENERGY LOSSES
; COULD BE VARIABLE TO ALLOW DAMPING CONTROL

awgout    filter2   alpf, 2, 1, iph, 1, iph
; ALLPASS FILTER TO FINE TUNE THE INSTRUMENT

          delayw    awgout

          out       awgout

kdlt      =         kdlt - 1
anoize    =         0                        ; SUPRESS LAST IMPULSE WHEN WAVEGUIDE IS LOADED
; TRICKY BUT EASY...

          endin
