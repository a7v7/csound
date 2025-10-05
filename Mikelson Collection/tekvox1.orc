sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

;---------------------------------------------------------------------------
; SAMPLE WITH NOISE FILTER RESONANCE
;---------------------------------------------------------------------------
               instr     1

idur           =         p3                       ; DURATION
iamp           =         p4                       ; AMPLITUDE
irate          =         p5                       ; READ RATE
isndin         =         p6                       ; SOUND INPUT FILE
ipantab        =         p7                       ; PAN TABLE
krez           =         p8                       ; RESONANCE
iband          =         0                        ; JUST LEAVE IT ZERO...
ifqcadj        =         .149659863*sr            ; ADJUSTMENT FOR FILTER FREQUENCY

kfco1          expseg    800, idur/5, 5000, idur/5, 1000, idur/5, 2000, idur/5, 700, idur/5, 3000 ; FREQ CUT-OFF
klfo           oscil     1, 20, 20
kfco           =         kfco1*klfo

ain1, ain2 diskin isndin, irate                   ; READ SOUND FILE

axn            =         ain1+ain2                ; MIX THE TWO TOGETHER

; RESONANT LOWPASS FILTER (4 POLE)
kc             =          ifqcadj/kfco                 ; FILTER CONSTANT
krez2          =          krez/(1+exp(kfco/11000))     ; ADJUST FOR HIGH FREQUENCIES
ka1            =          kc/krez2-(1+krez2*iband)     ; ADJUST FOR BAND PASS CHARACTER
kasq           =          kc*kc                        ; C^2
kb             =          1+ka1+kasq                   ; FIND B

ayn            nlfilt     axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1       ; USE THE NON-LINEAR FILTER LINEARLY
ayn2           nlfilt     ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1       ; 4-POLE

; RESONANT LOWPASS FILTER (4 POLE)
kcl            =          ifqcadj/kfco
krez2l         =          2.0/(1+exp(kfco/11000))                          ; SAME AS ABOVE BUT LOW RESONANCE THIS TIME.
ka1l           =          kcl/krez2l-(1+krez2l*iband)
kasql          =          kcl*kcl
kbl            =          1+ka1l+kasql

aynl           nlfilt     axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
ayn2l          nlfilt     aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1

ares1          =         ayn2-ayn2l                    ; ISOLATE THE RESONANCE
krms           rms       ares1, 100                    ; COMPUTE THE AVERAGE RESONANCE LEVEL

arand1         rand      krms                          ; NOISE SOURCE
ares2          butterbp  arand1, kfco, kfco/4          ; BAND FILTER IT BASED ON FILTER CUT-OFF
ares3          butterbp  arand1, kfco*2, kfco/4        ; GET ANOTHER BAND
aout           =         ayn2l+(ares2+ares3)           ; ADD BACK ON TO THE LOW-PASS SIGNAL

kpan           oscil     1, 1/idur, ipantab            ; PANNING
kpanl          =         sqrt(kpan)*iamp
kpanr          =         sqrt(1-kpan)*iamp
               outs      aout*kpanl, aout*kpanr        ; GIVE IT TO ME.

               endin

;---------------------------------------------------------------------------
; SAMPLE WITH FM FILTER RESONANCE
;---------------------------------------------------------------------------
               instr     2

idur           =         p3                  ; DURATION
iamp           =         p4                  ; AMPLITUDE
irate          =         p5                  ; READ RATE
isndin         =         p6                  ; SOUND INPUT FILE NUMBER
ipantab        =         p7                  ; PANNING TABLE
krez           =         p8                  ; RESONANCE
iband          =         0                   ; CONTROLS BAND-PASS CHARACTER OF THE FILTER BUT
ifqcadj        =         .149659863*sr       ; VALUES OTHER THAN ZERO MAKE THE FILTER UNSTABLE

kfco1          expseg    5000, idur/5, 1000, idur/5, 2000, idur/5, 700, idur/5, 3000, idur/5, 800 ; FILTER SWEEP
klfo           oscil     1, 20, 20
kfco           =         kfco1*klfo

ain1, ain2 diskin isndin, irate              ; READ IN THE SOUND FILE (MUST BE STEREO)

axn            =         ain1+ain2           ; JUST MIX TOGETHER

; RESONANT LOWPASS FILTER (4 POLE)
kc             =         ifqcadj/kfco        ; FIND THE MYSTERIOUS CONSTANT "C"
krez2          =         krez/(1+exp(kfco/11000)) ; REDUCE RES AT HIGH FREQUENCIES
ka1            =         kc/krez2-(1+krez2*iband) ; COMPUTE A1
kasq           =         kc*kc                         ; C^2
kb             =         1+ka1+kasq                    ; FIND B

ayn            nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1   ; USE NLFILT FOR FILTER SWEEP.
ayn2           nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1   ; DO IT AGAIN FOR FOUR POLE.

; RESONANT LOWPASS FILTER (4 POLE)      ; SAME AS ABOVE BUT LOW-PASS WITHOUT RESONANCE.
kcl            =         ifqcadj/kfco
krez2l         =         2.0/(1+exp(kfco/11000))
ka1l           =         kcl/krez2l-(1+krez2l*iband)
kasql          =         kcl*kcl
kbl            =         1+ka1l+kasql

aynl           nlfilt    axn/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1
ayn2l          nlfilt    aynl/kbl, (ka1l+2*kasql)/kbl, -kasql/kbl, 0, 0, 1

ares1          =         ayn2-ayn2l                    ; EXTRACT RESONANCE
krms           rms       ares1, 100                    ; HOW BIG IS THE RESONANCE
;              Amp   Fqc       Car  Mod      MAmp  Wave
ares2          foscil    krms, kfco,     1,   .75,     3,    1   ; GENERATE AN FM SIGNAL BASED ON RESONANCE
aout           =         ayn2l+ares2/4                 ; ADD IT ON TO THE LOW-PASS VERSION

kpan           oscil     1, 1/idur, ipantab            ; HANDLE EQUAL POWER PANNING
kpanl          =         sqrt(kpan)*iamp
kpanr          =         sqrt(1-kpan)*iamp
               outs      aout*kpanl, aout*kpanr        ; OUTPUT

               endin

