sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1    

          instr 1

; LORENZ EQUATIONS SYSTEM AT A-RATE WITH ALL PARAMETERS TIME-VARIABLE 


ipi       init      6.283184
amix      init      0

; p4 p5 i p6 = initial values for control parameters 
; p7 = time differential (not less than 0.02 - may be improved using Runge-Kutta
;    integration methode but it is very time consuming )
; p8 amplitude
; p9 zoom factor (a kind of temporal window applied to trajectories, values of 
;    aprox. 5 are equivalent-almost- to downing p7 at the price of
;    a bit slowing down computing time...)
; p10 p11 p12 = deviation value for p6 p7 p8 
;    (It is implemented with a simple line statement, but
;    improving it is straightforward)


kcontzoom init      0
kzoom     init      p9

iprof     init      p8
idt       init      p7

; NEWTON INTEGRATION METHODE

adx       init      0                        ; DIFERENTIALS
ady       init      0
adz       init      0
ax        init      .6                       ; VALUES
ay        init      .6
az        init      .6

; aa, ab AND ac HOLDS FOR THE VALUES OF CONTROL PARAMETERS 

aa        line      p4,p3,p4+p10
ab        line      p5,p3,p5+p11
ac        line      p6,p3,p6+p12

aa        init      p4
ab        init      p5
ac        init      p6

loop1: 
adx       =         aa*(ay-ax)
ady       =         ax*(ab-az)-ay
adz       =         ax*ay-ac*az
ax        =         ax+(idt*adx)
ay        =         ay+(idt*ady)
az        =         az+(idt*adz)

kcontzoom =         kcontzoom+1

          if        kcontzoom>=kzoom kgoto sortida
          if        kcontzoom!=kzoom kgoto loop1

sortida:
amix      =         ax*iprof

          out       amix

kcontzoom =         0

          endin
