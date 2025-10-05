;---------------------------------------------------------------------------
; CHORUS EFFECTS
;---------------------------------------------------------------------------

sr		=		44100
kr		=		22050
ksmps	=		2
nchnls	=		2

		zakinit 	30, 30

;---------------------------------------------------------------------------
; PLUCK PHYSICAL MODEL
;---------------------------------------------------------------------------
       	instr  2

iamp   	=      	p4          ; AMPLITUDE
ifqc   	=      	cpspch(p5)  ; CONVERT TO FREQUENCY
itab1  	=      	p6          ; INITIAL TABLE
imeth  	=      	p7          ; DECAY METHOD
ioutch 	=      	p8          ; OUTPUT CHANNEL

aplk   	pluck  	iamp, ifqc, ifqc, itab1, imeth       ; PLUCK WAVEGUIDE MODEL
       	zawm   	aplk, ioutch                         ; WRITE TO OUTPUT
       	endin

;---------------------------------------------------------------------------
; LFO
;---------------------------------------------------------------------------
          instr   7
iamp      init    	p4
ifqc      init    	p5
itab1     init    	p6
iphase    init    	p7
ioffset   init    	p8
iout      init    	p9

koscil    oscil   	iamp, ifqc, itab1, iphase  		  ;TABLE OSCILLATOR
kout      =       	koscil+ioffset

          zkw     	kout, iout           			  ;SEND TO OUTPUT CHANNEL

          endin

;---------------------------------------------------------------------------
;LORENZ ATTRACTOR
;---------------------------------------------------------------------------
        	instr  8

iamp    	init   	p4/40
kx      	init   	p5
ky      	init   	p6
kz      	init   	p7
is      	init   	p8
ir      	init   	p9
ib      	init   	p10
ih      	init   	p11/10000
ioutch  	init   	p12
ioffset 	init   	p13

kxnew   	=      	kx+ih*is*(ky-kx)
kynew   	=      	ky+ih*(-kx*kz+ir*kx-ky)
kznew   	=      	kz+ih*(kx*ky-ib*kz)
	
kx      	=      	kxnew
ky      	=      	kynew
kz      	=      	kznew

		printk   .5, kx
		printk   .5, ky
		printk   .5, kz

        	zkw    	kx*iamp+ioffset, ioutch
        	endin

;---------------------------------------------------------------------------
; CHORUS
;---------------------------------------------------------------------------
         instr   35
									
imixch   	=       	p4             		; MIX OF CHORUSED SIGNAL
imix     	=       	1-imixch       		; MIX OF DIRECT SIGNAL
izin     	=       	p5            			; INPUT CHANNEL
izout    	=       	p6            			; OUTPUT CHANNEL
ikin     	=       	p7            			; INPUT K CHANNEL

asig     	zar     	izin           		; READ INPUT CHANNEL
kinsig   	zkr     	ikin           		; READ K INPUT

adel1    	vdelay  	asig, kinsig, 100      	; VARIABLE DELAY TAP
aout     	=       	adel1*imixch+asig*imix 	; MIX DIRECT AND CHORUSED SIGNALS

;aout     =       	kinsig*500
         	zaw     	aout, izout            	; WRITE TO OUTPUT CHANNEL

         	endin

;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
          instr 100

asig1     zar   	p4             		; READ INPUT CHANNEL 1
igl1      init  	p5*sqrt(p6)    		; LEFT GAIN
igr1      init  	p5*sqrt(1-p6)  		; RIGHT GAIN

kdclick   linseg  	0, .001, 1, p3-.002, 1, .001, 0  ; DECLICK

asigl     =     	asig1*igl1       		; SCALE AND SUM
asigr     =     	asig1*igr1

          outs  	kdclick*asigl, kdclick*asigr   ; OUTPUT STEREO PAIR

          endin

;---------------------------------------------------------------------------
; CLEAR AUDIO & CONTROL CHANNELS
;---------------------------------------------------------------------------
          instr 	110

          zacl  	0, 30          		; CLEAR AUDIO CHANNELS 0 TO 30
          zkcl  	0, 30          		; CLEAR CONTROL CHANNELS 0 TO 30

          endin

