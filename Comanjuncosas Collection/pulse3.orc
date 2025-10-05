sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
          instr 1             ; BANDLIMITED PWM CODED BY Josep M» Comajuncosas
; note: you could further integrate the output
; to get Triangle waves with pulse modulation

kamp      init      10000
kfreq     line      100, p3, 200
krel      line      1, p3 ,0; 0 to 1 (modulation index)

apulse1   buzz      1,kfreq, sr/(2*kfreq), 1;no aliasing here! ;-)

apulse    delayr    1/50;don«t try to use below 50 Hz <- a better idea?
apulse2   deltapi   krel/kfreq;interpolating to get the proper phase
          delayw    apulse1
                                             
avpw      =         apulse1 - apulse2        ; TWO INVERTED PULSES AT VARIABLE DISTANCE
apwmdc    integ     avpw                     ; INTEGRATING GIVES A SQUARE WAVE WITH WM
apwm      atone     apwmdc,1                 ; REMOVE DC OFFSET CAUSED BY INTEG
apwm      balance   apwm,apulse1             ; AND RESTORE ORIGINAL POWER

          out       kamp*apwm                ; LOOK AT ITS SONOGRAM! IT«S REALLY NICE!!
endin
