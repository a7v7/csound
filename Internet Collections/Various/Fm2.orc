; =================== A Simple FM Instrument ====================== ;
; ================ with swept modulation index ==================== ;
; ================   Non Sinusoidal Waveforms   =================== ;

sr      	=       	44100
kr      	=       	4410
ksmps   	=       	10
nchnls	=		1


		instr 	1
icar    	=       	1
imod    	=       	1
ifreq   	=       	55                              ; FUNCTION f1 (SINE WAVE: 2K)
iamp    	=       	ampdb(86)                       ; FUNCTION f2
kamp    	linseg  	0,p3*.1,iamp,p3*.8,iamp,p3*.1,0 ; FUNCTION f3
kind    	line    	p5,p3,p6                        ; FUNCTION f4
a1      	foscili 	kamp,ifreq,icar,imod,kind,p4    ; p4=ALTERNATE WAVEFORM
   		out     	a1                              ; p5=SWEPT MODULATION INDEX BEGIN
		endin                                     ; p6=SWEPT MODULATION INDEX PEAK
