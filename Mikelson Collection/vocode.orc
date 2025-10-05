;-----------------------------------------------------------------
; 21 BAND VOCODER
; CODED BY HANS MIKELSON 5/30/1998
;-----------------------------------------------------------------
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2
zakinit 50, 50                     ; Initialize the zak system

;----------------------------------------------------------------------------------
; Disk Input Stereo
;----------------------------------------------------------------------------------
        instr  3

iamp    =      p4                   ; Amplitude
irate   =      p5                   ; Read rate
isndin  =      p6                   ; Sound input file
ioutch1 =      p7                   ; Output channel 1
ioutch2 =      p8                   ; Output channel 2

ain1, ain2 diskin isndin, irate     ; Read stereo input

        zaw    ain1, ioutch1        ; Output to audio channel 1
        zaw    ain2, ioutch2        ; Output to audio channel 2

        endin

;---------------------------------------------------------------------------------
; Sawtooth (Band Limited Impulse Train)
;---------------------------------------------------------------------------------
        instr   4

idur    =       p3                    ; Duration
iamp    =       p4                    ; Amplitude
ifqc    =       cpspch(p5)            ; Note to frequency
ipanl   =       sqrt(p6)              ; Pan left
ipanr   =       sqrt(1-p6)            ; Pan Right
ioutch1 =       p7                    ; Output Channel 1
ioutch2 =       p8                    ; Output Channel 2

kdclik linseg   0, .002, iamp, idur-.004, iamp, .002, 0

apulse buzz     1,ifqc, sr/2/ifqc, 1  ; Avoid aliasing
asawdc integ    apulse                ; Integrating the pulses makes a saw wave
axn    =        asawdc-.5             ; Shift DC offset

aoutl  =        kdclik*axn*ipanl      ; De-click & pan
aoutr  =        kdclik*axn*ipanr
       zawm     aoutl, ioutch1        ; Write to output channels
       zawm     aoutr, ioutch2

       endin

;---------------------------------------------------------------------------------
; PWM (Band Limited Impulse Train)
;---------------------------------------------------------------------------------
        instr   5

idur    =       p3                    ; Duration
iamp    =       p4                    ; Amplitude
ifqc    =       cpspch(p5)            ; Note to frequency
ipanl   =       sqrt(p6)              ; Pan left
ipanr   =       sqrt(1-p6)            ; Pan Right
ioutch1 =       p7                    ; Output Channel 1
ioutch2 =       p8                    ; Output Channel 2
imodrate =      p9
imodepth =      p10

kdclik  linseg   0, .002, iamp, idur-.004, iamp, .002, 0

klfo    oscili  imodepth, imodrate, 1
kfqc    =       ifqc*(1+klfo)

apulse1 buzz    1,ifqc, sr/2/ifqc, 1 ; Avoid aliasing
apulse2 vdelay  apulse1, 1000/kfqc/2, 1000/ifqc
avpw    =       apulse1 - apulse2         ; two inverted pulses at variable distance
apwmdc  integ   avpw
axn     butterhp   apwmdc, 10              ; remove DC offset caused by integ

aoutl  =        kdclik*axn*ipanl      ; De-click & pan
aoutr  =        kdclik*axn*ipanr
       zawm     aoutl, ioutch1        ; Write to output channels
       zawm     aoutr, ioutch2

;       outs     aoutl, aoutr

       endin

;----------------------------------------------------------------------------------
; 21 BAND VOCODER
; DERIVED FROM PINKSTON'S 
;----------------------------------------------------------------------------------
       instr     10

iamp    =        p4               ; AMPLITUDE
asigm   zar      p5               ; MODULATOR
asigc   zar      p6               ; CARRIER
ipan    =        p7               ; PAN
ifqc1   =        p8               ; LOW FREQUENCY
ifqcf   =        p9               ; HIGH FREQUENCY
ibw     =        p10              ; BANDWIDTH FACTOR
istep   pow     p9/p8, .05       ; FIND STEP-SIZE TO GO FROM LOW TO HIGH

; COMPUTE THE CENTER FREQUENCY FOR EACH BAND.
ifqc2   =        ifqc1*istep
ifqc3   =        ifqc2*istep
ifqc4   =        ifqc3*istep
ifqc5   =        ifqc4*istep
ifqc6   =        ifqc5*istep
ifqc7   =        ifqc6*istep
ifqc8   =        ifqc7*istep
ifqc9   =        ifqc8*istep
ifqc10  =        ifqc9*istep
ifqc11  =        ifqc10*istep
ifqc12  =        ifqc11*istep
ifqc13  =        ifqc12*istep
ifqc14  =        ifqc13*istep
ifqc15  =        ifqc14*istep
ifqc16  =        ifqc15*istep
ifqc17  =        ifqc16*istep
ifqc18  =        ifqc17*istep
ifqc19  =        ifqc18*istep
ifqc20  =        ifqc19*istep
ifqc21  =        ifqc20*istep

; Bandpass filter the modulator
am1    butterbp  asigm, ifqc1,   ifqc1/20*ibw
am2    butterbp  asigm, ifqc2,   ifqc2/20*ibw
am3    butterbp  asigm, ifqc3,   ifqc3/20*ibw
am4    butterbp  asigm, ifqc4,   ifqc4/20*ibw
am5    butterbp  asigm, ifqc5,   ifqc5/20*ibw
am6    butterbp  asigm, ifqc6,   ifqc6/20*ibw
am7    butterbp  asigm, ifqc7,   ifqc7/20*ibw
am8    butterbp  asigm, ifqc8,   ifqc8/20*ibw
am9    butterbp  asigm, ifqc9,   ifqc9/20*ibw
am10   butterbp  asigm, ifqc10,  ifqc10/20*ibw
am11   butterbp  asigm, ifqc11,  ifqc11/20*ibw
am12   butterbp  asigm, ifqc12,  ifqc12/20*ibw
am13   butterbp  asigm, ifqc13,  ifqc13/20*ibw
am14   butterbp  asigm, ifqc14,  ifqc14/20*ibw
am15   butterbp  asigm, ifqc15,  ifqc15/20*ibw
am16   butterbp  asigm, ifqc16,  ifqc16/20*ibw
am17   butterbp  asigm, ifqc17,  ifqc17/20*ibw
am18   butterbp  asigm, ifqc18,  ifqc18/20*ibw
am19   butterbp  asigm, ifqc19,  ifqc19/20*ibw
am20   butterbp  asigm, ifqc20,  ifqc20/20*ibw
am21   butterbp  asigm, ifqc21,  ifqc21/20*ibw

; Bandpass filter the carrier
ac1    butterbp  asigc, ifqc1,   ifqc1/20*ibw
ac2    butterbp  asigc, ifqc2,   ifqc2/20*ibw
ac3    butterbp  asigc, ifqc3,   ifqc3/20*ibw
ac4    butterbp  asigc, ifqc4,   ifqc4/20*ibw
ac5    butterbp  asigc, ifqc5,   ifqc5/20*ibw
ac6    butterbp  asigc, ifqc6,   ifqc6/20*ibw
ac7    butterbp  asigc, ifqc7,   ifqc7/20*ibw
ac8    butterbp  asigc, ifqc8,   ifqc8/20*ibw
ac9    butterbp  asigc, ifqc9,   ifqc9/20*ibw
ac10   butterbp  asigc, ifqc10,  ifqc10/20*ibw
ac11   butterbp  asigc, ifqc11,  ifqc11/20*ibw
ac12   butterbp  asigc, ifqc12,  ifqc12/20*ibw
ac13   butterbp  asigc, ifqc13,  ifqc13/20*ibw
ac14   butterbp  asigc, ifqc14,  ifqc14/20*ibw
ac15   butterbp  asigc, ifqc15,  ifqc15/20*ibw
ac16   butterbp  asigc, ifqc16,  ifqc16/20*ibw
ac17   butterbp  asigc, ifqc17,  ifqc17/20*ibw
ac18   butterbp  asigc, ifqc18,  ifqc18/20*ibw
ac19   butterbp  asigc, ifqc19,  ifqc19/20*ibw
ac20   butterbp  asigc, ifqc20,  ifqc20/20*ibw
ac21   butterbp  asigc, ifqc21,  ifqc21/20*ibw

; Balance carrier level to modulator level.
ao1    balance   ac1,  am1
ao2    balance   ac2,  am2
ao3    balance   ac3,  am3
ao4    balance   ac4,  am4
ao5    balance   ac5,  am5
ao6    balance   ac6,  am6
ao7    balance   ac7,  am7
ao8    balance   ac8,  am8
ao9    balance   ac9,  am9
ao10   balance   ac10, am10
ao11   balance   ac11, am11
ao12   balance   ac12, am12
ao13   balance   ac13, am13
ao14   balance   ac14, am14
ao15   balance   ac15, am15
ao16   balance   ac16, am16
ao17   balance   ac17, am17
ao18   balance   ac18, am18
ao19   balance   ac19, am19
ao20   balance   ac20, am20
ao21   balance   ac21, am21

; Add up the carriers and output with panning.
aout   =         (ao1+ao2+ao3+ao4+ao5+ao6+ao7+ao8+ao9+ao10+ao11+ao12+ao13+ao14+ao15+ao16+ao17+ao18+ao19+ao20+ao21)*iamp/ibw

       outs      aout*sqrt(ipan), aout*sqrt(1-ipan)

       endin

;----------------------------------------------------------------------------------
; 8 Band Vocoder
;----------------------------------------------------------------------------------
       instr     11

iamp    =        p4               ; Amplitude
asigm   zar      p5               ; Modulator
asigc   zar      p6               ; Carrier
ipan    =        p7               ; Pan
ifqmtab =        p8               ; Modular Frequency Table
ifqctab =        p9               ; Carrier Frequency Table
ibw     =        p10              ; Bandwidth factor

; Compute the center frequency for each band.
ifqm1   table    0, ifqmtab
ifqm2   table    1, ifqmtab
ifqm3   table    2, ifqmtab
ifqm4   table    3, ifqmtab
ifqm5   table    4, ifqmtab
ifqm6   table    5, ifqmtab
ifqm7   table    6, ifqmtab
ifqm8   table    7, ifqmtab

; Compute center frequency for each carrier band.
; Note that you can rebuild based on different frequencies
ifqc1   table    0, ifqctab
ifqc2   table    1, ifqctab
ifqc3   table    2, ifqctab
ifqc4   table    3, ifqctab
ifqc5   table    4, ifqctab
ifqc6   table    5, ifqctab
ifqc7   table    6, ifqctab
ifqc8   table    7, ifqctab

; Bandpass filter the modulator
am1    butterbp  asigm, ifqm1,   ifqm1/20*ibw
am2    butterbp  asigm, ifqm2,   ifqm2/20*ibw
am3    butterbp  asigm, ifqm3,   ifqm3/20*ibw
am4    butterbp  asigm, ifqm4,   ifqm4/20*ibw
am5    butterbp  asigm, ifqm5,   ifqm5/20*ibw
am6    butterbp  asigm, ifqm6,   ifqm6/20*ibw
am7    butterbp  asigm, ifqm7,   ifqm7/20*ibw
am8    butterbp  asigm, ifqm8,   ifqm8/20*ibw

; Bandpass filter the carrier
ac1    butterbp  asigc, ifqc1,   ifqc1/20*ibw
ac2    butterbp  asigc, ifqc2,   ifqc2/20*ibw
ac3    butterbp  asigc, ifqc3,   ifqc3/20*ibw
ac4    butterbp  asigc, ifqc4,   ifqc4/20*ibw
ac5    butterbp  asigc, ifqc5,   ifqc5/20*ibw
ac6    butterbp  asigc, ifqc6,   ifqc6/20*ibw
ac7    butterbp  asigc, ifqc7,   ifqc7/20*ibw
ac8    butterbp  asigc, ifqc8,   ifqc8/20*ibw

; Balance carrier level to modulator level.
ao1    balance   ac1,  am1
ao2    balance   ac2,  am2
ao3    balance   ac3,  am3
ao4    balance   ac4,  am4
ao5    balance   ac5,  am5
ao6    balance   ac6,  am6
ao7    balance   ac7,  am7
ao8    balance   ac8,  am8

; Add up the carriers and output with panning.
aout   =         (ao1+ao2+ao3+ao4+ao5+ao6+ao7+ao8)*iamp/ibw

       outs      aout*sqrt(ipan), aout*sqrt(1-ipan)

       endin


;---------------------------------------------------------------------------
; Zak Clear
;---------------------------------------------------------------------------
          instr 99

          zacl 0, 50
          zkcl 0, 50

          endin


