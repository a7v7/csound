;I never came across this one, so in case anyone is thinking about
;{"notenumber" (here in cps) to panorama position}:
;this is a very easy way to get a full stereo image whithout having to 
;add any special parameters
;**************************************************************************
;orchestra
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

		instr 1 


ipan		=		(.0005681*p4)			; MULTIPLIER:"NOTENUMBER"(CPS!) TO PAN 
									; ADAPT FOR GREATER VALUES:1/FREQ;(CPS)
a1		oscil	12000, p4, 1
		outs		a1*ipan, a1*(1-ipan)

		endin
