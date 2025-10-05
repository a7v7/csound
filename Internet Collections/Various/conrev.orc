; convrev.orc

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 1             ; EXPONENTIALLY ENVELOPED WHITE NOISE INSTRUMENT
idur      =         p3
iexpstrt  =         p4                       ; RANGE = .0000001 TO 1 (0 IS ILLEGAL)
iexpend   =         p5                       ; RANGE = .0000001 TO 1 (0 IS ILLEGAL)
iwhite    =         32000                    ; SET TO THE MAXIMUM AMPLITUDE FOR A 16 BIT LINEAR DAC
iseedl    =         .1                       ; SEED THE RANDOM NUMBER GENERATORS
iseedr    =         .3

kamp      expon     iexpstrt, idur, iexpend   
asigl     rand      iwhite, iseedl
asigr     rand      iwhite, iseedr
          outs      kamp * asigl, kamp * asigr
          endin

          instr 2             ; EXPONENTIALLY ENVELOPED SOUNDIN INSTRUMENT
idur      =         p3
iexpstrt  =         p4                       ; RANGE = .0000001 TO 1
iexpend   =         p5                       ; RANGE = .0000001 TO 1
input     =         p6                       ; soundin.x -   x = NUMBERS FROM 1 TO 10 
                                             ; RENAME YOUR INPUT FILES ACCORDINGLY
kamp      expon     iexpstrt, idur, iexpend
al, ar    soundin   input, 0, 4
          outs      kamp * al, kamp * ar
          endin
