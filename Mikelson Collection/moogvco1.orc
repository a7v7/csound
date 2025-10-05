;---------------------------------------------------------------
; A SET OF ANALOG MODELING INSTRUMENTS USING RESONANT LOW-PASS
; FILTER BY HANS MIKELSON NOVEMBER 1998
;---------------------------------------------------------------
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

zakinit 50, 50

;---------------------------------------------------------------
; LFO
;---------------------------------------------------------------
		instr   	5

idur		=	    	p3
iamp		=	    	p4
ifqc		=	    	p5
iwave	=	    	p6
ioffset	=	    	p7
ioutch	=	    	p8

ksig		oscil   	iamp, ifqc, iwave
kout		=	    	ksig*.5+ioffset
		zkw	    	kout, ioutch

		endin

;---------------------------------------------------------------
; VCO WITH REZZY FILTER
;---------------------------------------------------------------
		instr	11

idur		=	    	p3					; DURATION
iamp		=	    	p4					; AMPLITUDE
ifqc		=	    	cpspch(p5)			; FREQUENCY
irtfqc	=	    	sqrt(ifqc)			; SQUARE ROOT OF FREQUENCY
ifco		=	    	p6*ifqc/500			; FILTER CUT OFF (HIGHER FREQUENCIES GET A HIGHER CUT OFF)
krez		init    	p7					; RESONANCE DOES NOT CHANGE IN THIS INSTRUMENT
iwave	=	    	p8					; SELECTED WAVE FORM 1=SAW, 2=SQUARE/PWM, 3=TRI/SAW-RAMP-MOD
ipwch	=	    	p9					; PWM CHANNEL
ipbend	=	    	p10					; PITCH BEND TABLE
isine	=	    	1
imaxd	=	    	2*ifqc

ileak	=	    	(iwave==2 ? .999 : (iwave==3 ? .995 : .999)) ; LEAKY INTEGRATION VALUE

kpw		zkr	    	ipwch								; READ THE ZAK MODULATION CHANNEL
kpwn		=	    	kpw-.5								; GET A PULSE WIDTH THAT GOES FROM -.5 TO .5
kfco		expseg  	100+.5*ifco, .2*idur, ifco+100, .5*idur, ifco*.8+100, .1*idur, .5*ifco+100 ; FILTER ENVELOPE
kpbend	oscil   	1, 1/idur, ipbend  												; PITCH BEND
kamp		linseg  	0, .01*idur, iamp, .2*idur, .9*iamp, .59*idur, .9*iamp, .2*idur, 0		; AMP ENVELOPE
aamp		interp  	kamp
kfqc		=	    	ifqc*kpbend

asig		vco	    	1, kfqc, iwave, kpw, isine, imaxd

aout		rezzy   	asig, kfco*kpbend, krez				    	; APPLY THE FILTER

		outs    	aout*aamp, aout*aamp					; STEREO OUPUT AND AMPLIFICATION
		endin

;---------------------------------------------------------------
; MOOG VCO WITH MIKLESON FILTER
;---------------------------------------------------------------
		instr	12

idur		=	    	p3						; DURATION
iamp		=	    	p4						; AMPLITUDE
ifqc		=	    	cpspch(p5)				; FREQUENCY
irtfqc	=	    	sqrt(ifqc)				; SQUARE ROOT OF FREQUENCY
ifco		=	    	p6*ifqc/500				; FILTER CUT OFF (HIGHER FREQUENCIES GET A HIGHER CUT OFF)
krez		init    	p7						; RESONANCE DOES NOT CHANGE IN THIS INSTRUMENT
iwave	=	    	p8						; SELECTED WAVE FORM 1=SAW, 2=SQUARE/PWM, 3=TRI/SAW-RAMP-MOD
ipwch	=	    	p9						; PWM CHANNEL
ipbend	=	    	p10						; PITCH BEND TABLE
isine	=	    	1
imaxd	=	    	2*ifqc

ileak	=	    	(iwave==2 ? .999 : (iwave==3 ? .995 : .999)) ; LEAKY INTEGRATION VALUE

kpw		zkr	    	ipwch					; READ THE ZAK MODULATION CHANNEL
kpwn		=	    	kpw-.5					; GET A PULSE WIDTH THAT GOES FROM -.5 TO .5
kfco		expseg  	100+.1*ifco, .2*idur, ifco+100, .5*idur, ifco*.2+100, .1*idur, .4*ifco+100 ; FILTER ENVELOPE
kpbend	oscil   	1, 1/idur, ipbend  												; PITCH BEND
kamp		linseg  	0, .01*idur, iamp, .2*idur, .8*iamp, .59*idur, .5*iamp, .2*idur, 0		; AMP ENVELOPE
aamp		interp  	kamp
kfqc		=	    	ifqc*kpbend

asig		vco	    	1, kfqc, iwave, kpw, isine, imaxd

aout		rezzy   	asig, kfco*kpbend, krez				    	; APPLY THE FILTER

		outs    	aout*aamp, aout*aamp					; STEREO OUPUT AND AMPLIFICATION
		endin

;---------------------------------------------------------------
; MOOG VCO WITH MIKLESON FILTER
;---------------------------------------------------------------
		instr	13
										
idur		=	    	p3									; DURATION
iamp		=	    	p4									; AMPLITUDE
ifqc		=	    	cpspch(p5)							; FREQUENCY
irtfqc	=	    	sqrt(ifqc)							; SQUARE ROOT OF FREQUENCY
ifco		=	    	p6*ifqc/500		; FILTER CUT OFF (HIGHER FREQUENCIES GET A HIGHER CUT OFF)
krez		init    	p7				; RESONANCE DOES NOT CHANGE IN THIS INSTRUMENT
iwave	=	    	p8				; SELECTED WAVE FORM 1=SAW, 2=SQUARE/PWM, 3=TRI/SAW-RAMP-MOD
isine	=	    	1
imaxd	=	    	2/ifqc

kpw		init    	.5		  		; READ THE ZAK MODULATION CHANNEL
kfco		expseg  	100+.1*ifco, .2*idur, ifco, .6*idur, ifco, .2*idur, .4*ifco+100	  ; FILTER ENVELOPE
kamp		linseg  	0, .2*idur, iamp, .6*idur, iamp, .2*idur, 0  ; AMP ENVELOPE
aamp		interp  	kamp
kvibr	oscil   	.002, 6, 1
kfqc		=	   	ifqc*(1 + kvibr)
kfclf1	oscil   	.5, .5, 1
kfclf2	oscil   	.5, .6, 1

asig1	vco	    	1, kfqc*.998,  iwave, kpw, isine, imaxd
asig2	vco	    	1, kfqc*.999,  iwave, kpw, isine, imaxd
asig3	vco	    	1, kfqc*1.001, iwave, kpw, isine, imaxd
asig4	vco	    	1, kfqc*1.002, iwave, kpw, isine, imaxd

aoutl1	rezzy   	asig1+asig3, kfco*0.99*(1+kfclf1), krez		   ; APPLY THE FILTER
aoutr1	rezzy   	asig2+asig4, kfco*1.01*(1+kfclf2), krez		   ; APPLY THE FILTER
aoutl2	rezzy   	asig1+asig3, kfco*1.51*(1+kfclf1), krez		   ; APPLY THE FILTER
aoutr2	rezzy   	asig2+asig4, kfco*1.49*(1+kfclf2), krez		   ; APPLY THE FILTER

		outs    	(aoutl1+aoutl2)*aamp, (aoutr1+aoutr2)*aamp	   ; STEREO OUPUT AND AMPLIFICATION
		endin

