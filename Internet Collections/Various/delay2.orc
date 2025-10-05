sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
		instr 1

kenv		expon 	1, p3, .0001			; EXPON ENVELOPE
asig		foscil	p4 * kenv, cpspch(p5), 1, 1.414, 2, 1 ; AN FM BELL 
adel1	delay	asig, .2				; DELAY .2 SECONDS
adel2	delay	asig, .4				; DELAY .4 SECONDS
adel3	delay	asig, .6				; DELAY .6 SECONDS
adel4	delay	asig, .8				; DELAY .8 SECONDS
adel5	delay	asig, 1.0				; DELAY 1 SECONDS
asig		=		asig + adel1*.9 + adel2 * .7 + adel3 * .5 + adel4*.3 + adel5 * .1
		out		asig

		endin
