sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 2
 
instr    1 ; Pseudo 6-Stage Stereo Phaser using notch filters

ilevl    = p4*1.18                       ; Output level
iratel   = p5                            ; L LFO rate
irater   = p6                            ; R LFO rate
iph      = p7/360                        ; R LFO phase in degrees
iwave    = p8                            ; LFO waveform
iq       = p9                            ; Q

ain      soundin  "Sample2"

klfol    oscili  .40, iratel, iwave      ; L LFO
klfor    oscili  .40, irater, iwave, iph ; R LFO
klfo1    table  klfol + .40, 1, 1        ; Convert to exponential
klfo2    table  klfol + .50, 1, 1        ; Convert to exponential
klfo3    table  klfol + .60, 1, 1        ; Convert to exponential
klfo4    table  klfor + .40, 1, 1        ; Convert to exponential
klfo5    table  klfor + .50, 1, 1        ; Convert to exponential
klfo6    table  klfor + .60, 1, 1        ; Convert to exponential
anl      pareq  ain, klfo1, 0, iq, 0     ; L Notch 1
anl      pareq  anl, klfo2, 0, iq, 0     ; L Notch 2
anl      pareq  anl, klfo3, 0, iq, 0     ; L Notch 3
anr      pareq  ain, klfo4, 0, iq, 0     ; R Notch 1
anr      pareq  anr, klfo5, 0, iq, 0     ; R Notch 2
anr      pareq  anr, klfo6, 0, iq, 0     ; R Notch 3
outs     anl*ilevl, anr*ilevl            ; Level and output

endin
