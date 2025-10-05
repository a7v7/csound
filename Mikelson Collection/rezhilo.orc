sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2
zakinit 	50, 50

;---------------------------------------------------------------
; LFO
;---------------------------------------------------------------
		 instr   	5

idur		 =	    p3
iamp		 =	    p4
ifqc		 =	    p5
iwave	 =	    p6
ioffset	 =	    p7
ioutch	 =	    p8

ksig		 oscil   iamp, ifqc, iwave
kout		 =	    ksig*.5+ioffset
		 zkw	    kout, ioutch

		 endin

;---------------------------------------------------------------
; MOOG VCO WITH MIKLESON FILTER
;---------------------------------------------------------------
		 instr   12

idur		 =	    p3			; DURATION
iamp		 =	    p4			; AMPLITUDE
ifqc		 =	    cpspch(p5)		; FREQUENCY
irtfqc	 =	    sqrt(ifqc)		; SQUARE ROOT OF FREQUENCY
ifco		 =	    p6*ifqc/500	; FILTER CUT OFF (HIGHER FREQUENCIES GET A HIGHER CUT OFF)
krez		 init    p7			; RESONANCE DOES NOT CHANGE IN THIS INSTRUMENT
iwave	 =	    p8			; SELECTED WAVE FORM 1=SAW, 2=SQUARE/PWM, 3=TRI/SAW-RAMP-MOD
ipwch	 =	    p9			; PWM CHANNEL
ipbend	 =	    p10			; PITCH BEND TABLE
isine	 =	    1
imaxd	 =	    1/ifqc*2
imode	 =	    p11

ileak	 =	    (iwave==2 ? .999 : (iwave==3 ? .995 : .999)) ; LEAKY INTEGRATION VALUE

kpw		 zkr	    ipwch			; READ THE ZAK MODULATION CHANNEL
kpwn		 =	    kpw-.5		; GET A PULSE WIDTH THAT GOES FROM -.5 TO .5
kfco		 expseg  100+.1*ifco, .2*idur, ifco+100, .5*idur, ifco*.1+100, .3*idur, .1*ifco+100 ; Filter envelope
kpbend	 oscil   1, 1/idur, ipbend  ; Pitch bend
kamp		 linseg  0, .01*idur, iamp, .2*idur, .8*iamp, .59*idur, .5*iamp, .2*idur, 0		  ; Amp envelope
kfqc		 =	    ifqc*kpbend

asig		 vco	    1, kfqc, iwave, kpw, isine, imaxd
aout		 rezzy   asig, kfco*kpbend, krez, imode			    ; APPLY THE FILTER

		 outs    aout*kamp, asig*iamp					    ; STEREO OUPUT AND AMPLIFICATION
		 endin
