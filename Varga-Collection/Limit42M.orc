sr	=  44100
kr	=  44100
ksmps	=  1
nchnls	=  2
massign	1,1

#define INPUTFILE # "infile.sf" #

;	MIDI controllers:
;
;  max. level	:	20	(0..127: 0..1)	k-rate
;  out. volume	:	7	(0..127: 0..1)	k-rate

	instr 1

;------------------------------------------------------------------------------
iamp	table	0,64	; output gain
imax1	table	1,64	; 1. max. level			1st limiter
idel1	table	2,64	; 1. delay time in ms
idec1	table	3,64	; 1. decay speed
iatt1	table	4,64	; 1. attack speed
ifrq1	table	5,64	; 1. lowpass filter freq.
imax2	table	6,64	; 2. max. level			2nd limiter
idel2	table	7,64	; 2. delay time in ms
idec2	table	8,64	; 2. decay speed
iatt2	table	9,64	; 2. attack speed
ifrq2	table	10,64	; 2. lowpass filter freq.
;---------------------------------------------------------------
a1,a2	soundin $INPUTFILE	; sound input
;---------------------------------------------------------------

i001	=  32768
idel1	=  idel1*0.001
idel2	=  idel2*0.001
imax1	=  imax1*i001
imax2	=  imax2*i001
iampm1	imidic7 7,0,1,232
imaxm1	imidic7 20,0,1,232
klv01	init 0
klv02	init 0
kcnt1	init 0

x9999:

iampm0	=  iampm1
imaxm0	=  imaxm1
iampm1	imidic7 7,0,1,232
imaxm1	imidic7 20,0,1,232
kmaxm	linseg imaxm0,0.00952381,imaxm1
kampm	linseg iampm0,0.00952381,iampm1
kcnt1	=  kcnt1+1

	if kcnt1<419.5 goto x9998
	reinit x9999
	rireturn

x9998:

kcnt1	=  (kcnt1>419.5 ? 0:kcnt1)
kmax1	=  kmaxm*imax1
kmax2	=  kmaxm*imax2
kamp	=  kampm*iamp

ad1	delay a1,idel1			; 1. limiter
ad2	delay a2,idel1

klx1	downsamp abs(a1)
klx2	downsamp abs(a2)
klx	=  (klx1>klx2 ? klx1:klx2)
klv01	=  (klx>klv01 ? klv01+(klx-klv01)*idec1:klv01+(klx-klv01)*iatt1)
al1	upsamp klv01
al1	butterlp al1,ifrq1
klv01x	downsamp al1

a1	=  (klv01x<kmax1 ? ad1:ad1*kmax1/klv01x)
a2	=  (klv01x<kmax1 ? ad2:ad2*kmax1/klv01x)

ad1	delay a1,idel2			; 2. limiter
ad2	delay a2,idel2

klx1	downsamp abs(a1)
klx2	downsamp abs(a2)
klx	=  (klx1>klx2 ? klx1:klx2)
klv02	=  (klx>klv02 ? klv02+(klx-klv02)*idec2:klv02+(klx-klv02)*iatt2)
al1	upsamp klv02
al1	butterlp al1,ifrq2
klv02x	downsamp al1

ad1	=  (klv02x<kmax2 ? ad1:ad1*kmax2/klv02x)
ad2	=  (klv02x<kmax2 ? ad2:ad2*kmax2/klv02x)

	outs ad1*kamp,ad2*kamp

	endin

	instr 90
	endin

