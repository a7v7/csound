sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

;---------------------------------------------------------------
; VCO
;---------------------------------------------------------------
        instr   10

idur    =       p3              			; DURATION
iamp    =       p4              			; AMPLITUDE
ifqc    =       cpspch(p5)      			; FREQUENCY
iwave   =       p6              			; SELECTED WAVE FORM 1=Saw, 2=Square/PWM, 3=Tri/Saw-Ramp-Mod
isine   =       1
imaxd   =       1/ifqc*2        			; ALLOWS PITCH BEND DOWN OF TWO OCTAVES

kpw1    oscil   .25, ifqc/200, 1
kpw     =       kpw1 + .5

asig    vco     iamp, ifqc, iwave, kpw, 1, imaxd

        outs    asig, asig              	; OUPUT AND AMPLIFICATION

        endin

