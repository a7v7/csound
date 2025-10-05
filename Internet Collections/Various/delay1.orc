sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
		instr 1
 
kenv		expon	1, p3, .0001			; EXPON ENVELOPE
asig		foscil	p4 * kenv, cpspch(p5), 1, 1.414, 2, 1 ; AN FM BELL 
adel		delay	asig, .5				; DELAY .5 SECONDS
		out		asig + adel

		endin
