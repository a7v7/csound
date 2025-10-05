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
ioutch1 	=      	p7
ioutch2 	=      	p8

ain1, ain2 diskin isndin, irate

        	zaw    	ain1, ioutch1
        	zaw    	ain2, ioutch2
        	outs   	ain1*iamp, ain2*iamp

        	endin

;----------------------------------------------------------------------------------
; NOISE CLICK FOR TESTING THE DECAY CURVE OF THE REVERB.
;----------------------------------------------------------------------------------
       	instr  4

idur   	=      	p3
iamp   	=      	p4
ioutch 	=      	p5
ifco   	=      	p6

kamp   	linseg 	0, .002, iamp, .002, 0, idur-.004, 0
aout   	rand   	kamp

       	zaw    	aout, ioutch
       	outs   	aout, aout

       	endin

;----------------------------------------------------------------------------------
; BAND-LIMITED IMPULSE
;----------------------------------------------------------------------------------
       	instr  5

iamp   	=      	p4
ifqc   	=      	cpspch(p5)
ioutch 	=      	p6

apulse 	buzz    	1,ifqc, sr/2/ifqc, 1     		 	; AVOID ALIASING

       	zaw     	apulse*iamp, ioutch
       	outs    	apulse*iamp, apulse*iamp

       	endin

;----------------------------------------------------------------------------------
; 4 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
        	instr  27

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk   	=        	p6/4
ifco1   	=        	p7
ifco2   	=        	p7*p9/(p9+p10*(1-p8))
ifco3   	=        	p7*p9/(p9+p11*(1-p8))
ifco4   	=        	p7*p9/(p9+p12*(1-p8))
itim1   	=        	p9/1000
itim2   	=        	p10/1000
itim3   	=        	p11/1000
itim4   	=        	p12/1000
ioutch  	=        	p13
ifchp   	=        	p14

aflt1   	init     	0
aflt2   	init     	0
aflt3   	init     	0
aflt4   	init     	0

asig    	zar      	iinch


adel1   	delay   	asig+( aflt1+aflt2-aflt3-aflt4)*ifdbk, itim1 ; Loop 1
adel2   	delay   	asig+(-aflt1+aflt2-aflt3+aflt4)*ifdbk, itim2 ; Loop 2
adel3   	delay  	asig+( aflt1-aflt2+aflt3-aflt4)*ifdbk, itim3 ; Loop 3
adel4   	delay   	asig+(-aflt1-aflt2+aflt3+aflt4)*ifdbk, itim4 ; Loop 4

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
; 3 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
        	instr  28

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk   	=        	p6/3
ifco1   	=        	p7
ifco2   	=        	p7*p9/(p9+p10*(1-p8))
ifco3   	=        	p7*p9/(p9+p11*(1-p8))
itim1   	=        	p9/1000
itim2   	=        	p10/1000
itim3   	=        	p11/1000
ioutch  	=        	p12

aflt1   	init     	0
aflt2   	init     	0
aflt3   	init     	0

asig    	zar      	iinch

adel1   	delay    	asig+( aflt1-aflt2-aflt3)*ifdbk, itim1 ; Loop 1
adel2   	delay    	asig+(-aflt1+aflt2-aflt3)*ifdbk, itim2 ; Loop 2
adel3   	delay    	asig+(-aflt1-aflt2+aflt3)*ifdbk, itim3 ; Loop 3

aflt1   	butterlp 	adel1, ifco1
aflt2   	butterlp 	adel2, ifco2
aflt3   	butterlp 	adel3, ifco3

aout    	=        	aflt1+aflt2+aflt3 				; COMBINE OUTPUTS
        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; 2 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
        	instr  29

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk   	=        	p6/2
ifco1   	=        	p7
ifco2   	=        	p7*p9/(p9+p10*(1-p8))
itim1   	=        	p9/1000
itim2   	=        	p10/1000
ioutch  	=       	p11

aflt1   	init     	0
aflt2   	init     	0

asig    	zar      	iinch

adel1   	delay    	asig+(aflt1-aflt2)*ifdbk, itim1
adel2   	delay    	asig+(aflt2-aflt1)*ifdbk, itim2
	
aflt1   	butterlp 	adel1, ifco1
aflt2   	butterlp 	adel2, ifco2

aout    	=        	aflt1+aflt2
        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; 3 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
        	instr  34

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk   	=        	p6/3
ifco1   	=        	p7
ifco2   	=        	p7*p9/(p9+p10*(1-p8))
ifco3   	=        	p7*p9/(p9+p11*(1-p8))
itim1   	=        	p9/1000
itim2   	=        	p10/1000
itim3   	=        	p11/1000
ioutch  	=       	p12
ifchp   	=       	p13

aflt1   	init     	0
aflt2   	init     	0
aflt3   	init     	0

asig    	zar      	iinch

adel1   	delay    	asig+( aflt1-aflt2-aflt3)*ifdbk, itim1 ; Loop 1
adel2   	delay    	asig+(-aflt1+aflt2-aflt3)*ifdbk, itim2 ; Loop 2
adel3   	delay    	asig+(-aflt1-aflt2+aflt3)*ifdbk, itim3 ; Loop 3
	
aflt11  	butterlp 	adel1, ifco1
aflt21  	butterlp 	adel2, ifco2
aflt31  	butterlp 	adel3, ifco3
aflt1   	butterlp 	aflt11, ifchp
aflt2   	butterlp 	aflt21, ifchp
aflt3   	butterlp 	aflt31, ifchp

aout    	=        	aflt1+aflt2+aflt3 					; COMBINE OUTPUTS
        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; 2 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
        	instr  35

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk   	=        	p6/2
ifco1   	=        	p7
ifco2   	=        	p7*p9/(p9+p10*(1-p8))
itim1   	=        	p9/1000
itim2   	=        	p10/1000
ioutch  	=       	p11
ifchp   	=        	p12

aflt1   	init     	0
aflt2   	init     	0

asig    	zar      	iinch

adel1   	delay    	asig+(aflt1-aflt2)*ifdbk, itim1
adel2   	delay    	asig+(aflt2-aflt1)*ifdbk, itim2

aflt11  	butterlp 	adel1, ifco1
aflt21  	butterlp 	adel2, ifco2
aflt1   	butterhp 	aflt11, ifchp
aflt2   	butterhp 	aflt21, ifchp

aout    	=        	aflt1+aflt2
        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; 4 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
        instr  36

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk   	=        	p6/4
ifco1   	=        	p7
ifco2   	=        	p7*p9/(p9+p10*(1-p8))
ifco3   	=        	p7*p9/(p9+p11*(1-p8))
ifco4   	=        	p7*p9/(p9+p12*(1-p8))
itim1   	=        	p9/1000
itim2   	=        	p10/1000
itim3   	=        	p11/1000
itim4   	=        	p12/1000
ioutch  	=        	p13
ifchp   	=        	p14

aflt1   	init     	0
aflt2   	init     	0
aflt3   	init     	0
aflt4   	init     	0

;asig    	zar      	iinch
asig1   	zar      	iinch
asig    	reverb2  	asig1, .5, 1

adel1   	delay   	asig+( aflt1+aflt2-aflt3-aflt4)*ifdbk, itim1 ; Loop 1
adel2   	delay   	asig+(-aflt1+aflt2-aflt3+aflt4)*ifdbk, itim2 ; Loop 2
adel3   	delay   	asig+( aflt1-aflt2+aflt3-aflt4)*ifdbk, itim3 ; Loop 3
adel4   	delay   	asig+(-aflt1-aflt2+aflt3+aflt4)*ifdbk, itim4 ; Loop 4

; FC, VOL, Q
aflt1   	pareq     adel1,  ifco1, .5, .4, 2
aflt2   	pareq     adel2,  ifco2, .5, .4, 2
aflt3   	pareq     adel3,  ifco3, .5, .4, 2
aflt4   	pareq     adel4,  ifco4, .5, .4, 2

;arvb    	reverb2  	aflt1+aflt2+aflt3+aflt4, .5, .5
;aout    	butterhp 	arvb, 140 ; Combine outputs
aout    	butterhp 	aflt1+aflt2+aflt3+aflt4, 140 				; COMBINE OUTPUTS

        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; 3 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
        	instr  37

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk   	=        	p6/3
ifco1   	=        	p7
ifco2   	=        	p7*p9/(p9+p10*(1-p8))
ifco3   	=        	p7*p9/(p9+p11*(1-p8))
itim1   	=        	p9/1000
itim2   	=        	p10/1000
itim3   	=        	p11/1000
ioutch  	=        	p12

aflt1   	init     	0
aflt2   	init     	0
aflt3   	init     	0

asig1   	zar      	iinch
asig    	reverb2  	asig1, .5, 1
;asig    	zar      	iinch

adel1   	delay    	asig+( aflt1-aflt2-aflt3)*ifdbk, itim1 ; Loop 1
adel2   	delay    	asig+(-aflt1+aflt2-aflt3)*ifdbk, itim2 ; Loop 2
adel3   	delay    	asig+(-aflt1-aflt2+aflt3)*ifdbk, itim3 ; Loop 3

aflt1   	pareq     adel1, ifco1, .5, .4, 2
aflt2  	pareq     adel2, ifco2, .5, .4, 2
aflt3   	pareq     adel3, ifco3, .5, .4, 2

;arvb    	reverb2  	aflt1+aflt2+aflt3, .5, .5
aout    	butterhp 	aflt1+aflt2+aflt3, 140 				; COMBINE OUTPUTS
        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; 2 DELAY MULTIPLE FEEDBACK REVERB
;----------------------------------------------------------------------------------
        	instr  38

idur    	=        	p3
iamp    	=        	p4
iinch   	=        	p5
ifdbk   	=        	p6/2
ifco1   	=        	p7
ifco2   	=        	p7*p9/(p9+p10*(1-p8))
itim1   	=        	p9/1000
itim2   	=        	p10/1000
ioutch  	=        	p11

aflt1   	init     	0
aflt2   	init     	0

asig1   	zar      	iinch
asig    	reverb2  	asig1, .5, 1
;asig    	zar      	iinch

adel1   	delay    	asig+(aflt1-aflt2)*ifdbk, itim1
adel2   	delay    	asig+(aflt2-aflt1)*ifdbk, itim2

aflt1   	pareq     adel1, ifco1, .5, .4, 2
aflt2   	pareq     adel2, ifco2, .5, .4, 2

;aout    	butterhp 	arvb, 140 						; COMBINE OUTPUTS
aout    	butterhp 	aflt1+aflt2, 140
        	zaw      	aout, ioutch

        	endin

;----------------------------------------------------------------------------------
; Output For Mono Reverb
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
; OUTPUT FOR STEREO REVERB
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
; CLEAR ZAK
;----------------------------------------------------------------------------------
       	instr   99
       	zacl    	0,30
       	endin

