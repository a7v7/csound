;---------------------------------------------------------
; CRICKETS
; CODED BY HANS MIKELSON SEPTEMBER, 1999
;---------------------------------------------------------
sr             =              44100                         ; SAMPLE RATE
kr             =              4410                          ; KONTROL RATE
ksmps          =              10                            ; SAMPLES/KONTROL PERIOD
nchnls         =              2                             ; NORMAL STEREO

;---------------------------------------------------------
; CRICKET 2
;---------------------------------------------------------
               instr          14

idur           =              p3                  ; DURATION
iamp           =              p4                  ; AMPLITUDE
ifqc           =              p5                  ; FREQUENCY MODIFICATION
ipuls          =              p6                  ; PULSE TABLE
iftab          =              p7                  ; FREQUENCY TABLE
iloop          =              p8                  ; LOOP TIME
iltab          =              p9                  ; LOOP TABLE
ilpetab        =              p10                 ; LOOP ENVELOPE TABLE
ifetab         =              p11                 ; FREQUENCY ENVELOPE TABLE
ibasef         =              19                  ; BASE PULSE FREQUENCY
ipanl          =              sqrt(p12)           ; PAN LEFT
ipanr          =              sqrt(1-p12)         ; PAN RIGHT
iv             =              iamp/10000          ; HIGH SHELF LEVEL

kaf            oscili         2, 1/iloop, iltab        ; PULSE ENVELOPE FM
kamp1          oscili         1, 1/iloop, ilpetab      ; LOOP ENVELOPE
kfenv          oscili         1, 1/iloop, ifetab       ; LOOP FREQUENCY ENVELOPE
     
kamp2          oscili         1, ibasef*kaf, ipuls     ; GENERATE PULSE STREAM
kamp           =              sqrt(kamp1*kamp2)        ; MAKE IT ROUNDED

kfqc1          oscil          4800*kfenv*ifqc, ibasef*kaf, iftab      ; FUNDAMENTAL FQC
kfqc2          oscil          9500*kfenv*ifqc, ibasef*kaf, iftab      ; OVERTONE

kdclck         linseg         0, .005, 1, idur-.01, 1, .005, 0        ; DECLICK ENVELOPE

afnd           oscil          kamp, kfqc1, 1                          ; FUNDAMENTAL OSCILLATOR
ahrm           oscil          kamp, kfqc2, 1                          ; OVERTONE OSCILLATOR

aout           pareq          (afnd+ahrm*.04)*iamp*kdclck, 7000, iv, .707, 2    ; SET HIGH SHELF FILTER LOW FOR DISTANT CRICKETS

               outs           aout*ipanl, aout*ipanr                  ; OUTPUT THE SOUND WITH PANNING

               endin

