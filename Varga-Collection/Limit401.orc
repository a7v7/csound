sr	=  44100
kr	=  44100
ksmps	=  1
nchnls	=  1

#define INPUTFILE # "infile.sf" #

	instr 1

iamp	table	0,64	; output gain
imax1	table	1,64	; max. level
idel1	table	2,64	; delay time in sec.
idec1	table	3,64	; decay speed
iatt1	table	4,64	; attack speed
ifrq1	table	5,64	; lowpass filter freq.
imax1	=  imax1*32768
klv01	init 0

ad1	soundin $INPUTFILE		; sound input
a1	soundin $INPUTFILE,idel1

klx	downsamp abs(a1)
ktmp	=  (klx>klv01 ? idec1:iatt1)
klv01	=  klv01+(klx-klv01)*ktmp
al1	upsamp klv01
al1	butterlp al1,ifrq1
klv01x	downsamp al1

a1	=  (klv01x<imax1 ? ad1:ad1*imax1/klv01x)

	out a1*iamp

	endin

