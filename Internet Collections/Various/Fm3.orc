; =================== A Simple FM Instrument ====================== ;
; ================ with swept modulation index ==================== ;

sr      	= 		44100
kr      	= 		4410
ksmps   	= 		10
nchnls  	= 		1

		instr 	1
iamp    	=       	ampdb(p4)               ; p4=CARRIER AMPLITUDE IN dB
ifreq   	=       	p5                      ; p5=BASE FREQUENCY
icar    	=       	p6*ifreq                ; p6=CARRIER FREQUENCY RATIO
imod    	=       	p7*ifreq                ; p7=MODULATOR FREQUENCY RATIO
indx    	=       	ampdb(p8)               ; p8=MODULATION INDEX
kind    	linseg  	0,p3*.5,indx,p3*.5,0    ; SWEEPING MODULATION INDEX
amod    	oscili  	kind,imod,1
kamp    	linseg  	0,p3*.01,iamp,p3*.98,iamp,p3*.01,0
acar    	oscili  	kamp,icar+amod,1
  		out     	acar
		endin
