; mikelson ORC
sr     =      44100 ; sr=kr
kr     =      44100
ksmps  =      1
nchnls =      2
      zakinit 50, 50 ; Initialize the zak system

      instr  1             ; Instrument 1 is for the impulse

ioutch =      p4           ; Zak channel number

arnd  rand   1             ; Generate a noise signal
      zaw    arnd, ioutch  ; Ouput to the zak channel

      endin

      instr 2              ; Instrument 2 implements feedback loop

iamp  =     p4             ; Amplitude
itime =     1/cpspch(p5)   ; Convert pitch to time
iinch =     p6             ; Input channel

aflt init   0              ; Initially filtered signal is zero

asig  zar   iinch          ; Read the zak channel

adel delay asig+aflt, itime ; Mix the filtered signal with the original and delay
alp  butterlp adel, 5000   ; Lowpass filter
aflt butterhp alp, 20      ; High pass filter

     outs  aflt*iamp, aflt*iamp ; Amplify and output

     endin
