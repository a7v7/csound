
;*********************************************
; Physical Models                            *
; coded:        1/22/97 Hans Mikelson        *
;*********************************************

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

; PERRY COOK'S SLIDE FLUTE

          instr 2
          
aflute1   init      0

; FLOW SETUP

kenv1     linseg    0, .05, 1.1*p4, .1, .98*p4, p3-.15, .95*p4 
kenv2     linseg    1, p3-.01, 1, .01, 0
aflow1    rand      kenv1
aflow1    =         aflow1/p4
asum1     =         aflow1*.0356 + kenv1/p4*1
asum2     =         asum1 + aflute1*.4

; EMBOUCHURE

ax        delayr    1/p5/4
          delayw    asum2
apoly     =         ax - ax*ax*ax
asum3     =         apoly + aflute1*.4

avalue    tone      asum3, 8*p5

; BORE

aflute1   delayr    1/p5/2
          delayw    avalue

          out       avalue*p4*kenv2
          endin

