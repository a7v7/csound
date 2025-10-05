
; TESTS OF CRITICAL CAPABILITIES
; SEE perftest.sco FOR MORE DETAILS
; DAVE MADOLE 11/1/96

sr		=		44100
kr		=		4410
ksmps	=		10
nchnls 	=		2

; SIMPLE PLUCK WORKING ?
		instr 1
icps		=		p4
kcps		=		icps
aout		pluck	15000, kcps, icps, 0, 1
		outs 	aout, aout
		endin

; STEREO WORKING ?
		instr 2
icps 	=		p4
kcps		=		icps
kster	oscil1	0, 1, p3, p5 
aout		pluck	15000, kcps, icps, 0, 1
aoutl	= 		kster * aout
aoutr	=		aout - aoutl
		outs		aoutl,aoutr
		endin

; SOUNDIN WORKING ?
		instr 3
kster	oscil1	0, 1, p3, 2
aout		soundin	"snap1.aiff",0
aoutl	=		kster * aout
aoutr	=		(1-kster) * aout
		outs		aoutl,aoutr
		endin

; GEN 01 & LOSCIL WORKING
		instr   4
ifn		=		p4
icps		=		p5
ibas		=		p6
aout	    loscil	1,p5, p4, p6, 1, 0, 32768
		outs		aout, aout
		endin 

; lpc WORKING ? (DETERMINES THAT ANALYSIS DIRECTORY CAN BE FOUND AND FILE READ)
		instr 5
ktimpnt 	line		.0001,p3,1
krmsr,krmso,kerr,kcps lpread ktimpnt,"sung.lpc", 0, 
		if		kerr < .04 kgoto dobuzz
asig		rand		1.0
dobuzz: 
asig		buzz		1.0, kcps/2, int(sr/2/kcps), 1
asig		lpreson	asig
asig		=		5000 * asig * (krmso/32767)

		outs		asig, asig
		endin
