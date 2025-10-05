sr        =         44100
kr        =         22050
ksmps     =         2
nchnls    =         2
zakinit   30,30

;----------------------------------------------------------------------------------
; NOISE CLICK FOR TESTING THE DECAY CURVE OF THE REVERB.
          instr  1

idur      =         p3
iamp      =         p4
ioutch    =         p5

kamp      linseg    0, .002, iamp, .002, 0, idur-.004, 0
aout      rand      kamp

          zaw       aout, ioutch
;         outs      aout, aout

          endin

;----------------------------------------------------------------------------------
; DISK INPUT
          instr  2

iamps     =         p4
iamp      =         p5
irate     =         p6
isndin    =         p7
ioutch    =         p8

ain       diskin    isndin, irate
          zaw       ain*iamps, ioutch
          outs      ain*iamp, ain*iamp

          endin

;----------------------------------------------------------------------------------
; REVERB
          instr  10

idur      =         p3
irevtm    =         p4
iinch     =         p5

ain       zar       iinch               ; READ THE CHANNEL
aout      reverb    ain, irevtm         ; DELAY FOR TIME
          outs      aout, -aout         ; OUTPUT THE CHANNEL

       endin

;----------------------------------------------------------------------------------
; REVERB2
          instr  11

idur      =         p3
irevtm    =         p4
ihidif    =         p5
iinch     =         p6

ain       zar       iinch                    ; READ THE CHANNEL
aout      reverb2   ain, irevtm, ihidif      ; DELAY FOR TIME
          outs      aout, -aout              ; OUTPUT THE CHANNEL

          endin

