; pulse 2
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1             ; PWM RU94
; p4      =         Pitch p5 = PulseWidth in % p6 = PWMmodDepth +/- p6% ;;
; p7      =         pwmlfoFreq               ;;p8 = LFOwaveForm F#

apwm      oscil     p6*10, p7,p8             ; =lfo
asaw      oscil     1000,p4,1                ; f#1 MUST BE SAW
asqr      table     asaw+(p5*10)+500+apwm,2,0,0,1
                                             ; f#2 = 0-1500:0, 1500-2048:+1

          out       asqr*10000               ; OUTPUT SCALING
          endin
