sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

;------------------------------------------------------------------
; SAMPLER EFFECTS
;------------------------------------------------------------------
		instr	7
idur	   	=		p3
iamp	   	=		p4
ifqc	   	=		p5
irattab 	=		p6
iratrat 	=		p7
ipantab 	=		p8
imixtab 	=		p9
ilptab  	=		p10
isndin  	=		p11					
kpan	   	oscil	1, 1/idur, ipantab		; PANNING
kmix	   	oscil	1, 1/idur, imixtab		; FADING
kloop   	oscil	1, 1/idur, ilptab		; LOOPING
loop1:	
kprate  	oscil	1, iratrat/kloop, irattab  ; PULSE RATE
kamp	   	linseg	0, .01, 1, i(kloop)-.02, 1, .01, 0	 ; AMPLITUDE GATE
;			 	AMP	   FQC
; a1, a2 	diskin   	isndin, ifqc
a1, a2  	soundin 	isndin
aout	   	=		(a1+a2)/2*kamp
; WHEN THE TIME RUNS OUT REINITIALIZE
	   	timout	0, i(kloop), cont1
	   	reinit	loop1
cont1:
	   	outs		aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; OUTPUT PAN & FADE
	   	endin
