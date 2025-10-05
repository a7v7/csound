;**************************************************************** 
; RESONANT LOW-PASS FILTER
; CODED: HANS MIKELSON 2/7/97
;**************************************************************** 

sr 		= 		44100
kr 		= 		44100
ksmps 	=		1
nchnls 	= 		1


instr 	1 				; REZZY SYNTH BASED ON DIFF EQS

idur 	= 		p3
kamp 	linseg 	0, .01*p3, p4, .98*p3, p4, .01*p3, 0 
ifqc 	= 		cpspch(p5)
ires 	= 		p7/1000

kfco 	linseg 	.1*p6, p3, p6
kres 	= 		ires

; THE DIFFERENCE EQUATION COEFFICIENTS
kb 		= 		1/kfco/kres
kk 		= 		10000/kfco

aynm1 	init 	0
aynm2 	init 	0

axn 		oscil 	kamp, ifqc, 3

; THE DIFFERENCE EQUATION: YN=((B+2K)YN-1 - KYN-2 + XN)/(1+B+K) 

ayn		=		((kb+2*kk)*aynm1-kk*aynm2+axn)/(1+kb+kk) 
aynm2 	= 		aynm1
aynm1 	= 		ayn

out 		ayn
endin
