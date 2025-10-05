; =================== Simple FM Instrument ======================== ;
; ================ with swept modulation index ==================== ;

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

                                                                            
          instr     1                                                     
iamp      =         ampdb(p4)                          ; p4 = AMPLITUDE IN dB
kamp      linseg    0,p3*.1,iamp,p3*.8,iamp,p3*.1,0    ; p5 = OSCILLATOR FREQ IN Hz
kind      linseg    p8,p3*.7,p9,p3*.3,p8               ; p6 = CARRIER FREQ RATIO
a1        foscili   kamp,p5,p6,p7,kind,1               ; p7 = MOD FREQ RATIO 
          out       a1                                 ; p8 = START MOD SWEEP
          endin                                        ; p9 = PEAK MOD SWEEP
