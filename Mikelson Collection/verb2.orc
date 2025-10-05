sr		=		44100
kr		=		22050
ksmps	=		2
nchnls	=		2
		zakinit 	30,30

;----------------------------------------------------------------------------------
; NOISE CLICK FOR TESTING THE DECAY CURVE OF THE REVERB.
;----------------------------------------------------------------------------------
       	instr  1

idur   	=      	p3
iamp   	=      	p4
ioutch 	=      	p5
ifco   	=      	p6

kamp   	linseg 	0, .002, iamp, .002, 0, idur-.004, 0
aout   	rand   	kamp

afilt  	butterlp 	aout, ifco
       	zaw    	afilt, ioutch
       	outs   	aout, aout

       	endin

;----------------------------------------------------------------------------------
; DISK INPUT MONO
;----------------------------------------------------------------------------------
       	instr  2

iamp   	=      	p4
irate  	=      	p5
isndin 	=      	p6
ioutch 	=      	p7

ain    	diskin 	isndin, irate
       	zaw    	ain, ioutch
       	outs   	ain*iamp, ain*iamp

       	endin
;----------------------------------------------------------------------------------
; DISK INPUT STEREO
;----------------------------------------------------------------------------------
        	instr  3

iamp    	=      	p4
irate   	=      	p5
isndin  	=      	p6
ioutch1 	=     	p7
ioutch2 	=      	p8

ain1, ain2 diskin isndin, irate

        	zaw    	ain1, ioutch1
        	zaw    	ain2, ioutch2
        	outs   	ain1*iamp, ain2*iamp

        	endin

;----------------------------------------------------------------------------------
; BAND-LIMITED IMPULSE
;----------------------------------------------------------------------------------
       	instr  5

iamp   	=      	p4
ifqc   	=      	cpspch(p5)
ioutch 	=      	p6

apulse 	buzz    	1,ifqc, sr/2/ifqc, 1 				; AVOID ALIASING

       	zaw     	apulse*iamp, ioutch
       	outs    	apulse*iamp, apulse*iamp

       	endin

;----------------------------------------------------------------------------------
; HANS REVERB 1
;----------------------------------------------------------------------------------
        	instr  27

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk1  	=        	p6
ifdbk2  	=        	p7
ifdbk3  	=        	p8
ifdbk4  	=        	p9
ifco1   	=        	p10
ifco2   	=        	p11
ifco3   	=        	p12
ifco4   	=        	p13
itim1   	=        	p14/1000
itim2   	=        	p15/1000
itim3   	=        	p16/1000
itim4   	=        	p17/1000
ioutch  	=        	p18
ifchp   	=        	p19

aflt1   	init     	0
aflt2   	init     	0
aflt3   	init     	0
aflt4   	init     	0

asig    	zar      	iinch


adel1   	delay   	asig+ifdbk1*aflt1+ifdbk2*aflt2-ifdbk3*aflt3-ifdbk4*aflt4, itim1 	; LOOP 1
adel2   	delay   	asig-ifdbk1*aflt1+ifdbk2*aflt2-ifdbk3*aflt3+ifdbk4*aflt4, itim2 	; LOOP 2
adel3   	delay   	asig+ifdbk1*aflt1-ifdbk2*aflt2+ifdbk3*aflt3-ifdbk4*aflt4, itim3 	; LOOP 3
adel4   	delay   	asig-ifdbk1*aflt1-ifdbk2*aflt2+ifdbk3*aflt3+ifdbk4*aflt4, itim4 	; LOOP 4

aflt11  	butterlp 	adel1,  ifco1
aflt21  	butterlp 	adel2,  ifco2
aflt31  	butterlp 	adel3,  ifco3
aflt41  	butterlp 	adel4,  ifco4
aflt1   	butterhp 	aflt11, ifchp
aflt2   	butterhp 	aflt21, ifchp
aflt3   	butterhp 	aflt31, ifchp
aflt4   	butterhp 	aflt41, ifchp

aout    	=        	aflt1+aflt2+aflt3+aflt4 				; COMBINE OUTPUTS

        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; HANS REVERB 2
;----------------------------------------------------------------------------------
        	instr  28

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk1  	=        	p6
ifdbk2  	=        	p7
ifdbk3  	=        	p8
ifco1   	=        	p9
ifco2   	=        	p10
ifco3   	=        	p11
itim1   	=        	p12/1000
itim2   	=        	p13/1000
itim3   	=        	p14/1000
ioutch  	=       	 p15

aflt1   	init     	0
aflt2   	init     	0
aflt3   	init     	0

asig    	zar      	iinch

adel1   	delay   	asig+ifdbk1*aflt1-ifdbk2*aflt2-ifdbk3*aflt3, itim1 		; LOOP 1
adel2   	delay    	asig-ifdbk1*aflt1+ifdbk2*aflt2-ifdbk3*aflt3, itim2 		; LOOP 2
adel3   	delay    	asig-ifdbk1*aflt1-ifdbk2*aflt2+ifdbk3*aflt3, itim3 		; LOOP 3

aflt1   	butterlp 	adel1, ifco1
aflt2   	butterlp 	adel2, ifco2
aflt3   	butterlp 	adel3, ifco3

aout    	=        	aflt1+aflt2+aflt3 					; COMBINE OUTPUTS
        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; HANS REVERB 3
;----------------------------------------------------------------------------------
        	instr  29

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk1  	=       	p6
ifdbk2  	=       	p7
ifco1   	=       	p8
ifco2   	=        	p9
itim1   	=        	p10/1000
itim2   	=        	p11/1000
ioutch  	=        	p12

aflt1   	init     	0
aflt2   	init     	0

asig    	zar      	iinch

adel1   	delay    	asig+aflt1*ifdbk1-aflt2*ifdbk2, itim1
adel2   	delay    	asig-aflt1*ifdbk1+aflt2*ifdbk2, itim2

aflt1   	butterlp 	adel1, ifco1
aflt2   	butterlp 	adel2, ifco2

aout    	=        	aflt1+aflt2
        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; OUTPUT FOR REVERB
;----------------------------------------------------------------------------------
       	instr  90

idur   	=      	p3
igain  	=      	p4
iinch  	=      	p5

kdclik 	linseg 	0, .002, igain, idur-.004, igain, .002, 0

ain    	zar    	iinch
       	outs   	ain*kdclik, -ain*kdclik  ; INVERTING ONE SIDE MAKES THE SOUND
       	endin                           	; SEEM TO COME FROM ALL AROUND YOU.
                                       		; THIS MAY CAUSE SOME PROBLEMS WITH CERTAIN
                                       		; SURROUND SOUND SYSTEMS

;----------------------------------------------------------------------------------
; OUTPUT FOR REVERB
;----------------------------------------------------------------------------------
       	instr  91

idur   	=      	p3
igain  	=      	p4
iinch1 	=      	p5
iinch2 	=      	p6

kdclik 	linseg 	0, .002, igain, idur-.004, igain, .002, 0

ain1   	zar    	iinch1
ain2   	zar    	iinch2
       	outs   	ain1*kdclik, ain2*kdclik

       	endin

;----------------------------------------------------------------------------------
; MONO OUTPUT FOR REVERB
;----------------------------------------------------------------------------------
       	instr  92

idur   	=      	p3
igain  	=      	p4
iinch1 	=      	p5

kdclik 	linseg 	0, .002, igain, idur-.004, igain, .002, 0

ain1   	zar    	iinch1
       	outs  	ain1*kdclik, ain1*kdclik

       	endin

;----------------------------------------------------------------------------------
; CLEAR ZAK
;----------------------------------------------------------------------------------
       	instr   99
       	zacl    	0,30
       	endin

