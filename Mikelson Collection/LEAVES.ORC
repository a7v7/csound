sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

;BUBBLING CAULDRON FROM CUBEWATER , VARIATION ON KIM CASCONE'S WATER BY ELOY ANZOLA

          instr     8

igain     =         p4
ifreq     =         p5                  ;MUST BE VALUES < OR CLOSE TO 1, CONTROLS PITCH
krt       =         p6                  ;THIS IS THE FRQ OF THE RANDH OUTPUT & CLK OSC
ipantab   =         p7

ksh       randh     5000, krt

;a2       oscil     2, 100, 1           ;SINE OSC (F1) CONTROLLED BY S&H
a2        rand      3000

ksh       =         ksh * ifreq         ;* .5

a4        butterhp  a2,ksh ;,50         ;FILTER WITH S&H CONTROLING THE FCO
a3        oscil     a4,1/p3,13          ;a3 IS THE OUTPUT f13 ADSR

a3        =         a3 * igain

kpan      oscil     1,.14, ipantab

aoutl     =         a3 * (1-kpan)
aoutr     =         a3 * kpan
        
          outs      aoutl,aoutr

          endin

