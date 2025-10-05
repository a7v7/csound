;HANS MIKELSON
;------------------------------------------------------------------
; ORCHESTRA
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2
;------------------------------------------------------------------
; INDUSTRIAL LOOPS
;------------------------------------------------------------------
        	instr      4
idur    	=          p3
iamp    	=          p4*2
ifqc    	=          cpspch(p5)
iplstab 	=          p6
irattab 	=          p7
iratrat 	=          p8
ipantab 	=          p9
imixtab 	=          p10
ilptab  	=          p11
kpan    	oscil      1, 1/idur, ipantab             	; PANNING
kmix    	oscil      1, 1/idur, imixtab             	; FADING
kloop   	oscil      1, 1/idur, ilptab              	; LOOPING
;kfc    	 expseg     .1, idur/2, 4, idur/2, .1     	; FQC CENTER
loop1:
kprate  	oscil      1, iratrat/kloop, irattab      	; PULSE RATE
kamp    	oscil      iamp, kprate, iplstab          	; AMPLITUDE PULSE
asig    	rand       kamp                           	; NOISE SOURCE
;aflt   	 butterbp   asig, ifqc*kfc, ifqc*kfc/4     	; BAND FILTER
aflt    	butterbp   asig, ifqc, ifqc/4             	; BAND FILTER
aout    	balance    aflt, asig                     	; BRING LEVEL BACK UP
											; WHEN THE TIME RUNS OUT REINITIALIZE
        	timout     0, i(kloop), cont1
        	reinit     loop1
cont1:
        	outs       aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; OUTPUT PAN & FADE
        	endin
