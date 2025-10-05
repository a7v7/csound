;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         BASIC DRUM FILE                               ;
;                                                       ;
;         p3 = DURATION        p4 = AMPLITUDE           ;
;         p5 = PITCH IN PCH                             ;
;                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
     
          instr 1
k         init  32
inibw     =         30
kbwchg    oscil1    0.0,30,.2,2
kbw       =         kbwchg + inibw
loop:
asnd      oscili    (p4*.2),cpspch(p5),1
arnd      rand      p4,-1
afltr1    reson     arnd,cpspch(p5),kbw,2
afltr2    reson     afltr1,0,100,2
afltr     balance   afltr2,arnd
     
          if        (k <= 0) kgoto continue
k         =         k - 1
            kgoto   loop
continue:
adrum     =         afltr + asnd
asig      envlpx    adrum,.1,.2,.1,2,1,.01
          out       asig
          endin
