; CSOUND SYSTEM FOR IMPLEMENTING REVERBS BASED ON NESTED ALL-PASS FILTERS
; SIMILAR TO THOSE USED BY WILLIAM GARDNER (MIT)
; CODED BY HANS MIKELSON 12/2/97
;
; 1. NOISE CLICK
; 2. DISK INPUT
; 8. SIMPLE SUM
; 9. FEEDBACK FILTER
;10. DELAY
;11. SIMPLE ALL-PASS FILTER
;12. NESTED ALL-PASS FILTER
;13. DOUBLE NESTED ALL-PASS FILTER
;15. OUTPUT 

sr        =    44100
kr        =    22050
ksmps     =    2
nchnls    =    2
zakinit   30,30

;----------------------------------------------------------------------------------
; NOISE CLICK FOR TESTING THE DECAY CURVE OF THE REVERB.
          instr  1

idur      =     p3
iamp      =     p4
ioutch    =     p5
ifco      =     p6

kamp      linseg    0, .002, iamp, .002, 0, idur-.004, 0
aout      rand      kamp

afilt     butterlp  aout, ifco
          zaw       afilt, ioutch
;         outs      aout, aout

          endin

;----------------------------------------------------------------------------------
; DISK INPUT
       instr  2

iamp      =         p4
irate     =         p5
isndin    =         p6
ioutch    =         p7
ifco      =         p8

ain       diskin    isndin, irate
; afilt   butterlp  ain, ifco
;         zaw       afilt*iamp, ioutch
          zaw       ain*iamp, ioutch
          outs      ain*iamp, ain*iamp

          endin

;----------------------------------------------------------------------------------
; BAND-LIMITED IMPULSE
       instr  3

iamp      =         p4
ifqc      =         cpspch(p5)
ioutch    =         p6

apulse    buzz      1,ifqc, sr/2/ifqc, 1 			; AVOID ALIASING

          zaw       apulse*iamp, ioutch
          outs      apulse*iamp, apulse*iamp

          endin

       
;----------------------------------------------------------------------------------
; SIMPLE SUM--ADD 2 CHANNELS TOGETHER AND OUTPUT TO A THIRD CHANNEL.
          instr  8

idur      =         p3
iinch1    =         p4
iinch2    =         p5
ioutch    =         p6

ain1      zar       iinch1
ain2      zar       iinch2
          zaw       ain1+ain2, ioutch

          endin

;----------------------------------------------------------------------------------
; FEEDBACK FILTER
          instr  9

idur      =         p3
ifco      =         p4
igain     =         p5
iinch1    =         p6
iinch2    =         p7
ioutch    =         p8

ain1      zar       iinch1
ain2      zar       iinch2                   	; READ IN TWO CHANNELS

afilt     butterbp  ain2, ifco, ifco/2       	; BANDPASS FILTER ONE CHANNEL
          zaw       ain1+igain*afilt, ioutch 	; ADJUST FILTER LEVEL ADD & OUTPUT

       endin

;----------------------------------------------------------------------------------
; DELAY  -- SIMPLE DELAY
          instr  10

idur      =         p3
idtime    =         p4/1000
igain     =         p5
iinch     =         p6
ioutch    =         p7

ain       zar       iinch               ; READ THE CHANNEL
aout      delay     ain, idtime         ; DELAY FOR TIME
          zaw       aout, ioutch        ; OUTPUT THE CHANNEL
     
          endin


;----------------------------------------------------------------------------------
; SIMPLE ALL-PASS FILTER
          instr  11

idur      =         p3
itime     =         p4/1000
igain     =         p5
iinch     =         p6
ioutch    =         p7
adel1     init      0

ain       zar       iinch

aout      =         adel1-igain*ain               ; FEED FORWARD
adel1     delay     ain+igain*aout, itime         ; DELAY AND FEEDBACK

          zaw       aout, ioutch

          endin

;----------------------------------------------------------------------------------
; SINGLE NESTED ALL-PASS FILTER
          instr  12

idur      =         p3
itime1    =         p4/1000-p6/1000
igain1    =         p5
itime2    =         p6/1000
igain2    =         p7
iinch     =         p8
ioutch    =         p9
adel1     init      0
adel2     init      0

ain       zar       iinch

asum      =         adel2 - igain2*adel1          	; FEED FORWARD (INNER ALL-PASS)
aout      =         asum - igain1*ain             	; FEED FORWARD (OUTER ALL-PASS)

adel1     delay     ain  + igain1*aout, itime1    	; FEEDBACK (OUTER ALL-PASS)
adel2     delay     adel1 + igain2*asum, itime2   	; FEEDBACK (INNER ALL-PASS)

          zaw       aout, ioutch

          endin

;----------------------------------------------------------------------------------
; DOUBLE NESTED ALL-PASS FILTER (1 OUTER WITH 2 INNER IN SERIES)
          instr  13

idur      =         p3
itime1    =         p4/1000-p6/1000-p8/1000
igain1    =         p5
itime2    =         p6/1000
igain2    =         p7
itime3    =         p8/1000
igain3    =         p9
iinch     =         p10
ioutch    =         p11
adel1     init      0
adel2     init      0
adel3     init      0

ain       zar       iinch

asum1     =         adel2 - igain2*adel1               ; FIRST  INNER FEED FORWARD
asum2     =         adel3 - igain3*asum1               ; SECOND INNER FEED FORWARD
aout      =         asum2 - igain1*ain                 ; OUTER  FEED FORWARD

adel1     delay     ain  + igain1*aout, itime1         ; OUTER FEEDBACK
adel2     delay     adel1 + igain2*asum1, itime2       ; FIRST INNER FEEDBACK
adel3     delay     asum1 + igain3*asum2, itime3       ; SECOND INNER FEEDBACK

       zaw    aout, ioutch

       endin


;----------------------------------------------------------------------------------
; OUTPUT FOR REVERB
          instr  15

idur      =         p3
igain     =         p4
iinch     =         p5

kdclik    linseg    0, .002, igain, idur-.004, igain, .002, 0

ain       zar       iinch
          outs      ain*kdclik, -ain*kdclik            ; INVERTING ONE SIDE MAKES THE SOUND
          endin                                        ; SEEM TO COME FROM ALL AROUND YOU.
                                                       ; THIS MAY CAUSE SOME PROBLEMS WITH CERTAIN
                                                       ; SURROUND SOUND SYSTEMS.
