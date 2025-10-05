sr	=  44100
kr	=  44100
ksmps	=  1
nchnls	=  2

#define INPUTFILE # "infile.sf" #

	instr 1

iamp	table	0,64	; output gain
iHPf	table	1,64	; min. freq.
iLPf	table	2,64	; max. freq.
imax1	table	3,64	; max. level
iampx	table	4,64	; compressed band gain
idel1	table	5,64	; delay time in sec.
idec1	table	6,64	; decay speed
iatt1	table	7,64	; attack speed
ifrq1	table	8,64	; lowpass filter freq.
imax1	=  imax1*32768
klv01	init 0

ad1x,ad2x	soundin $INPUTFILE		; sound input
ad1	butterhp ad1x,iHPf
ad1	butterlp ad1,iLPf
ad1x	=  ad1x-ad1
ad2	butterhp ad2x,iHPf
ad2	butterlp ad2,iLPf
ad2x	=  ad2x-ad2
a1x,a2x	soundin $INPUTFILE,idel1
a1	butterhp a1x,iHPf
a1	butterlp a1,iLPf
a2	butterhp a2x,iHPf
a2	butterlp a2,iLPf

klx1	downsamp abs(a1)
klx2	downsamp abs(a2)
klx	=  (klx1>klx2 ? klx1:klx2)
ktmp	=  (klx>klv01 ? idec1:iatt1)
klv01	=  klv01+(klx-klv01)*ktmp
al1	upsamp klv01
al1	butterlp al1,ifrq1
klv01x	downsamp al1

a1	=  (klv01x<imax1 ? ad1:ad1*imax1/klv01x)
a2	=  (klv01x<imax1 ? ad2:ad2*imax1/klv01x)

	outs (iampx*a1+ad1x)*iamp,(iampx*a2+ad2x)*iamp

	endin

