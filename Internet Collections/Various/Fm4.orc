sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
; ======================================================================== ;
;        Complex fm: 2 modulators modulating a single carrier              ;
; ======================================================================== ;
;      p4  = amplitude of output wave
;      p5  = carrier frequency specified in Hz
;      p6  = modulating frequency for mod #1 specified in Hz
;      p7  = modulating frequency for mod #2 specified in Hz
;      p8  = carrier envelope function
;      p9  = modulator #1 envelope function
;      p10 = modulator #2 envelope function
;      p11 = modulation index 1 for modulator 1 - the minimum modulation
;      p12 = modulation index 2 for modulator 1 - the peak modulation
;      p13 = modulation index 1 for modulator 2 - the minimum modulation
;      p14 = modulation index 2 for modulator 2 - the peak modulation
; ========================================================================;
		instr 1
i1 		= 		1/p3					; ONE CYCLE OF FUNCTION PER NOTE DUR 
i2 		= 		p11 * p6                 ; DEVIATION FOR INDEX 1 OF MOD 1
i3 		= 		(p12-p11) * p6          	; DEVIATION FOR INDEX 2 OF MOD 1
i4 		= 		p13 * p7                	; DEVIATION FOR INDEX 1 OF MOD 2
i5 		= 		(p14-p13) * p7         	; DEVIATION FOR INDEX 2 OF MOD 2
ampcar  	oscil   	p4, i1, p8            	; AMPLITUDE ENVELOPE FOR THE CARRIER
ampmod1 	oscil   	i3, i1, p9            	; AMPLITUDE ENVELOPE FOR MODULATOR1
ampmod2 	oscil   	i5, i1, p10           	; AMPLITUDE ENVELOPE FOR MODULATOR2
amod1   	oscili  	ampmod1 + i2, p6, 1   	; MODULATING OSCILLATOR 1
amod2   	oscili  	ampmod2 + i4, p7, 1   	; MODULATING OSCILLATOR 2
amod    	=       	amod1 + amod2
asig    	oscili  	ampcar, p5 + amod, 1  	; CARRIER OSCILLATOR
		out     	asig
		endin
