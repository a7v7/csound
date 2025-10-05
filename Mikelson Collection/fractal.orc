;************************************************************
; An assortment of chaotic, fractal and related instruments
; Coded by Hans Mikelson  March 9, 1997
;************************************************************

; 1. The Lorenz Attractor  : Borrowed from the Csound mailing list
; 2. Duffings System or Cubic Oscillator
; 3. Planet Orbiting in a Binary Star System
; 4. The Rossler Attractor
; 5. K A Oscillator

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 1

; LORENZ EQUATIONS SYSTEM AT A-RATE WITH ALL PARAMETERS TIME-VARIABLE


ipi       init 6.283184
amix      init 0

;p4 p5 i p6 = initial values for control parameters
;p7       = time differential (not less than 0.02 - may be improved using Runge-Kutta
;         integration methode but it is very time consuming )
;p8 amplitude
;p9 zoom factor (a kind of temporal window applied to trajectories, values of
;         aprox. 5 are equivalent-almost- to downing p7 at the price of
;         a bit slowing down computing time...)
;p10 p11 p12 = deviation value for p6 p7 p8
;         (It is implemented with a simple line statement, but
;         improving it is straightforward)


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

;aa, ab AND ac HOLDS FOR THE VALUES OF CONTROL PARAMETERS

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
amixx     =         ax*iprof
amixy     =         ay*iprof

          outs      amixx, amixy

kcontzoom =         0

          endin


          instr 2             ; DUFFINGS SYSTEM OR CUBIC OSCILLATOR
                              ; I CAN'T SEEM TO GET THIS ONE TO WORK
                              ; dx = y
                              ; dy = Ax^3-By+C cos(t)

ax        init      0
ay        init      0
     
ka        init      p6
kb        init      p7
kc        init      p8
kh        init      p5

kampenv   linseg    0, .01, p4, p3-.02, p4, .01, 0

axnew     =         ay
acos1     oscil     kc, kh, 1, .25
ay        =         ay + kh*(ka*ax*ax*ax-kb*ay+acos1)
ax        =         axnew

          outs      kampenv*ax, kampenv*ay

          endin


          instr 3
; THIS SIMULATES A PLANET ORBITING IN A MULTIPLE STAR SYSTEM.

kampenv   linseg    0, .1, p4, p3-.2, p4, .1, 0

; PLANET POSITION (X, Y, Z) & VELOCITY (VX, VY, VZ)
kx        init      0
ky        init      .1
kz        init      0
kvx       init      .5
kvy       init      .6
kvz       init      -.1
ih        init      p5

; STAR 1 MASS & X, Y, Z
imass1    init      p6
is1x      init      0
is1y      init      0
is1z      init      p8

; STAR 2 MASS & X, Y, Z
imass2    init      p7
is2x      init      0
is2y      init      0
is2z      init      -p8

; CALCULATE DISTANCE TO STAR 1
kdx       =         is1x-kx
kdy       =         is1y-ky
kdz       =         is1z-kz
ksqradius =         kdx*kdx+kdy*kdy+kdz*kdz+1
kradius   =         sqrt(ksqradius)

; DETERMINE ACCELERATION DUE TO STAR 1 (AX, AY, AZ)
kax       =         imass1/ksqradius*kdx/kradius
kay       =         imass1/ksqradius*kdy/kradius
kaz       =         imass1/ksqradius*kdz/kradius

; CALCULATE DISTANCE TO STAR 2
kdx       =         is2x-kx
kdy       =         is2y-ky
kdz       =         is2z-kz
ksqradius =         kdx*kdx+kdy*kdy+kdz*kdz+1
kradius   =         sqrt(ksqradius)

; DETERMINE ACCELERATION DUE TO STAR 2 (AX, AY, AZ)
kax       =         kax+imass2/ksqradius*kdx/kradius
kay       =         kay+imass2/ksqradius*kdy/kradius
kaz       =         kaz+imass2/ksqradius*kdz/kradius

; UPDATE THE VELOCITY
kvx       =         kvx+ih*kax
kvy       =         kvy+ih*kay
kvz       =         kvz+ih*kaz

; UPDATE THE POSITION
kx        =         kx+ih*kvx
ky        =         ky+ih*kvy
kz        =         kz+ih*kvz

aoutx     =         kx*kampenv
aouty     =         ky*kampenv
          outs      aoutx, aouty

          endin


          instr 4             ; ROSSLER'S ATTRACTOR

ax        init      0
ay        init      0
az        init      0

ih        init      p5
aa        init      .375
ib        init      p6
ic        init      p7

; AMPLITUDE ENVELOPE
kampenv   linseg    0, .01, p4, p3-.02, p4, .01, 0

aa        oscil     1/7, .5, 1
aa        =         .3 + aa

axnew     =         ax + ih*(-ay - az)
aynew     =         ay + ih*(ax + aa*ay)
aznew     =         az + ih*(ib + ax*az - ic*az)

ax        =         axnew
ay        =         aynew
az        =         aznew

          outs      kampenv*ax, kampenv*ay

          endin

          instr 5             ; K A OSCILLATOR

ax        init      p5
ib        init      p6

; AMPLITUDE ENVELOPE
kampenv   linseg    0, .01, p4, p3-.02, p4, .01, 0

ax        =         ax * ib*(1 - ax)

          outs      kampenv*(ax-.5), kampenv*(ax-.5)

          endin
