;********************************************* 
; Physical Model 1 Karplus Strong Algorithm * 
; coded:  1/22/97 by Hans Mikelson *
;********************************************* 

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
kcount    init      0
k1        =         (kcount<=110 ? 1:0)
a1        rand      p4
a2        delayr    .005
a3        delay1    a2
          delayw    (a2+a3)/2+a1*k1
          out       a3
kcount    =         kcount + 1
          endin
