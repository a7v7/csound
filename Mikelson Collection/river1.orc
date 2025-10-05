;----------------------------------------------------------------------
; DOWN BY THE RIVER
; BY HANS MIKELSON
;----------------------------------------------------------------------

sr 			= 		44100
kr 			= 		4410
ksmps 		= 		10
nchnls 		= 		1

;P4 AMPS ARE HERE DOUBLED
; 			guitar
			instr 	1

ablock2 	init   	0
ablock3 	init   	0

kamp		linseg	0.0, 0.015, p4*2, p3-0.065, p4*2, 0.05, 0.0
ablk		pluck 	kamp, p5, p5, 0, 1

ablock2 	=      	ablk-ablock3+.99*ablock2    ;THIS IS A DC BLOCKING FILTER
ablock3 	=      	ablk                        ;USED TO PREVENT DRIFT AWAY FROM
asig    	=      	ablock2                     ;ZERO.

af1			reson	asig, 110, 80
af2			reson	asig, 220, 80
af3			reson	asig, 440, 80

abalnc		balance 0.8*af1+af2+0.4*af3+0.4*asig, asig

			out 	abalnc
			endin

; HAMMER/PULL
			instr 	2
kamp		linseg	0.0, 0.015, p4*2, p3-0.065, p4*2, 0.05, 0.0
kfreq		linseg	p5, p7*p3, p5, 0.005, p6, (1-p7)*p3-0.005, p6
asig		pluck 	kamp, kfreq, p5, 0, 1
af1			reson	asig, 110, 80
af2			reson	asig, 220, 100
af3			reson	asig, 440, 80
aout		balance 0.6*af1+af2+0.6*af3+0.4*asig, asig
			out 	aout
			endin

; HARMONICS
			instr 	3
kamp		linseg 	0.0, 0.015, p4*2, p3-0.035, p4*2, 0.02, 0.0
asig		pluck	kamp, p5, p5, 0, 6
			out 	asig
			endin

