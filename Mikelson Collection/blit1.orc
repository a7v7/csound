;---------------------------------------------------------------------------------
; A SET OF BAND LIMITED INSTRUMENTS WITH RESONANT FILTER
; BY HANS MIKELSON 11/20/97
; PARTIALLY DERIVED FROM CODE BY JOSEP Mª COMAJUNCOSAS-CSOUND & TIM STILSON-CCRMA
;---------------------------------------------------------------------------------
sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls	=		2

		zakinit 	30, 30
gifqcadj	=		6600
			
;---------------------------------------------------------------------------------
; LOW FREQUENCY OSCILLATOR
       	instr    1

iamp   	=        p4
ilfo   	=        p5
iwave  	=        p6
ioutch 	=        p7

klfo   	oscil    iamp, ilfo, iwave
       	zkw      klfo, ioutch

	 	endin

;---------------------------------------------------------------------------------
; ENVELOPE
       	instr    2

idur   	=        p3
iamp   	=        p4
ishape 	=        p5
ioutch 	=        p6

kenv   	oscil    iamp, 1/idur, ishape
       	zkw      kenv, ioutch

       	endin

;---------------------------------------------------------------------------------
; OSCILLATOR SYNCH (BAND LIMITED IMPULSE TRAIN)
        	instr   10

idur    	=       p3
iamp    	=       p4*10
ifqc    	=       cpspch(p5)
iampenv 	=       p6
ifcotab 	=       p7
ireztab 	=       p8
ifcoch  	=       p9
irezch  	=       p10
ilfoch  	=       p11
ipanl   	=       sqrt(p12)
ipanr   	=       sqrt(1-p12)
krms    	init    0

kdclik 	linseg  0, .002, iamp, idur-.004, iamp, .002, 0
kamp   	oscil   kdclik, 1/idur, iampenv 
kfcoe  	oscil   1, 1/idur, ifcotab
kreze  	oscil   1, 1/idur, ireztab
kfcoc  	zkr     ifcoch
krezc  	zkr     irezch
kfco   	=       kfcoe*kfcoc
krez   	=       kreze*krezc
	
klfo   	zkr     ilfoch
kfqc   	=       ifqc+klfo
kfco   	oscil   1, 1/idur, ifcotab
krez   	oscil   1, 1/idur, ireztab

apulse1 	buzz    1, ifqc, sr/2/ifqc, 1  ; Avoid aliasing
apulse2 	buzz    1, ifqc*1.02, sr/2/ifqc*1.02, 1  ; Avoid aliasing
asaw1dc 	integ   apulse1
asaw2dc 	integ   apulse2

aosyncdc 	integ   apulse1*abs(1-asaw2dc)+apulse2*abs(1-asaw1dc)
aosync   	=       aosyncdc             ; Remove DC offset
axn     	butterhp    aosync, 20

; RESONANT LOWPASS FILTER (4 POLE)
ka1    	=       gifqcadj/krez/kfco-1
ka2    	=       gifqcadj/kfco
kasq   	=       ka2*ka2
kb     	=       1+ka1+kasq

ayn    	nlfilt  axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
ayn2   	nlfilt  ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

       	outs    kamp*ayn2*ipanl, kamp*ayn2*ipanr
       	endin

;---------------------------------------------------------------------------------
; OSCILLATOR SYNCH (BAND LIMITED IMPULSE TRAIN)
        instr   11

idur    	=       p3
iamp    	=       p4*10
ifqc    	=       cpspch(p5)
iampenv 	=       p6
ifcotab 	=       p7
ireztab 	=       p8
ifcoch  	=       p9
irezch  	=       p10
ilfoch  	=       p11
ipanl   	=       sqrt(p12)
ipanr   	=       sqrt(1-p12)
krms    	init    0

kdclik 	linseg   0, .002, iamp, idur-.004, iamp, .002, 0
kamp   	oscil    kdclik, 1/idur, iampenv 
kfcoe  	oscil    1, 1/idur, ifcotab
kreze  	oscil    1, 1/idur, ireztab
kfcoc  	zkr      ifcoch
krezc  	zkr      irezch
kfco   	=        kfcoe*kfcoc
krez   	=        kreze*krezc

klfo   	zkr      ilfoch
kfqc   	=        ifqc+klfo
kfco   	oscil    1, 1/idur, ifcotab
krez   	oscil    1, 1/idur, ireztab

apulse1 	buzz    1, ifqc, sr/2/ifqc, 1  ; Avoid aliasing
apulse2 	buzz    1, ifqc*1.02, sr/2/ifqc*1.02, 1  ; Avoid aliasing
asaw1dc 	integ   apulse1
asaw2dc 	integ   apulse2

aosyncdc 	integ   apulse1*abs(1-asaw2dc)+apulse2*abs(1-asaw1dc)
aosync   	=       aosyncdc             ; Remove DC offset
axn     	butterhp    asaw1dc-.5, 20

; RESONANT LOWPASS FILTER (4 POLE)
ka1    	=        gifqcadj/krez/kfco-1
ka2    	=        gifqcadj/kfco
kasq   	=        ka2*ka2
kb     	=        1+ka1+kasq

ayn    	nlfilt   axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
ayn2   	nlfilt   ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

       	outs     kamp*ayn2*ipanl, kamp*ayn2*ipanr
       	endin

