; ORCHESTRA
sr     =       44100  ; Sample rate
kr     =       4410   ; Kontrol rate
ksmps  =       10     ; Samples per kontrol period
nchnls =       2      ; Number of channels
       zakinit 50, 50 ; Initialize the zak system

; Sends out a ratio signal on the appropriate channel
       instr  1

kratio =      p4    ; Ratio
ioutch =      p5    ; Output channel

       zkw    kratio, ioutch  ; Write k-rate zak array

       endin

; Instrument 2 reads it's pitch from instrument 1 zak channel
       instr 2

iamp   =      p4  ; Amplitude
ifqc   =      p5  ; Base frequency
irt    =      p6  ; Initial ratio
iinch  =      p7  ; Input zak channel

krt1   zkr    iinch         ; Read the zak channel
krt    port   krt1, .2, irt ; Portamento glide for .2 seconds

aoutl  poscil iamp, ifqc*krt*1.002, 1 ; Run the oscillator
aoutr  poscil iamp, ifqc*krt*0.998, 1 ; How about some stereo?

       outs  aoutl, aoutr

       endin
