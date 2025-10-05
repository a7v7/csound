sr        =         44100     ; SAMPLE RATE OF SOUND FILE
kr        =         4410      ; CONTROL RATE
ksmps     =         10
nchnls    =         1         ; MONO

          instr 1
k1        expon     p6, p3, p7               ; p6 = START CURVE, p7 = END CURVE
a1        soundin   p5, 0, 4                 ; p5 = SOUNDIN F#
a1        =         a1 * k1                  ; RAMP THE SOUNDIN
ascale    =         a1 * p4                  ; p4 = SCALING FACTOR
          display   k1, p3                   ; DRAW CURVE ON SCREEN
          out       ascale                   ; WRITE TO DISK
          endin
