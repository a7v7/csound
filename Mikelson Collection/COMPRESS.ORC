sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

gasig 	init 	0

; PLUCK
		instr 1

ifqc 	=      	cpspch(p5)
kamp 	linseg 	0, .01, p4, p3-.02, p4, .01, 0

asig  	oscil 	kamp, ifqc, 1
gasig 	=     	gasig + asig

		endin

; PLUCK
		instr 2

ifqc 	=      	cpspch(p5)
kamp 	linseg 	0, .01, p4, p3-.02, p4, .01, 0

asin1 	pluck 	kamp, ifqc, ifqc, p6, p7
asig1 	butterhp 	asin1, 10
asig  	butterlp 	asig1, 5000
;  		out   	asig
gasig 	=     	gasig + asig

		endin

; COMPRESSOR
		instr 3

kamp  	rms 		gasig, p4

kampn 	=      	kamp/40000
kcomp 	tablei 	kampn,p5,1,.5
acomp 	=      	kcomp*gasig

        	outs    	p6*acomp, p6*acomp
gasig 	=       	0

		endin

; NOISE GATE
		instr 4

kamp  	rms 		gasig, p4

kampn 	=      	kamp/40000
kcomp 	tablei 	kampn,p5,1,.5
acomp 	=      	kcomp*gasig

        	outs    	p6*acomp, p6*acomp
gasig 	=       	0

		endin

; RING MODULATOR
		instr 5
       	outs 	gasig*gasig/2000000, gasig*gasig/2000000	
		endin
