;*********************************************
; PHYSICAL MODELS 1                          *
; CODED:        1/22/97 HANS MIKELSON        *
;*********************************************

sr 		= 		44100
kr 		= 		4410
ksmps 	=  		10
nchnls 	= 		1

		instr 8  										; DRUM STICK 1

gadrum 	init 	0

													; FREQUENCY
ifqc  	= 		cpspch(p5)

													; AMP ENVELOPE
;kampenv 	linseg 	0,.01,1,p3-.01,1

													; INITIALIZE THE DELAY LINE WITH NOISE
ashape 	linseg 	0, 1/ifqc/8, -p4/2, 1/ifqc/4, p4/2, 1/ifqc/8, 0, p3-1/ifqc, 0
gadrum 	tone 	ashape, p6

		endin

		instr 9  										; A SQUARE DRUM

itube    	init 	p7
ifdbck1  	init 	p8
ifdbck2  	init 	p9
iwidth   	init 	p10
ilength  	init 	p11
idiagnl  	= 		sqrt(iwidth*iwidth+ilength*ilength)

anodea   	init 	0
anodeb   	init 	0
anodec   	init 	0
anoded   	init 	0
afiltr   	init 	0
ablocka2 	init 	0
ablocka3 	init 	0
ablockb2 	init 	0
ablockb3 	init 	0
ablockc2 	init 	0
ablockc3 	init 	0
ablockd2 	init 	0
ablockd3 	init 	0

													; FREQUENCY
ifqc  	= 		cpspch(p5)
ipfilt 	= 		p6

													; AMPLITUDE ENVELOPE
kampenv   linseg 	0, .01, p4, p3-.02, p4, .01, 0

													; DELAY LINES
alineab 	delay 	anodea+gadrum+afiltr, ilength/ifqc
alineba 	delay 	anodeb+gadrum+afiltr, ilength/ifqc
alinebc 	delay 	anodeb+gadrum+afiltr, iwidth/ifqc
alinecb 	delay 	anodec+gadrum+afiltr, iwidth/ifqc
alinecd 	delay 	anodec+gadrum+afiltr, ilength/ifqc
alinedc 	delay 	anoded+gadrum+afiltr, ilength/ifqc
alinead 	delay 	anodea+gadrum+afiltr, iwidth/ifqc
alineda 	delay 	anoded+gadrum+afiltr, iwidth/ifqc
alineac 	delay 	anodea+gadrum+afiltr, idiagnl/ifqc
alineca 	delay 	anodec+gadrum+afiltr, idiagnl/ifqc
alinebd 	delay 	anodeb+gadrum+afiltr, idiagnl/ifqc
alinedb 	delay 	anoded+gadrum+afiltr, idiagnl/ifqc

										 		; FILTER THE DELAYED SIGNAL AND FEEDBACK INTO THE DELAY.
												; IMPLEMENTS DC BLOCKING.
ablocka1 	= 		-(alineba + alineca + alineda)/ifdbck1
ablocka2 	= 		ablocka1 - ablocka3 + .99*ablocka2
ablocka3 	= 		ablocka1
anodea   	= 		ablocka2

; NODE B
ablockb1 	= 		-(alineba + alineca + alineda)/ifdbck1
ablockb2 	= 		ablockb1 - ablockb3 + .99*ablockb2
ablockb3 	= 		ablockb1
anodeb   	= 		ablockb2

; NODE C
ablockc1 	= 		-(alineba + alineca + alineda)/ifdbck1
ablockc2 	= 		ablockc1 - ablockc3 + .99*ablockc2
ablockc3 	= 		ablockc1
anodec   	= 		ablockc2

; NODE D
ablockd1 	= 		-(alineba + alineca + alineda)/ifdbck1
ablockd2 	= 		ablockd1 - ablockd3 + .99*ablockd2
ablockd3 	= 		ablockd1
anoded   	= 		ablockd2

; BODY RESONANCE
atube  	delay 	anodea, itube/ifqc
afiltr 	tone  	atube, 1000
afiltr 	= 		afiltr/ifdbck2

; SCALE AND OUTPUT
		out 		anodea*kampenv*1000

		endin

		instr 10  									; DRUM STICK 2

gadrum 	init 	0

													; FREQUENCY
ifqc  	= 		cpspch(p5)

													; AMP ENVELOPE
;kampenv linseg 	0,.01,1,p3-.01,1

													; INITIALIZE THE DELAY LINE WITH NOISE
kshape 	linseg 	0, 1/ifqc/8, -p4/2, 1/ifqc/4, p4/2, 1/ifqc/8, 0, p3-1/ifqc, 0
ashape 	rand 	kshape
gadrum 	=    	ashape

		endin
